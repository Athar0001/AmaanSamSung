import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar responsiveAppBar({
  required BuildContext context,
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
  Color? backgroundColor,
  // ... any other AppBar properties you need ...
}) {
  final toolbarHeight = 56.r;
  final leadingWidth = 56.r;

  return AppBar(
    title: title,
    leading: leading,
    actions: actions,
    backgroundColor: backgroundColor,
    toolbarHeight: toolbarHeight,
    leadingWidth: leadingWidth,
    // ... other properties ...
  );
}
