import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/Features/Home/provider/home_provider.dart';
import 'package:amaan_tv/core/utils/app_router.dart';
import 'package:amaan_tv/core/utils/asset_manager.dart';
import 'package:amaan_tv/core/widget/icon_widget.dart';
import 'dart:ui';
import 'banner_buttons.dart';
import 'banner_info.dart';
import 'banner_image.dart';
import 'banner_page_indicator.dart';

class TabletBannerView extends StatelessWidget {
  const TabletBannerView({
    required this.controller,
    required this.currentPage,
    required this.onPageChanged,
    required this.provider,
    super.key,
  });
  final PageController controller;
  final int currentPage;
  final void Function(int) onPageChanged;
  final HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: controller,
          onPageChanged: onPageChanged,
          children: List.generate((provider.bannerModel?.data?.length ?? 0) + 1, (
            index,
          ) {
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.only(bottom: 35.r),
                child: Stack(
                  children: [
                    // Cover image as background
                    Positioned.fill(
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Image.asset(
                          Assets.imagesCoverImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    // Gradient overlay (optional, uncomment if you have a widget)
                    // Positioned.fill(
                    //   child: GradientHomePoster(borderRadius: 0),
                    // ),
                    // Main poster container (centered, like other banners)
                    Center(
                      child: Container(
                        width: 375.r,
                        height: double.infinity,
                        child: Stack(
                          children: [
                            // Foreground cover image (optional, can be omitted if not needed)
                            Image.asset(
                              Assets.imagesCoverImage,
                              fit: BoxFit.fill,
                            ),
                            // Notification icon
                            // PositionedDirectional(
                            //   top: 0,
                            //   end: 0,
                            //   child: SafeArea(
                            //     child: IconWidget(
                            //       path: Assets.imagesNotification,
                            //       iconColor: AppColorsNew.white,
                            //       onTap: () {
                            //         AppNavigation.navigationPush(
                            //           context,
                            //           screen: NotificationsScreen(),
                            //         );
                            //       },
                            //     ),
                            //   ),
                            // ),
                            // You can add more overlays here if needed (e.g., title, buttons)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
                    // Blurred background image
                    Positioned.fill(
                      child: BannerImage(imageUrl: imageUrl, blurSigma: 10),
                    ),

                    // Main poster container
                    Center(
                      child: Container(
                        width: 375.r,
                        height: double.infinity,
                        child: Stack(
                          children: [
                            BannerImage(imageUrl: imageUrl, fit: BoxFit.fill),

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
                            // Dots indicator
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
        ),
        // Notification icon
        PositionedDirectional(
          top: 0,
          end: 0,
          child: SafeArea(
            child: IconWidget(
              path: Assets.imagesNotification,
              iconColor: AppColorsNew.white,
              onTap: () {
                context.pushNamed(AppRoutes.notifications.routeName);
              },
            ),
          ),
        ),
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
