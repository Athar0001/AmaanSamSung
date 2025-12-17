import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/Features/favorite/presentation/widgets/favorite_icon_button.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/asset_manager.dart';
import 'package:amaan_tv/core/widget/SVG_Image/svg_img.dart';
import 'package:amaan_tv/core/widget/buttons/main_button.dart';
import 'package:go_router/go_router.dart';
import 'package:amaan_tv/core/utils/app_router.dart';

class BannerButtons extends StatelessWidget {
  const BannerButtons({required this.show, super.key});
  final Details show;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: Row(
        spacing: 16.r,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: MainButtonWidget(
              height: 40.r,
              fontSize: 14.r,
              label: AppLocalization.strings.watchNow,
              leftIcon: SVGImage(
                path: Assets.imagesPlay,
                height: 20.r,
                width: 20.r,
                noTheme: true,
              ),
              onTap: () {
                context.pushNamed(
                  AppRoutes.showDetails.routeName,
                  pathParameters: {'id': show.id},
                );
              },
            ),
          ),
          Expanded(
            child: FavoriteIconButton(
              show,
              builder: (isFavorite) {
                return MainButtonWidget(
                  height: 40.r,
                  borderColor: AppColorsNew.primary,
                  buttonColor: AppColorsNew.black1.withValues(alpha: 0.1),
                  borderWidth: 1.r,
                  leftIcon: SVGImage(
                    path: Assets.imagesPlus,
                    color: AppColorsNew.white,
                  ),
                  label: !isFavorite
                      ? AppLocalization.strings.addToList
                      : AppLocalization.strings.removeFromList,
                  fontSize: 14.r,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
