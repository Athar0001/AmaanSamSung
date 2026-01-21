import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/Features/Home/data/models/top_shows_model/top_shows_model.dart';
import 'package:amaan_tv/core/utils/funcation.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:amaan_tv/core/utils/app_router.dart';

class ContinueWatchingWidget extends StatelessWidget {
  const ContinueWatchingWidget({required this.cotinueWatchingModel, super.key});

  final ContinueWatchingModel cotinueWatchingModel;
  onTap(BuildContext context, int index) {
    final model = cotinueWatchingModel.data?[index];
    if (model == null) return;

    final url = model.presignedUrl;
    final hasEpisode = (model.episodeId?.isNotEmpty ?? false);
    final fromMinute = model.fromMinute?.trim();

    if (hasEpisode && url != null && url.isNotEmpty) {
      final videoId = extractMiddlePart(url);

      context.pushNamed(
        AppRoutes.showPlayer.routeName,
        extra: {
          'url': url,
          'show': model,
          'videoId': videoId,
          'episodeId': model.episodeId,
          if (fromMinute != null && fromMinute.isNotEmpty)
            'fromMinute': fromMinute,
          if (model.closingDuration != null)
            'closingDuration': model.closingDuration,
        },
      );
    } else {
      context.pushNamed(
        AppRoutes.showDetails.routeName,
        pathParameters: {'id': model.id},
        queryParameters: {'fromMinute': fromMinute},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.sw > 1100
          ? 170.r
          : 1.sw > 600
              ? 140.r
              : 126.r,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: cotinueWatchingModel.data?.length ?? 0,
        itemBuilder: (context, index) {
          return TvClickButton(
            onTap: () {
              onTap(context, index);
            },
            focusScale: 1.05,
            builder: (context, focused) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.r),
                child: AspectRatio(
                  aspectRatio: 306 / 200,
                  child: Padding(
                    padding: EdgeInsets.all(1.r),
                    child: Stack(
                      fit: StackFit.expand,
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: focused
                                ? Border.all(
                                    color: AppColorsNew.white,
                                    width: 2.5) // Thicker border on focus
                                : null,
                            image: decorationImageHelper(
                              fit: BoxFit.cover,
                              cotinueWatchingModel
                                  .data?[index].thumbnailImage?.url,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.r),
                          child: Align(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                  width: 1.r,
                                  color: AppColorsNew.white1.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColorsNew.black1.withValues(alpha: 0),
                                    AppColorsNew.black1.withValues(
                                        alpha: 0.8), // Slightly reduced opacity
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.4, 1],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10.r, // Moved up slightly
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: SizedBox(
                              width: 1.sw > 1100
                                  ? 230.r
                                  : 1.sw > 600
                                      ? 195.r
                                      : 180.r,
                              height: 4.r, // Thinner progress bar
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(2.r),
                                child: LinearProgressIndicator(
                                  color: AppColorsNew.primary,
                                  value: calculateProgress(
                                    cotinueWatchingModel
                                            .data?[index].fromMinute ??
                                        '00:00',
                                    cotinueWatchingModel
                                            .data?[index].duration?.inSeconds
                                            .toDouble() ??
                                        0,
                                  ),
                                  minHeight: 4.r,
                                  backgroundColor: AppColorsNew.white
                                      .withOpacity(
                                          0.3), // Semi-transparent white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
