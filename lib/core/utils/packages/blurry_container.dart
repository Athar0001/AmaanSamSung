import 'package:flutter/material.dart';

class BlurryContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final BorderRadius? borderRadius;

  const BlurryContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.color,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(color: color, borderRadius: borderRadius),
      child: child,
    );
  }
}
