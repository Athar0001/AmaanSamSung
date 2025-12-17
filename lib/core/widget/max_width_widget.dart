import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MaxWidthWidget extends StatelessWidget {
  const MaxWidthWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = math.min(constraints.maxWidth, 700.r);
      return SizedBox(
        width: width,
        child: child,
      );
    });
  }
}
