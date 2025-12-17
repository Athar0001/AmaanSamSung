import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';

class HomeItemContainerWidget extends StatelessWidget {
  const HomeItemContainerWidget({
    required this.height, required this.width, required this.title, required this.image, required this.borderRadius, super.key,
    this.borderColor = AppColorsNew.yellow1,
  });

  final double height;
  final double width;
  final String title;
  final String image;
  final double borderRadius;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  image: decorationImageHelper(image),
                  border: Border.all(
                    color: borderColor,
                  )),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: Text(title,
                      style: AppTextStylesNew.style14BoldAlmarai.copyWith(
                        color: AppColorsNew.white1,
                        fontWeight: FontWeight.w900,
                      )),
                ),
              ),
            )),
      ),
    );
  }
}
