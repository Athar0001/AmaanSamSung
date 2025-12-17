import 'package:flutter/material.dart';

class GridConfig {
  static const int crossAxisCount = 2;
  static const double childAspectRatio = 0.7;

  static SliverGridDelegateWithFixedCrossAxisCount getDefaultGridDelegate() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
    );
  }
}
