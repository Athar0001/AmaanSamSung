import 'dart:async';
import 'dart:developer' as developer;
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/error/failure.dart';
import '../../../core/injection/injection_imports.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/cash_services/cashe_helper.dart';
import '../data/data_source/auth_service.dart';
import '../data/models/login_model.dart';

class UserNotifier with ChangeNotifier {
  UserNotifier(this.authService) {
    developer.log('UserNotifier initialized.', name: 'UserNotifier');
  }

  static final instance = sl<UserNotifier>();
  UserData? _userData;
  Timer? _refreshTimer;

  UserData? get userData => _userData;

  bool get isLogin => userData != null;

  set userData(UserData? newUserData) {
    // Optimization: Only notify listeners if the user data has actually changed.
    // This requires UserData to have a proper equality check (== and hashCode).
    // If UserData doesn't override == and hashCode, this check will only be true
    // if the object identity is different, which is usually the case for new data.
    // For more robust checking, ensure UserData implements value equality.
    if (_userData != newUserData) {
      _userData = newUserData;
      developer.log(
        newUserData == null ? 'User data cleared.' : 'User data updated.',
        name: 'UserNotifier',
      );
      _scheduleTokenRefresh();
      notifyListeners();
    }
  }

  final AuthService authService;

  // Constants for retry logic
  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(seconds: 1);

  Future<void> init() async {
    developer.log(
      'UserNotifier init: Loading user from CacheHelper.',
      name: 'UserNotifier',
    );
    // Potentially, CacheHelper.currentUser could be an expensive operation.
    // If it involves synchronous disk I/O on startup, consider making it async
    // or ensuring it's very fast. For now, we assume it's efficient.
    userData = _currentCachedUser;
    final hasPhone = userData?.hasPhone;
    // trigger refresh user data if user has no phone
    if (hasPhone != null && !hasPhone) {
      developer.log(
        'User has no phone. Refreshing user data to check for changes.',
        name: 'UserNotifier',
      );
      await refreshUser();
    }
  }

  Future<void> refreshUser() async {
    developer.log('Refreshing user data.', name: 'UserNotifier');
    return _refreshToken();
  }

  void login(UserData data) {
    developer.log(
      'Login successful for user: ${data.userId}',
      name: 'UserNotifier',
    );
    userData = data;
    _saveCurrentUser(data);
  }

  Future<void> logout() async {
    developer.log('Logout initiated.', name: 'UserNotifier');
    // It's good practice to not await for the remote call
    // as the local session should be cleared regardless of the API call result.
    authService.logout().catchError((Object error) {
      // Optionally log if the server-side logout fails, but don't block clearing local session.
      developer.log(
        'Server-side logout failed: $error',
        name: 'UserNotifier',
        error: error,
      );
      // Return a Left Failure to satisfy the Either<Failure, bool> type
      return Left<Failure, bool>(Failure(code: -1, message: error.toString()));
    });
    _clearSession();
  }

