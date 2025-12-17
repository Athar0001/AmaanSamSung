import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';

import '../Themes/app_colors_new.dart';

class AppToast {
  static void show(
    String message, {
    ToastTime toastTime = ToastTime.long,
    ToastPosition position = ToastPosition.bottom,
    Color? backgroundColor,
    Color textColor = Colors.white,
    double? fontSize,
  }) {
    if (message.isEmpty) return;

    if (message == 'ContentNotReleasedYet') {
      message = AppLocalization.strings.showNotReleasedYet;
    }

    toastification.show(
      title: Text(
        message,
        style: TextStyle(color: textColor, fontSize: fontSize ?? 16),
      ),
      autoCloseDuration: toastTime.duration,
      alignment: position.alignment,
      style: ToastificationStyle.fillColored,
      primaryColor: backgroundColor ?? AppColorsNew.red5,
      backgroundColor: backgroundColor ?? AppColorsNew.red5,
      foregroundColor: textColor,
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.none,
      boxShadow: const [
        BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
      ],
    );
  }
}

enum ToastPosition {
  top(Alignment.topCenter),
  center(Alignment.center),
  bottom(Alignment.bottomCenter);

  const ToastPosition(this.alignment);

  final Alignment alignment;
}

enum ToastTime {
  long(Duration(seconds: 4)),
  short(Duration(seconds: 2));

  const ToastTime(this.duration);

  final Duration duration;
}
