import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';

class MainButtonWidget extends StatelessWidget {
  const MainButtonWidget({
    required this.label,
    super.key,
    this.buttonColor,
    this.width,
    this.height,
    this.iconSize,
    this.rightIcon,
    this.leftIcon,
    this.fontSize,
    this.style,
    this.shadowColor = AppColorsNew.shadowPrimary,
    this.borderColor,
    this.borderWidth,
    this.onTap,
    this.isPrimary = true,
    this.isCenter = true,
    this.isBlack = false,
    this.gradient,
  });

  final Color? buttonColor;
  final Color shadowColor;
  final Color? borderColor;
  final double? borderWidth;
  final bool isPrimary;
  final bool isBlack;
  final bool isCenter;
  final double? width;
  final double? height;
  final Gradient? gradient;
  final Widget? rightIcon;
  final Widget? leftIcon;
  final String label;
  final double? fontSize;
  final TextStyle? style;
  final double? iconSize;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: isCenter ? null : 1,
      widthFactor: isCenter ? null : 1,
      child: TvClickButton(
        onTap: onTap ?? () {},
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Container(
            height: height ?? (1.sw > 1100 ? 60.r : 50.r),
            width: width ?? double.infinity,
            decoration: BoxDecoration(
              color: buttonColor != null
                  ? buttonColor
                  : isBlack
                      ? Theme.of(context).dialogTheme.shadowColor
                      : null,
              border: Border.all(
                width: borderWidth ?? 0.1,
                color: borderColor ?? AppColorsNew.white.withValues(alpha: 0.2),
              ),
              gradient: buttonColor != null
                  ? null
                  : isBlack
                      ? null
                      : gradient ??
                          LinearGradient(
                            colors: [
                              if (isPrimary)
                                AppColorsNew.blue4
                              else
                                AppColorsNew.orange3, // Starting color
                              if (isPrimary)
                                AppColorsNew.blue2
                              else
                                AppColorsNew.orange4, // Ending color
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (rightIcon != null) rightIcon!,
                  SizedBox(width: 12.r),
                  Text(
                    label,
                    style: style ??
                        AppTextStylesNew.style18BoldAlmarai.copyWith(
                          color: isBlack
                              ? Theme.of(context).iconTheme.color
                              : AppColorsNew.white1,
                          fontSize: fontSize,
                        ),
                  ),
                  SizedBox(width: 12.r),
                  if (leftIcon != null) leftIcon!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
