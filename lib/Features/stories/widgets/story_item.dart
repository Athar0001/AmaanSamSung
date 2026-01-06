import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../core/Themes/app_colors_new.dart';
import '../../../core/Themes/app_text_styles_new.dart';
import '../../../core/models/episodes_model.dart';
import '../../../core/utils/asset_manager.dart';
import '../../../core/widget/gradient_container.dart';
import '../../../core/widget/icon_widget.dart';

class StoryItemWidget extends StatelessWidget {
  const StoryItemWidget(
      {required this.model, super.key, this.onTapFavorite, this.onTap});

  final EpisodesModel model;
  final VoidCallback? onTapFavorite;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(model.image, fit: BoxFit.cover, width: double.infinity),
            GradientContainer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      model.title,
                      style: AppTextStylesNew.style16BoldAlmarai.copyWith(
                        color: AppColorsNew.white1,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Gap(2),
                    if (model.categories != null)
                      Text(
                        model.categories!.join('، '),
                        style: AppTextStylesNew.style14BoldAlmarai.copyWith(
                          color: AppColorsNew.white1,
                          fontWeight: FontWeight.w800,
                        ),
                      )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 1,
              left: 1,
              child: IconWidget(
                path: model.isLiked
                    ? Assets.imagesTrueHeart
                    : Assets.imagesFalseHeart,
                iconColor:
                    model.isLiked ? AppColorsNew.primary : AppColorsNew.white,
                isBlack: false,
                onTap: () {
                  onTapFavorite?.call();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
