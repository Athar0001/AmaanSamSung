import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridConfig {
  static SliverGridDelegateWithFixedCrossAxisCount getDefaultGridDelegate({
    double? aspectRatio,
    double? mainAxisExtent,
    double? mainAxisSpacing,
    double? crossAxisSpacing,
    int? crossAxisCount,
  }) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount ?? 6,
      mainAxisSpacing: mainAxisSpacing ?? 16.r,
      crossAxisSpacing: crossAxisSpacing ?? 16.r,
      childAspectRatio: aspectRatio ?? 163 / 210,
      mainAxisExtent: mainAxisExtent,
    );
  }

  static EdgeInsets getDefaultPadding() {
    return EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.r);
  }
}

class GridConfigRadio {
  static SliverGridDelegateWithFixedCrossAxisCount getDefaultGridDelegate({
    double? aspectRatio,
    double? mainAxisExtent,
    double? mainAxisSpacing,
    double? crossAxisSpacing,
    int? crossAxisCount,
  }) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount:
          crossAxisCount ??
          (1.sw /
                  (1.sw > 1100
                      ? 300
                      : 1.sw > 600
                      ? 260
                      : 163.r))
              .toInt(),
      mainAxisSpacing: mainAxisSpacing ?? 16.r,
      crossAxisSpacing: crossAxisSpacing ?? 16.r,
      childAspectRatio:
          aspectRatio ??
          (1.sw > 1100
              ? (400 / 356)
              : 1.sw > 600
              ? (305 / 271)
              : (163 / 145)),
      mainAxisExtent: mainAxisExtent,
    );
  }

  static EdgeInsets getDefaultPadding() {
    return EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.r);
  }
}
