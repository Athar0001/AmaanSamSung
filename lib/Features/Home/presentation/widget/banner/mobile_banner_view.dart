import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/Features/Home/provider/home_provider.dart';
import 'package:amaan_tv/core/utils/app_router.dart';
import 'package:amaan_tv/core/utils/asset_manager.dart';
import 'package:amaan_tv/core/widget/icon_widget.dart';
import 'banner_buttons.dart';
import 'banner_info.dart';
import 'banner_image.dart';
import 'banner_page_indicator.dart';

/// A widget that displays the banner view optimized for mobile devices.
///
/// This widget shows a full-width banner with a gradient overlay,
/// interactive elements, and page indicators.
class MobileBannerView extends StatelessWidget {
  const MobileBannerView({
    required this.controller,
    required this.currentPage,
    required this.onPageChanged,
    required this.provider,
    super.key,
  });

  /// Controller for the page view
  final PageController controller;

  /// Current page index
  final int currentPage;

  /// Callback when page changes
  final void Function(int) onPageChanged;

  /// Provider for banner data
  final HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: controller,
          onPageChanged: onPageChanged,
          children: List.generate(
            (provider.bannerModel?.data?.length ?? 0) + 1,
            (index) {
              if (index == 0) {
                return Stack(
                  children: [
                    Image.asset(
                      Assets.imagesCoverImage,
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                    // GradientHomePoster(
                    //   borderRadius: 0,
                    // ),
                  ],
                );
              } else {
                final banner = provider.bannerModel!.data![index - 1];
                final imageUrl = banner.show.bannerThumbnailImage?.url;
                final genres =
                    banner.show.showGenres
                        ?.map((showGenre) => showGenre.genre?.name)
                        .where((name) => name != null)
                        .join(' . ') ??
                    banner.show.genres?.map((genre) => genre.name).join(' . ');
                final releaseDate = DateTime.tryParse(
                  banner.show.releaseDate ?? '',
                )!.year.toString();

                return Padding(
                  padding: EdgeInsets.only(bottom: 35.r),
                  child: Stack(
                    children: [
                      // Background image
                      Positioned.fill(
                        child: BannerImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),

                      // Genre and year text
                      Positioned(
                        bottom: 110.r,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: BannerInfo(
                            genres: genres,
                            releaseDate: releaseDate,
                          ),
                        ),
                      ),
                      // Buttons
                      Positioned(
                        bottom: 45.r,
                        left: 0,
                        right: 0,
                        child: BannerButtons(show: banner.show),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
        // Notification icon
        PositionedDirectional(
          top: 0,
          end: 0,
          child: SafeArea(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconWidget(
                  path: Assets.imagesSearch,
                  iconColor: AppColorsNew.white,
                  onTap: () {
                    context.pushNamed(AppRoutes.search.routeName);
                  },
                ),
                10.horizontalSpace,
                IconWidget(
                  path: Assets.imagesNotification,
                  iconColor: AppColorsNew.white,
                  onTap: () {
                    context.pushNamed(AppRoutes.notifications.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
        // Dots indicator
        Positioned(
          bottom: 50.r,
          left: 0,
          right: 0,
          child: Center(
            child: BannerPageIndicator(
              controller: controller,
              count: (provider.bannerModel?.data?.length ?? 0) + 1,
            ),
          ),
        ),
      ],
    );
  }
}
