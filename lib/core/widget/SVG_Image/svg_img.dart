import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SVGImage extends StatelessWidget {
  const SVGImage({
    required this.path, super.key,
    this.width,
    this.height,
    this.color,
    this.noTheme = false,
  });

  final String path;
  final double? width;
  final double? height;
  final Color? color;
  final bool noTheme;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: noTheme ? width : width ?? (1.sw > 1100 ? 32.r : 24.r),
      height: noTheme ? height : height ?? (1.sw > 1100 ? 32.r : 24.r),
      colorFilter: noTheme
          ? null
          : color != null
              ? ColorFilter.mode(color!, BlendMode.srcIn)
              : ColorFilter.mode(Theme.of(context).textTheme.labelSmall!.color!,
                  BlendMode.srcIn),
    );
  }
}
