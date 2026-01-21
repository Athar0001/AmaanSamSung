import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TvSecondaryButton extends StatelessWidget {
  const TvSecondaryButton({
    super.key,
    this.text,
    required this.onTap,
    this.icon,
    this.isCircle = false,
  });

  final String? text;
  final VoidCallback onTap;
  final IconData? icon;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    return TvClickButton(
      onTap: onTap,
      focusScale: 1.1,
      builder: (context, hasFocus) {
        if (isCircle && icon != null) {
          return Container(
            width: 45.w,
            height: 45.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: hasFocus ? AppColorsNew.white : Colors.transparent,
              border: Border.all(
                color: AppColorsNew.white,
                width: 1.5,
              ),
            ),
            child: Icon(
              icon,
              color: hasFocus ? AppColorsNew.blackColor : AppColorsNew.white,
              size: 20.sp,
            ),
          );
        }

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: hasFocus ? AppColorsNew.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: AppColorsNew.white,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  color:
                      hasFocus ? AppColorsNew.blackColor : AppColorsNew.white,
                  size: 24.sp,
                ),
              if (text != null) ...[
                if (icon != null) 4.verticalSpace,
                Text(
                  text!,
                  style: AppTextStylesNew.style12BoldAlmarai.copyWith(
                    color:
                        hasFocus ? AppColorsNew.blackColor : AppColorsNew.white,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
