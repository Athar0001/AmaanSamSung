import 'package:flutter/material.dart';

enum AppState {
  init,
  loading,
  success,
  error;

String get msg {
  switch (this) {
    case AppState.init:
      return 'Initial state';
    case AppState.loading:
      return 'Loading...';
    case AppState.success:
      return 'Success';
    case AppState.error:
      return _errorMsg ?? 'Error';
  }
}

static String? _errorMsg;

  void errorMsg({required String error}) {
    // Basic error logging or handling
    debugPrint("Error: $error");
    _errorMsg = error;
  }
}
