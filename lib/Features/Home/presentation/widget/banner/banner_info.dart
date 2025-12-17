import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';

class BannerInfo extends StatelessWidget {

  const BannerInfo({
    super.key,
    this.genres,
    this.releaseDate,
  });
  final String? genres;
  final String? releaseDate;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: AppTextStylesNew.style14BoldAlmarai.copyWith(
          fontSize: 14.r,
        ),
        children: [
          TextSpan(text: genres),
          TextSpan(
            text: " . ${releaseDate ?? ""}",
          ),
        ],
      ),
    );
  }
}
