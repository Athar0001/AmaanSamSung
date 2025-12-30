import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Themes/app_colors_new.dart';
import 'package:amaan_tv/core/widget/blurry_container.dart';

class IconContainer<T> extends StatelessWidget {
  const IconContainer({
    required this.child,
    super.key,
    this.isBlack = false,
    this.result,
    this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;
  final bool isBlack;
  final T? result;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TvClickButton(
      behavior: HitTestBehavior.translucent,
      onTap: onTap ?? () {},
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: SizedBox(
            height: 39.r,
            width: 39.r,
            child: BlurryContainer(
              padding: EdgeInsets.zero,
              color: isBlack
                  ? AppColorsNew.blackColor.withOpacity(.4)
                  : isDark
                      ? AppColorsNew.white.withOpacity(.1)
                      : AppColorsNew.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: !isDark
                    ? Colors.transparent
                    : AppColorsNew.black1.withOpacity(0.1),
              ),
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