  void _clearSession() {
    developer.log('Clearing local session.', name: 'UserNotifier');
    _removeCurrentUser();
    // Setting userData to null will trigger the setter, which calls notifyListeners
    // and cancels/schedules token refresh (though it won't schedule if userData is null).
    // This will call the setter
    userData = null;

    // Ensure timer is cancelled if userData setter didn't run due to being already null
    _refreshTimer?.cancel();
    _refreshTimer = null;

    // Ensure navigation happens on the UI thread safely.
    // This is generally a good pattern.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (appNavigatorKey.currentContext != null) {
        developer.log(
          'Navigating to Login screen after logout.',
          name: 'UserNotifier',
        );
        appNavigatorKey.currentContext!.goNamed(AppRoutes.qrLogin.routeName);
      } else {
        developer.log(
          'Cannot navigate to Login: currentContext is null.',
          name: 'UserNotifier',
        );
      }
    });
  }

  void _scheduleTokenRefresh() {
    _refreshTimer?.cancel();
    // Explicitly nullify before potentially returning
    _refreshTimer = null;

    if (userData?.expiresOn == null) {
      developer.log(
        'Token refresh scheduling skipped: No user data or expiration.',
        name: 'UserNotifier',
      );
      return;
    }

    // Refresh the token 2 days before it expires.
    final refreshTime = userData!.expiresOn!.subtract(const Duration(days: 2));
    final now = DateTime.now();

    Duration durationUntilRefresh;
    if (refreshTime.isBefore(now)) {
      // If the refresh time is in the past, schedule it to run almost immediately.
      durationUntilRefresh = const Duration(
        seconds: 1,
      ); // Or Duration.zero for immediate async execution
      developer.log(
        'Token is past refresh time or very close to expiring. Scheduling immediate refresh.',
        name: 'UserNotifier',
      );
    } else {
      // Otherwise, schedule it for the calculated time.
      durationUntilRefresh = refreshTime.difference(now);
      developer.log(
        'Token refresh scheduled in $durationUntilRefresh.',
        name: 'UserNotifier',
      );
    }

    _refreshTimer = Timer(durationUntilRefresh, () {
      developer.log(
        'Timer fired. Attempting to refresh token.',
        name: 'UserNotifier',
      );
      _refreshToken();
    });
  }

  Future<void> _refreshToken({int retryAttempt = 0}) async {
    if (userData?.refreshToken == null) {
      developer.log(
        'Cannot refresh token: No refresh token available. Logging out.',
        name: 'UserNotifier',
      );
      // No need to await logout here as this is an internal state adjustment
      logout();
      return;
    }

    developer.log(
      'Attempting token refresh (Attempt ${retryAttempt + 1}/$_maxRetries).',
      name: 'UserNotifier',
    );
    final startTime = DateTime.now(); // For measuring duration

    try {
      final loginModel = await authService.refreshToken(
        userData!.refreshToken!,
      );
      final duration = DateTime.now().difference(startTime);
      developer.log(
        'Token refresh successful in ${duration.inMilliseconds}ms.',
        name: 'UserNotifier',
      );
      // On success, log in with the new data, which will also reschedule the next refresh.
      login(loginModel);
    } catch (e, stackTrace) {
      final duration = DateTime.now().difference(startTime);
      developer.log(
        'Token refresh failed (Attempt ${retryAttempt + 1}/$_maxRetries) after ${duration.inMilliseconds}ms: $e',
        name: 'UserNotifier',
        error: e,
        stackTrace: stackTrace,
      );
      // If refreshing fails...
      if (retryAttempt < _maxRetries - 1) {
        // Corrected condition to match _maxRetries
        // ...and we have retries left, wait and try again.
        developer.log(
          'Retrying token refresh after $_retryDelay.',
          name: 'UserNotifier',
        );
        await Future<void>.delayed(_retryDelay);
        await _refreshToken(retryAttempt: retryAttempt + 1);
      } else {
        // ...and we're out of retries, log the user out.
        developer.log(
          'Max token refresh retries reached. Logging out.',
          name: 'UserNotifier',
        );
        logout(); // No need to await
      }
    }
  }

  @override
  void dispose() {
    developer.log(
      'UserNotifier disposing. Cancelling refresh timer.',
      name: 'UserNotifier',
    );
    _refreshTimer?.cancel();
    super.dispose();
  }

  ///////////////////////////////////////
  ///////// Cache user Data /////////////
  //////////////////////////////////////
  final String _loginInfoKey = 'loginInfo';

  UserData? get _currentCachedUser {
    //get cached user data
    final loginInfo = CacheHelper.getData<String>(key: _loginInfoKey);
    try {
      if (loginInfo != null && loginInfo.isNotEmpty) {
        return UserData.fromString(loginInfo);
      }
    } catch (e, st) {
      developer.log(e.toString(), stackTrace: st, name: 'currentUser');
    }
    return null;
  }

  Future<void> _saveCurrentUser(UserData user) async {
    await CacheHelper.saveData(key: _loginInfoKey, value: user.toString());
  }

  Future<void> _removeCurrentUser() async {
    await CacheHelper.removeData(key: _loginInfoKey);
  }
}
