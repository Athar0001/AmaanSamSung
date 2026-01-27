import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/widget/black_and_white_widget.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:amaan_tv/core/widget/responsive/models/responsive_sizes.dart';
import 'package:amaan_tv/core/widget/responsive/responsive_size_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../Home/data/models/home_categories_model/categories.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    required this.category,
    required this.isSelected,
    super.key,
    this.fromAssets = false,
    this.hasFocus = false,
  });

  final Category category;
  final bool isSelected;
  final bool hasFocus ;
  final bool fromAssets;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color:
        hasFocus?
        AppColorsNew.white : Colors.transparent,)
      ),
      child: Padding(
        padding: const EdgeInsets.all(11),
        child: Column(
          children: [
            // if (category.unselectedImg == null)
            SizedBox(
              height: 1.sw > 600 ? 120.r : 90.r,
              child: BlackAndWhiteWidget(
                isNoColors: !isSelected,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    ResponsiveSizeBuilder(
                      sizes: ResponsiveSizes(
                        small: 70.r,
                        medium: 70.r,
                        large: 100.r,
                      ),
                      builder: (context, size) => Padding(
                        padding: EdgeInsets.only(top: 15.h),
                        child: SizedBox(
                          height: size,
                          width: size,
                          child: Container(
                              decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: fromAssets
                                ? DecorationImage(
                                    image: AssetImage(category
                                            .backgroundImage?.url ??
                                        category.backgroundImage!.presignedUrl!))
                                : decorationImageHelper(
                                    category.backgroundImage?.url ??
                                        category.backgroundImage?.presignedUrl ??
                                        'https://img.freepik.com/free-vector/red-background-comic-style_23-2149034894.jpg',
                                  ),
                          )),
                        ),
                      ),
                    ),
                    ResponsiveSizeBuilder(
                      sizes: ResponsiveSizes(
                        // 1: big width, 2: small width,
                        // 3: bih hight, 4: small width
                        small: (60.r, 50.r, 85.r, 65.r),
                        medium: (60.r, 50.r, 85.r, 65.r),
                        large: (90.r, 80.r, 115.r, 95.r),
                      ),
                      builder: (context, size) => AnimatedContainer(
                          margin: EdgeInsets.only(bottom: 5.r),
                          duration: const Duration(milliseconds: 300),
                          height: isSelected ? size.$3 : size.$4,
                          width: isSelected ? size.$1 : size.$2,
                          child: fromAssets
                              ? Image.asset(category.image?.url ??
                                  category.image!.presignedUrl!)
                              : CachedNetworkImageHelper(
                                  showShimmer: false,
                                  imageUrl: category.image?.url ??
                                      category.image?.presignedUrl ??
                                      'https://img.freepik.com/free-vector/red-background-comic-style_23-2149034894.jpg',
                                )),
                    ),
                  ],
                ),
              ),
            ),

            const Gap(2),
            Text(
              category.name ?? '',
              style: AppTextStylesNew.style14BoldAlmarai.copyWith(
                color: isSelected ? AppColorsNew.primary : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
