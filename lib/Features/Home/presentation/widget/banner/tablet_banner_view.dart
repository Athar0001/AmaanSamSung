import 'dart:ui';

import 'package:amaan_tv/core/utils/focus_helper.dart';
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
import 'package:provider/provider.dart';
import 'package:simple_tv_navigation/simple_tv_navigation.dart';

import '../../../../../core/widget/tv_click.dart';
import '../../../../Auth/provider/user_notifier.dart';

class TabletBannerView extends StatelessWidget {
  const TabletBannerView({
    required this.controller,
    required this.currentPage,
    required this.onPageChanged,
    required this.provider,
    required this.onFocus,
    super.key,
  });

  final PageController controller;
  final int currentPage;
  final void Function(int) onPageChanged;
  final HomeProvider provider;
  final VoidCallback onFocus;

  @override
  Widget build(BuildContext context) {
    final bannerData =provider.bannerModel?.data?[currentPage];

    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        // Background Banner Image with PageView

        PageView.builder(
          controller: controller,
          onPageChanged: onPageChanged,
          itemCount: (provider.bannerModel?.data?.length ?? 0),
          itemBuilder: (context, index) {
            final banner = provider.bannerModel?.data?[index];

            return Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                // if (index == 0)
                //   // First item shows cover image
                //   Center(
                //     child: Image.asset(
                //       Assets.images.coverImageJpg.path,
                //       fit: BoxFit.fill,
                //       width: 1.sw,
                //       height: 850,
                //     ),
                //   )
                // else
                  if (banner?.show.bannerThumbnailImage?.url != null)
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

                if (banner?.show.bannerThumbnailImage?.url != null)
                  PositionedDirectional(
                    top: 0.r,
                    child: CachedNetworkImageHelper(
                      imageUrl: banner!.show.bannerThumbnailImage!.url!,
                      fit: BoxFit.fill,
                      width: 0.45.sw,
                      height: 320,
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
                    TvClick(
                      id: FocusKeys.watchNow,
                      downId: FocusId.list(FocusKeys.banner, 0),
                      upId: FocusKeys.homeTab,
                      radius: 30.r,
                      onSelect: () {
                        context.pushNamed(
                          AppRoutes.showDetails.routeName,
                          pathParameters: {'id': bannerData.show.id},
                          extra: bannerData.show,
                        ).then((value){
                          context.setFocus(FocusKeys.homeTab);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColorsNew.primary,
                          borderRadius: BorderRadius.circular(
                              30.r), // Rounded pill shape
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
                      ),
                    ),
                    // 16.horizontalSpace,

                    // Trailer Button ("الإعلان")
                    // TvClickButton(
                    //   onTap: () {
                    //     // TODO: Implement trailer action
                    //   },
                    //   builder: (context, focused) {
                    //     return Container(
                    //       padding: EdgeInsets.symmetric(
                    //         horizontal: 24.w,
                    //         vertical: 12.h,
                    //       ),
                    //       decoration: BoxDecoration(
                    //         color: Colors.white
                    //             .withOpacity(0.2), // Transparent/Glassy
                    //         borderRadius: BorderRadius.circular(30.r),
                    //         border: focused
                    //             ? Border.all(
                    //                 color: AppColorsNew.white, width: 2)
                    //             : null,
                    //       ),
                    //       child: Row(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Icon(
                    //               Icons
                    //                   .info_outline_rounded, // Using info icon as placeholder for trailer/details if needed or just play circle
                    //               size: 24.r,
                    //               color: AppColorsNew.white),
                    //           8.horizontalSpace,
                    //           Text(
                    //             'الإعلان',
                    //             style: AppTextStylesNew.style14BoldAlmarai
                    //                 .copyWith(
                    //               color: AppColorsNew.white,
                    //               fontSize: 16.r,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    // ),
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
           height: 300.r,
           child: ListView.builder(
             scrollDirection: Axis.horizontal,
             padding: EdgeInsetsDirectional.only(start: 24.w, bottom: 24.r),
             itemCount: provider.bannerModel!.data!.length,
             itemBuilder: (context, index) {
               final show = provider.bannerModel!.data![index];
               return Padding(
                 padding: const EdgeInsets.all(12.0),
                 child: TvClick(
                   id: FocusId.list(FocusKeys.banner, index),
                   rightId: index > 0
                       ? FocusId.list(FocusKeys.banner, index - 1)
                       : null,
                   leftId: index < provider.bannerModel!.data!.length - 1
                       ? FocusId.list(FocusKeys.banner, index + 1)
                       : FocusId.list(FocusKeys.banner, 0),
                   downId: (provider.continueWatchingModel?.data?.isNotEmpty ?? false)
                       ? FocusId.list(FocusKeys.continueWatching, 0)
                       : FocusId.list(FocusKeys.whatIsNew, 0),
                   upId: FocusKeys.watchNow,
                   radius: 10.r,
                   onFocus: (){
                     if(!Scrollable.of(context).mounted) {
                       Scrollable.ensureVisible(
                       context,
                       alignment: 0.0,
                       duration: Duration(milliseconds: 300),
                       curve: Curves.easeInOut,
                     );
                     }
                  controller.animateToPage(
                       index,
                       duration: Duration(milliseconds: 300),
                       curve: Curves.easeInOut,
                     );
                   },
                   child: Container(
                     width: 200.r,
                     child: ClipRRect(
                       borderRadius: BorderRadius.circular(10.r),
                       child: show.show.thumbnailImage?.url != null
                           ? CachedNetworkImageHelper(
                         imageUrl: show.show.thumbnailImage!.url!,
                         fit: BoxFit.cover,
                         width: 200.r,
                         height: 300.r,
                         borderRadius: 0,
                       )
                           : Container(color: Colors.grey[800]),
                     ),
                   ),
                 ),
               );
             },
           ),
                      )
      ],
    );
  }
}


