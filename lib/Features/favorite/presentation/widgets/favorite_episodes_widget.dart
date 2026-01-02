import 'dart:developer';
import 'package:amaan_tv/Features/Home/functions.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/lock_widget.dart';
import 'package:amaan_tv/Features/favorite/presentation/widgets/empty_favorite_widget.dart';
import 'package:amaan_tv/Features/favorite/provider/get_favorites_episodes_provider.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/injection/injection_imports.dart' as di;
import 'package:amaan_tv/core/utils/asset_manager.dart';
import 'package:amaan_tv/core/utils/grid_config.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:amaan_tv/core/widget/circle_progress_helper.dart';
import 'package:amaan_tv/core/widget/custom_dialog.dart';
import 'package:amaan_tv/core/widget/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/enum.dart';
import '../../../Home/presentation/widget/repeat_dialog.dart';

class FavoriteEpisodesWidget extends StatefulWidget {
  const FavoriteEpisodesWidget({super.key, this.childId});

  final String? childId;

  @override
  State<FavoriteEpisodesWidget> createState() => _FavoriteEpisodesWidgetState();
}

class _FavoriteEpisodesWidgetState extends State<FavoriteEpisodesWidget> {
  bool isLock = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(MediaQuery.of(context).size.width.toString());
    return ChangeNotifierProvider<GetFavoritesEpisodesProvider>(
      create: (_) => di.sl<GetFavoritesEpisodesProvider>()
        ..getFavoritesEpisodes(childId: widget.childId),
      child: Consumer<GetFavoritesEpisodesProvider>(
        builder: (context, favoriteProvider, child) {
          return favoriteProvider.childFavoriteState == AppState.loading
              ? AppCircleProgressHelper()
              : (favoriteProvider.childFavoriteState == AppState.success &&
                      favoriteProvider
                              .childFavoriteModel?.favoriteShow?.isEmpty ==
                          true)
                  ? EmptyFavoriteWidget()
                  : favoriteProvider.childFavoriteState == AppState.success
                      ? GridView.builder(
                          shrinkWrap: true,
                          padding: GridConfig.getDefaultPadding(),
                          gridDelegate: GridConfig.getDefaultGridDelegate(),
                          itemBuilder: (context, index) {
                            final episode = favoriteProvider.childFavoriteModel
                                ?.favoriteShow![index].episode;
                            isLock = !episode!.isReleased ||
                                (checkIfVideoAllowed(
                                      isFree: episode.isFree,
                                      isGuest: episode.isGuest,
                                    ) !=
                                    null);
                            return GestureDetector(
                              onTap: () {
                                if (episode.presignedUrl != null && !isLock) {
                                  if (episode.isRepeat) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomDialog(
                                            content: RepeatDialog());
                                      },
                                    ).then((value) {
                                      if (value != null)
                                        context.pushNamed(
                                          'showPlayer',
                                          extra: {
                                            'url': episode.presignedUrl!,
                                            'show': episode,
                                            'videoId': episode.episodeVideos!
                                                    .firstWhere(
                                                      (element) =>
                                                          element.videoTypeId ==
                                                          '1',
                                                    )
                                                    .id ??
                                                '',
                                            'repeatTimes': value,
                                            'episodeId': episode.id,
                                            'closingDuration': episode
                                                    .episodeVideos
                                                    ?.firstWhere(
                                                      (element) =>
                                                          element.videoTypeId ==
                                                          '1',
                                                    )
                                                    .closingDuration ??
                                                episode.closingDuration,
                                          },
                                        );
                                    });
                                  } else {
                                    context.pushNamed(
                                      'showPlayer',
                                      extra: {
                                        'url': episode.presignedUrl!,
                                        'show': episode,
                                        'videoId': episode.episodeVideos!
                                                .firstWhere(
                                                  (element) =>
                                                      element.videoTypeId ==
                                                      '1',
                                                )
                                                .id ??
                                            '',
                                        'episodeId': episode.id,
                                        'closingDuration': episode.episodeVideos
                                                ?.firstWhere(
                                                  (element) =>
                                                      element.videoTypeId ==
                                                      '1',
                                                )
                                                .closingDuration ??
                                            episode.closingDuration,
                                      },
                                    );
                                  }
                                }
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      image: decorationImageHelper(
                                        episode.thumbnailImage?.url,
                                      ),
                                      border: Border.all(
                                          color: AppColorsNew.primary),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(1.sp),
                                    child: Align(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            strokeAlign:
                                                BorderSide.strokeAlignOutside,
                                            width: 1.sp,
                                            color:
                                                AppColorsNew.white1.withOpacity(
                                              0.3,
                                            ),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColorsNew.black1
                                                  .withOpacity(0.2),
                                              AppColorsNew.black1
                                                  .withOpacity(0.0),
                                            ],
                                            stops: const [1.0, 0.3],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (isLock)
                                    Align(child: LockWidget())
                                  else
                                    SizedBox(),
                                  PositionedDirectional(
                                    top: 1,
                                    end: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        favoriteProvider.removeEpisode(
                                          favoriteProvider.childFavoriteModel!
                                              .favoriteShow![index],
                                        );
                                      },
                                      child: IconWidget(
                                        isBlack: false,
                                        iconHeight: 18.h,
                                        iconWidth: 18.w,
                                        path: episode.isFavorite != false
                                            ? Assets.imagesTrueHeart
                                            : Assets.imagesTrueHeart,
                                        iconColor: episode.isFavorite != false
                                            ? AppColorsNew.primary
                                            : AppColorsNew.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: favoriteProvider
                              .childFavoriteModel?.favoriteShow?.length,
                        )
                      : const SizedBox.shrink();
        },
      ),
    );
  }
}
