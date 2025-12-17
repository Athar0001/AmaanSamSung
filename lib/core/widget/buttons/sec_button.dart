import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';

import 'package:amaan_tv/core/widget/SVG_Image/svg_img.dart';

class SeceonderyButtonWidget extends StatelessWidget {
  const SeceonderyButtonWidget({
    required this.label,
    super.key,
    this.buttonColor,
    this.width,
    this.height,
    this.iconSize,
    this.rightIcon,
    this.leftIcon,
    this.fontSize,
    this.textColor,
    this.onTap,
    this.padding,
    this.isPrimary = true,
  });

  final Color? buttonColor;
  final Color? textColor;
  final bool isPrimary;
  final double? width;
  final double? height;
  final String? rightIcon;
  final Widget? leftIcon;
  final String label;
  final double? fontSize;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: height ?? 50.h,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (isDark
              ? AppColorsNew.white1.withOpacity(0.1)
              : AppColorsNew.black1.withOpacity(0.1)),
        ),
        color:
            buttonColor ??
            (isDark
                ? AppColorsNew.white1.withOpacity(0.05)
                : AppColorsNew.white1.withOpacity(0.8)),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: padding,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (rightIcon != null)
              SVGImage(
                path: rightIcon!,
                color: buttonColor == null
                    ? (isDark ? AppColorsNew.grey2 : AppColorsNew.grey4)
                    : AppColorsNew.white1,
              )
            else
              const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                label,
                style: AppTextStylesNew.style14RegularAlmarai.copyWith(
                  color:
                      textColor ??
                      (buttonColor == null
                          ? isDark
                                ? AppColorsNew.grey2
                                : AppColorsNew.grey4
                          : AppColorsNew.white1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
