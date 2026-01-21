import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TvPrimaryButton extends StatelessWidget {
  const TvPrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
    this.width,
    this.height,
  });

  final String text;
  final VoidCallback onTap;
  final IconData? icon;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return TvClickButton(
      onTap: onTap,
      focusScale: 1.05,
      builder: (context, hasFocus) {
        return Container(
          width: width,
          height: height ?? 45.h,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          decoration: BoxDecoration(
            color: hasFocus ? AppColorsNew.white : AppColorsNew.primary,
            borderRadius: BorderRadius.circular(50.r), // Pill shape
            border: hasFocus
                ? Border.all(color: AppColorsNew.primary, width: 2)
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: hasFocus ? AppColorsNew.primary : AppColorsNew.white,
                  size: 20.sp,
                ),
                8.horizontalSpace,
              ],
              Text(
                text,
                style: AppTextStylesNew.style14BoldAlmarai.copyWith(
                  color: hasFocus ? AppColorsNew.primary : AppColorsNew.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
