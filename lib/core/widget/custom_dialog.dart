import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    required this.content,
    super.key,
    this.removePadding = false,
  });
  final bool removePadding;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      insetPadding: EdgeInsets.all(16.r),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 500.r, maxHeight: 800.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: removePadding ? 0 : 16.r,
              ),
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
