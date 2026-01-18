import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:amaan_tv/Features/Auth/data/models/login_model.dart';
import 'package:amaan_tv/Features/Auth/data/data_source/auth_service.dart';
import 'package:amaan_tv/core/error/failure.dart';
import 'package:amaan_tv/core/utils/api/api_service.dart';

class UserNotifier with ChangeNotifier {
  static final UserNotifier instance = UserNotifier._internal();

  UserData? _userData;
  late final AuthService _authService;

  UserNotifier._internal() {
    // Initialize with dummy data
    _userData = UserData(id: 1, name: "Amaan TV User");
    _authService = AuthService(ApiService.getInstance());
  }

  // Factory constructor for external use (e.g., Provider)
  factory UserNotifier() => instance;

  UserData? get userData => _userData;
  bool get isLogin => _userData != null;

  Future<void> refreshUser() async {
    // No-op
  }

  Future<Either<Failure, bool>> logout() async {
    final result = await _authService.logout();
    result.fold(
      (failure) => null,
      (success) {
        _userData = null;
        notifyListeners();
      },
    );
    return result;
  }

  String? genderOfChild;
  void selectChild(String label) {
    genderOfChild = label;
    notifyListeners();
  }
}
