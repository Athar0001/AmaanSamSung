import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
//import 'package:amaan_tv/Features/Auth/presentation/widget/request_login_dialog.dart';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/core/error/app_error_type.dart';
import 'package:amaan_tv/core/utils/api/end_point.dart';
import 'package:amaan_tv/core/utils/app_router.dart';
import 'package:provider/provider.dart';
import 'failure.dart';

/// Handles errors and transforms them into a [Failure] object.
///
/// This class is designed to catch various types of errors, particularly those
/// originating from network requests made with the Dio package. It logs the error
/// and then processes the error to create a standardized [Failure] object that can be used
/// throughout the application for consistent error handling.
class ErrorHandler implements Exception {
  /// Creates an [ErrorHandler] and processes the given [error].
  ///
  /// The [error] is logged and then converted into a [Failure] object.
  ///
  /// - [error]: The error to be handled. This can be any dynamic type, but
  ///   it's specifically designed to handle [DioException].
  /// - [st]: An optional [StackTrace] associated with the error.
  ErrorHandler.handle(dynamic error, [StackTrace? st]) {
    // Log the error for debugging purposes.
    log(error.toString(), stackTrace: st, name: 'ErrorHandler');

    // Convert the error into a Failure object.
    failure = _getFailureFromResponse(error);
  }

  /// The [Failure] object representing the processed error.
  late final Failure failure;

  /// Converts a dynamic error into a [Failure] object.
  ///
  /// This method checks if the error is a [DioException]. If not, it returns a
  /// default [Failure]. Otherwise, it extracts information from the [DioException]'s
  /// response to create a more specific [Failure].
  ///
  /// - [error]: The error to be converted.
  /// - Returns: A [Failure] object representing the error.
  Failure _getFailureFromResponse(dynamic error) {
    /// If the error is not a DioException, return a default failure.
    if (error is! DioException) return AppErrorType.DEFAULT.getFailure();

    /// If the response is null, return a default failure.
    /// If the status code is null, return a default failure.
    final response = error.response;
    if (response == null || response.statusCode == null) {
      return AppErrorType.DEFAULT.getFailure();
    }

    // Extract the error message from the response.
    late final errorMessage = _getErrorMessage(response);
    // Extract the error code from the response data.
    final errorCode = ErrorCode.fromData(response.data);

    // Potentially show a "request login" dialog based on the error.
    _showRequestLoginDialog(response);

    // Create and return the Failure object.
    return Failure(
      code: response.statusCode ?? ResponseCode.DEFAULT,
      message: errorMessage ?? AppErrorType.DEFAULT.message,
      errorCode: errorCode,
    );
  }
}

/// Shows a "request login" dialog if the error response indicates an
/// unauthorized status (HTTP 401) and certain conditions are met.
///
/// This function checks if:
/// 1. The HTTP status code is 401 (Unauthorized).
/// 2. The request endpoint is not in the `hideLoginDialogForEndPoints` list.
/// 3. The current context is available.
/// 4. The user is not already logged in (checked via `UserNotifier`).
///
/// If all conditions are true, it shows a [RequestLoginDialog].
///
/// - [response]: The [Response] object from the Dio request.
void _showRequestLoginDialog(Response<dynamic> response) {
  // List of endpoints for which the login dialog should not be shown.
  late final hideLoginDialogForEndPoints = <String>[
    EndPoint.generateDownloadUrl,
    EndPoint.login,
    EndPoint.logout,
    EndPoint.refreshTokenURL,
    EndPoint.suggestedSearch,
    EndPoint.getUserSubscriptionInfo,
    EndPoint.getInCompletedShows,
  ];

  // Determine if the current endpoint is one that should suppress the login dialog.
  late final doNotShowLoginDialog = hideLoginDialogForEndPoints.any(
    (endpoint) => response.realUri.path.contains(endpoint),
  );

  log('$doNotShowLoginDialog', name: 'doNotShowLoginDialog');

  // Get the current BuildContext.
  final context = appNavigatorKey.currentContext;

  // Check if the conditions for showing the dialog are met.
  if (response.statusCode == HttpStatus.unauthorized &&
      !doNotShowLoginDialog &&
      context != null) {
    // Check if the user is not already logged in.
    if (context.read<UserNotifier>().userData == null) {
      // Show the request login dialog.
      //RequestLoginDialog.show(appNavigatorKey.currentContext!);
    }
  }
}

/// Extracts an error message from a [Response] object.
///
/// It attempts to find an error message in the response data, looking for keys
/// like 'errorMessage' or 'message'. If no specific message is found in the
/// data, it falls back to the response's `statusMessage`.
///
/// - [response]: The [Response] object from the Dio request.
/// - Returns: The extracted error message as a [String], or `null` if no
///   message could be found.
String? _getErrorMessage(Response<dynamic> response) {
  String? errorMessage;
  // Check if the response data is a Map and contains 'errorMessage'.
  if (response.data is Map && response.data['errorMessage'] is String) {
    errorMessage = response.data['errorMessage'];
  }
  // Else, check if the response data is a Map and contains 'message'.
  else if (response.data is Map && response.data['message'] is String) {
    errorMessage = response.data['message'];
  }
  // Otherwise, use the response's status message.
  else {
    errorMessage = response.statusMessage;
  }
  return errorMessage;
}
