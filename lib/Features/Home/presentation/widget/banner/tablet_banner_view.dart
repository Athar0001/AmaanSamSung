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
              children: [
                if (index == 0)
                  // First item shows cover image
                  Center(
                    child: Image.asset(
                      Assets.images.coverImageJpg.path,
                      fit: BoxFit.fill,
                      width: 1.sw,
                      height: 400,
                    ),
                  )
                else if (banner?.show.bannerThumbnailImage?.url != null)
                  CachedNetworkImageHelper(
                    imageUrl: banner!.show.bannerThumbnailImage!.url!,
                    fit: BoxFit.fill,
                    width: 1.sw,
                    height: 400,
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
                      width: 0.6.sw,
                      height: 400,
                    ),
                  )
                else if (banner?.show.bannerThumbnailImage?.url != null)
                  CachedNetworkImageHelper(
                    imageUrl: banner!.show.bannerThumbnailImage!.url!,
                    fit: BoxFit.fill,
                    width: 0.6.sw,
                    height: 400,
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
          Positioned(
            right: 24.r,
            left: 24.r,
            bottom: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  bannerData.show.title,
                  textAlign: TextAlign.right,
                  style: AppTextStylesNew.style28BoldAlmarai.copyWith(
                    color: AppColorsNew.white,
                    fontSize: 32.r,
                    height: 1.2,
                  ),
                ),
                16.verticalSpace,

                // Description
                Container(
                  width: 0.6.sw,
                  child: Text(
                    bannerData.show.description ?? '',
                    textAlign: TextAlign.right,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStylesNew.style14RegularAlmarai.copyWith(
                      color: AppColorsNew.white.withOpacity(0.9),
                      fontSize: 15.r,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Action Buttons
        if (bannerData != null)
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
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
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColorsNew.primary,
                          borderRadius: BorderRadius.circular(6.r),
                          border: focused
                              ? Border.all(color: AppColorsNew.white, width: 2)
                              : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.play_arrow,
                                size: 18.r, color: AppColorsNew.white),
                            6.horizontalSpace,
                            Text(
                              'شاهد الآن',
                              style:
                                  AppTextStylesNew.style14BoldAlmarai.copyWith(
                                color: AppColorsNew.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  12.horizontalSpace,

                  // // Info button
                  // _ActionButton(
                  //   icon: Icons.info_outline,
                  //   label: 'إعلان',
                  //   onTap: () {},
                  // ),
                  // 12.horizontalSpace,

                  // Like button
                  // _ActionButton(icon: Icons.favorite_border, onTap: () {}),
                ],
              ),
            ),
          ),

        // // Thumbnails Carousel at bottom
        // if (provider.bannerModel?.data?.isNotEmpty ?? false)
        //   Positioned(
        //     bottom: 0,
        //     left: 0,
        //     right: 0,
        //     height: 250.r,
        //     child: Container(
        //       decoration: BoxDecoration(
        //         gradient: LinearGradient(
        //           begin: Alignment.topCenter,
        //           end: Alignment.bottomCenter,
        //           colors: [
        //             Colors.transparent,
        //             Colors.black.withOpacity(0.5),
        //             Colors.black.withOpacity(0.9),
        //           ],
        //         ),
        //       ),
        //       child: ListView.builder(
        //         scrollDirection: Axis.horizontal,
        //
        //         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        //         itemCount: provider.bannerModel!.data!.length,
        //         itemBuilder: (context, index) {
        //           final show = provider.bannerModel!.data![index];
        //           final isSelected = currentPage == index + 1;
        //           return GestureDetector(
        //             onTap: () {
        //               controller.animateToPage(
        //                 index + 1,
        //                 duration: Duration(milliseconds: 300),
        //                 curve: Curves.easeInOut,
        //               );
        //             },
        //             child: Container(
        //               width: 160.r,
        //               height: 300.r,
        //               margin: EdgeInsetsDirectional.only(start: 12.w),
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(8.r),
        //                 border: Border.all(
        //                   color: isSelected
        //                       ? AppColorsNew.primary
        //                       : Colors.white.withOpacity(0.3),
        //                   width: isSelected ? 3 : 1,
        //                 ),
        //                 boxShadow: isSelected
        //                     ? [
        //                         BoxShadow(
        //                           color: AppColorsNew.primary.withOpacity(0.5),
        //                           blurRadius: 8,
        //                           spreadRadius: 1,
        //                         ),
        //                       ]
        //                     : null,
        //               ),
        //               child: ClipRRect(
        //                 borderRadius: BorderRadius.circular(6.r),
        //                 child: show.show.thumbnailImage?.url != null
        //                     ? CachedNetworkImageHelper(
        //                         imageUrl: show.show.thumbnailImage!.url!,
        //                         fit: BoxFit.cover,
        //                         width: 180.r,
        //                         height: 330.r,
        //                         borderRadius: 0,
        //                       )
        //                     : Container(color: Colors.grey[800]),
        //               ),
        //             ),
        //           );
        //         },
        //       ),
        //     ),
        //   ),
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
