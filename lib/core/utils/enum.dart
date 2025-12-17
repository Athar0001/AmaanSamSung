import 'package:flutter/material.dart';

enum AppState {
  init,
  loading,
  success,
  error;

  void errorMsg({required String error}) {
    // Basic error logging or handling
    debugPrint("Error: $error");
  }
}
