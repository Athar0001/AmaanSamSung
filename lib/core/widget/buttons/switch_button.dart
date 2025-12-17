import 'package:flutter/material.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({
    required this.value, super.key,
    this.onChanged,
  });
  final void Function(bool)? onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: AppColorsNew.white1,
      activeTrackColor: AppColorsNew.primary,
      inactiveThumbColor: AppColorsNew.white1,
      inactiveTrackColor: AppColorsNew.grey16,
      value: value,
      onChanged: onChanged,
    );
  }
}
