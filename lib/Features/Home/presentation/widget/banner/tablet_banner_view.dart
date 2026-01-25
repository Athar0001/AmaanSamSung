import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/Features/Home/provider/home_provider.dart';
import 'package:amaan_tv/core/utils/app_router.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:amaan_tv/gen/assets.gen.dart';

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
    final bannerData =
        currentPage == 0 ? null : provider.bannerModel?.data?[currentPage - 1];

    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        // Background Banner Image with PageView

        PageView.builder(
          controller: controller,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(), // Disable manual swiping
          itemCount: (provider.bannerModel?.data?.length ?? 0) + 1,
          itemBuilder: (context, index) {
            final banner =
                index == 0 ? null : provider.bannerModel?.data?[index - 1];

            return Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                if (index == 0)
                  // First item shows cover image
                  Center(
                    child: Image.asset(
                      Assets.images.coverImageJpg.path,
                      fit: BoxFit.fill,
                      width: 1.sw,
                      height: 850,
                    ),
                  )
                else if (banner?.show.bannerThumbnailImage?.url != null)
                  CachedNetworkImageHelper(
                    imageUrl: banner!.show.bannerThumbnailImage!.url!,
                    fit: BoxFit.fill,
                    width: 1.sw,
                    height: 850,
                  ),
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 8,
                    sigmaY: 8,
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),
                ),

                // Background image
                if (index == 0)
                  // First item shows cover image
                  Center(
                    child: Image.asset(
                      Assets.images.coverImageJpg.path,
                      fit: BoxFit.fill,
                      width: 0.45.sw,
                      height: 400,
                    ),
                  )
                else if (banner?.show.bannerThumbnailImage?.url != null)
                  PositionedDirectional(
                    top: 100.r,
                    child: CachedNetworkImageHelper(
                      imageUrl: banner!.show.bannerThumbnailImage!.url!,
                      fit: BoxFit.fill,
                      width: 0.45.sw,
                      height: 400,
                    ),
                  )
                else
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF1a4d6d), Color(0xFF0d2438)],
                      ),
                    ),
                  ),

                // Gradient overlay (only for non-first items or apply to all)
                if (index != 0)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.8),
                        ],
                        stops: [0.0, 0.6, 1.0],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),

        // Content overlay
        if (bannerData != null)
          PositionedDirectional(
            start: 24.w,
            end: 0.4.sw, // Limit text width by padding from end
            bottom: 350.r,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  bannerData.show.title,
                  textAlign: TextAlign.start,
                  style: AppTextStylesNew.style28BoldAlmarai.copyWith(
                    color: AppColorsNew.white,
                    fontSize: 48.r, // Increased font size for title
                    height: 1.2,
                  ),
                ),
                16.verticalSpace,

                // Description
                Text(
                  bannerData.show.description ?? '',
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStylesNew.style14RegularAlmarai.copyWith(
                    color: AppColorsNew.white.withOpacity(0.9),
                    fontSize: 18.r, // Increased font size for description
                    height: 1.6,
                  ),
                ),
                32.verticalSpace,

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Watch Now button
                    TvClickButton(
                      onTap: () {
                        context.pushNamed(
                          AppRoutes.showDetails.routeName,
                          pathParameters: {'id': bannerData.show.id},
                          extra: bannerData.show,
                        );
                      },
                      builder: (context, focused) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColorsNew.primary,
                            borderRadius: BorderRadius.circular(
                                30.r), // Rounded pill shape
                            border: focused
                                ? Border.all(
                                    color: AppColorsNew.white, width: 2)
                                : null,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.play_arrow_rounded,
                                  size: 24.r, color: AppColorsNew.white),
                              8.horizontalSpace,
                              Text(
                                'شاهد الآن',
                                style: AppTextStylesNew.style14BoldAlmarai
                                    .copyWith(
                                  color: AppColorsNew.white,
                                  fontSize: 16.r,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    16.horizontalSpace,

                    // Trailer Button ("الإعلان")
                    TvClickButton(
                      onTap: () {
                        // TODO: Implement trailer action
                      },
                      builder: (context, focused) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white
                                .withOpacity(0.2), // Transparent/Glassy
                            borderRadius: BorderRadius.circular(30.r),
                            border: focused
                                ? Border.all(
                                    color: AppColorsNew.white, width: 2)
                                : null,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                  Icons
                                      .info_outline_rounded, // Using info icon as placeholder for trailer/details if needed or just play circle
                                  size: 24.r,
                                  color: AppColorsNew.white),
                              8.horizontalSpace,
                              Text(
                                'الإعلان',
                                style: AppTextStylesNew.style14BoldAlmarai
                                    .copyWith(
                                  color: AppColorsNew.white,
                                  fontSize: 16.r,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

        // Thumbnails Carousel at bottom
        if (provider.bannerModel?.data?.isNotEmpty ?? false)
          PositionedDirectional(
            bottom: 0,
            start: 0,
            end: 0,
            height: 330.r,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsetsDirectional.only(start: 24.w, bottom: 24.r),
              itemCount: provider.bannerModel!.data!.length,
              itemBuilder: (context, index) {
                final show = provider.bannerModel!.data![index];
                // Since index is 0-based for list, but pageview has cover at 0
                // Banner data starts from index 1 in pageview
                final pageIndex = index + 1;
                final isSelected = currentPage == pageIndex;
                return TvClickButton(
                  onTap: () {
                    controller.animateToPage(
                      pageIndex,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  builder: (context, hasFocus) {
                    return Container(
                      width: 232.r,
                      margin: EdgeInsetsDirectional.only(end: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: isSelected || hasFocus
                            ? Border.all(
                                color: AppColorsNew.white,
                                width: hasFocus ? 4 : 2,
                              )
                            : null,
                        boxShadow: isSelected || hasFocus
                            ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: show.show.thumbnailImage?.url != null
                            ? CachedNetworkImageHelper(
                                imageUrl: show.show.thumbnailImage!.url!,
                                fit: BoxFit.cover,
                                width: 232.r,
                                height: 330.r,
                                borderRadius: 0,
                              )
                            : Container(color: Colors.grey[800]),
                      ),
                    );
                  },
                );
              },
            ),
          )
      ],
    );
  }
}

// Action Button Widget
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String? label;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TvClickButton(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: label != null ? 16.w : 12.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColorsNew.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColorsNew.white, size: 20.r),
            if (label != null) ...[
              8.horizontalSpace,
              Text(
                label!,
                style: AppTextStylesNew.style14RegularAlmarai.copyWith(
                  color: AppColorsNew.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
