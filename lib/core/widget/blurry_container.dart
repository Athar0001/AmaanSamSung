import 'package:flutter/material.dart';

class BlurryContainer extends StatelessWidget {
  const BlurryContainer({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.borderRadius,
    this.border,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? Colors.black.withOpacity(0.5),
        borderRadius: borderRadius,
        border: border,
      ),
      child: child,
    );
  }
}
