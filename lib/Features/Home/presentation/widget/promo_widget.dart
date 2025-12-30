import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/Features/Home/data/models/home/reals_model.dart';
import 'package:amaan_tv/Features/Home/data/models/reels/reels_show_details_mapper.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:amaan_tv/core/widget/gradient_container.dart';
import 'package:amaan_tv/core/widget/radio%20button/radio_button_multi_select_package.dart';
import 'package:go_router/go_router.dart';
import 'package:amaan_tv/core/utils/app_router.dart';

class PromoWidget extends StatelessWidget {
  const PromoWidget({
    required this.model,
    super.key,
  });
  final ReelModel model;
  @override
  Widget build(BuildContext context) {
    return TvClickButton(
      onTap: () {
        if (model.presignedUrl != null) {
          // Navigate using go_router to ShowPlayerScreen
          context.pushNamed(
            AppRoutes.showPlayer.routeName,
            extra: {
              'show': model.toDomain(),
              'url': model.presignedUrl!,
              'videoId': model.id!,
              'showRate': false,
            },
          );
        }
      },
      child: DecoratedBox(
        decoration: containerDecoration(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: CachedNetworkImageHelper(
                      width: double.infinity,
                      height: double.infinity,
                      imageUrl: model.thumbnailImage?.url,
                    ),
                  ),
                  GradientHomePoster(
                    borderRadius: 0,
                  ),
                  PositionedDirectional(
                    start: 0,
                    bottom: 0,
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Text(
                        model.title!,
                        textAlign: TextAlign.start,
                        style: AppTextStylesNew.style14RegularAlmarai.copyWith(
                          color: AppColorsNew.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Text(
                model.description ?? '',
                style: AppTextStylesNew.style12RegularAlmarai,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
