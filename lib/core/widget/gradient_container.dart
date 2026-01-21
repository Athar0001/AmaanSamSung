import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key, this.borderRadius});
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black.withOpacity(0.1),
          Colors.black.withOpacity(0.1),
          Colors.black.withOpacity(0.3),
          Colors.black.withOpacity(0.4)
        ],
      ),
    ));
  }
}

class GradientHomePoster extends StatelessWidget {
  const GradientHomePoster(
      {super.key, this.height, this.width, this.borderRadius});
  final double? height;
  final double? width;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColorsNew.darkBlue2.withOpacity(0),
                AppColorsNew.darkBlue2.withOpacity(0.6),
              ],
              stops: [
                0,
                1
              ]),
        ));
  }
}
