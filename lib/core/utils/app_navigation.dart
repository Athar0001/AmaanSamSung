import 'package:flutter/material.dart';

class AppNavigation {
  static Future<T?> navigationPush<T>(
    BuildContext context, {
    required Widget screen,
  }) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  // Add other methods if they are called in Home Screen, e.g. pushNamed
}
