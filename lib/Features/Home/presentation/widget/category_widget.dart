import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/Features/Home/data/models/home_categories_model/categories.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:gap/gap.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    required this.category,
    required this.isSelected,
    super.key,
  });

  final Category category;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    const defaultImage =
        'https://img.freepik.com/free-vector/red-background-comic-style_23-2149034894.jpg';
    final imageUrl =
        category.image?.url ?? category.image?.presignedUrl ?? defaultImage;
    final backgroundUrl =
        category.backgroundImage?.url ??
        category.backgroundImage?.presignedUrl ??
        defaultImage;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height:  110.h,
            width:  110.h, // Keep aspect ratio roughly
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background Circle
                Container(
                  height:  90.h,
                  width:  90.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      scale: 0.1, // Adjust as needed
                      image:
                      backgroundUrl.contains('assets') ?
                          AssetImage(backgroundUrl):
                      NetworkImage(backgroundUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Foreground Image
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: isSelected ? 110.h : 90.h,
                  width: isSelected ? 110.h : 90.h,
                  child:
                  imageUrl.contains('asset')?
                      Image.asset(imageUrl):
                  CachedNetworkImageHelper(
                    showShimmer: false,
                    imageUrl: imageUrl,
                  ),
                ),
              ],
            ),
          ),
          Gap(5.r),
          Text(
            category.name ?? '',
            style:  AppTextStylesNew.style18RegularAlmarai,
          ),
        ],
      ),
    );
  }
}
