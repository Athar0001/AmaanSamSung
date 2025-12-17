import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';

import '../Themes/app_colors_new.dart';

class AppToast {
  static void show(
    String message, {
    ToastTime toastTime = ToastTime.long,
    ToastPosition position = ToastPosition.bottom,
    Color? backgroundColor,
    //ToastType toastType = ToastType.white,
    Color textColor = Colors.white,
    double? fontSize,
  }) {
    if (message.isEmpty) return;

    if (message == 'ContentNotReleasedYet') {
      message = AppLocalization.strings.showNotReleasedYet;
    }
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastTime.toastLength,
      gravity: position.toastGravity,
      backgroundColor: backgroundColor ?? AppColorsNew.red5,
      textColor: textColor,
      fontSize: fontSize ?? 16.r,
    );
  }
}

enum ToastPosition {
  top(ToastGravity.TOP),
  center(ToastGravity.CENTER),
  bottom(ToastGravity.BOTTOM);

  const ToastPosition(this.toastGravity);

  final ToastGravity toastGravity;
}

enum ToastTime {
  long(Toast.LENGTH_LONG),
  short(Toast.LENGTH_SHORT);

  const ToastTime(this.toastLength);

  final Toast toastLength;
}
