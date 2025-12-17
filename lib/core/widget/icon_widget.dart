import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amaan_tv/core/utils/packages/blurry_container.dart';
import 'package:amaan_tv/core/widget/SVG_Image/svg_img.dart';
import 'package:provider/provider.dart';

import '../Themes/app_colors_new.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    required this.path,
    super.key,
    this.onTap,
    this.isBlack = true,
    this.iconHeight,
    this.iconWidth,
    this.iconColor,
    this.padding,
    this.borderRadius,
  });

  final String path;
  final bool isBlack;
  final VoidCallback? onTap;
  final double? iconHeight;
  final double? iconWidth;
  final double? padding;
  final double? borderRadius;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
            child: BlurryContainer(
              padding: EdgeInsets.all(padding ?? 7.r),
              color: isBlack
                  ? AppColorsNew.black2.withOpacity(.4)
                  : Theme.of(context).brightness == Brightness.dark
                  ? AppColorsNew.white.withOpacity(.1)
                  : AppColorsNew.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
              child: SVGImage(
                color: iconColor,
                path: path,
                height: iconHeight ?? 24.r,
                width: iconWidth ?? 24.r,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
