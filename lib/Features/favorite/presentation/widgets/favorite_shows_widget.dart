import 'dart:developer';

import 'package:amaan_tv/Features/Home/functions.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/lock_widget.dart';
import 'package:amaan_tv/Features/favorite/presentation/widgets/favorite_icon_button.dart';
import 'package:amaan_tv/Features/favorite/provider/get_favorites_shows_provider.dart';
import 'package:amaan_tv/core/widget/circle_progress_helper.dart';
import 'package:amaan_tv/core/widget/tv_click.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simple_tv_navigation/simple_tv_navigation.dart';
import '../../../../core/Themes/app_colors_new.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/injection/injection_imports.dart' as di;
import '../../../../core/utils/enum.dart';
import '../../../../core/utils/focus_helper.dart';
import '../../../../core/utils/grid_config.dart';
import '../../../../core/widget/cached network image/cached_network_image.dart';
import 'empty_favorite_widget.dart';

class FavoriteShowsWidget extends StatefulWidget {
  const FavoriteShowsWidget({super.key, this.childId});

  final String? childId;

  @override
  State<FavoriteShowsWidget> createState() => _FavoriteShowsWidgetState();
}

class _FavoriteShowsWidgetState extends State<FavoriteShowsWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GetFavoritesShowsProvider>(
      create: (_) => di.sl<GetFavoritesShowsProvider>()
        ..getFavoritesShows(childId: widget.childId, moduleId: 1),
      child: Consumer<GetFavoritesShowsProvider>(
        builder: (context, favoriteShowProvider, child) {
          return favoriteShowProvider.childFavoriteState == AppState.loading
              ? AppCircleProgressHelper()
              : favoriteShowProvider.childFavoriteState == AppState.success &&
                      favoriteShowProvider
                              .favoriteShowsModel?.favoriteShows?.isEmpty ==
                          true
                  ? EmptyFavoriteWidget()
                  : favoriteShowProvider.childFavoriteState ==
                              AppState.success &&
                          favoriteShowProvider.favoriteShowsModel?.favoriteShows
                                  ?.isNotEmpty ==
                              true
                      ? GridView.builder(
                          shrinkWrap: true,
                          padding: GridConfig.getDefaultPadding(),
                          gridDelegate: GridConfig.getDefaultGridDelegate(),
                          itemBuilder: (context, index) {
                            final show = favoriteShowProvider
                                .favoriteShowsModel?.favoriteShows?[index];

                            int columns =
                                GridConfig.getDefaultGridDelegate().crossAxisCount;
                            final int row = index ~/ columns;
                            final int col = index % columns;
                            final int totalItems =
                                favoriteShowProvider
                                    .favoriteShowsModel!.favoriteShows!.length;
                            final int totalRows = (totalItems / columns).ceil();
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TvClick(
                                id: FocusId.grid(FocusKeys.favShows, row, col),
                                listBaseId: FocusKeys.favShows,
                                radius: 12.r,
                                rightId: col > 0
                                    ? FocusId.grid(FocusKeys.favShows, row, col - 1)
                                    : null,
                                leftId: (col < columns - 1 &&
                                    (row * columns + col + 1) < totalItems)
                                    ? FocusId.grid(FocusKeys.favShows, row, col + 1)
                                    : null,
                                upId: row > 0
                                    ? FocusId.grid(FocusKeys.favShows, row - 1, col)
                                    : FocusId.list(FocusKeys.favCategory, 0),
                                downId: (row + 1) < totalRows &&
                                    ((row + 1) * columns + col) < totalItems
                                    ? FocusId.grid(FocusKeys.favShows, row + 1, col)
                                    : null,
                                onSelect: () async {
                                  final isFav = await context.pushNamed(
                                    'showDetails',
                                    pathParameters: {
                                      'id': show.showId.toString()
                                    },
                                  ).then((value){
                                    context.setFocus(FocusId.grid(FocusKeys.favShows, row, col));
                                  });;
                                  if (isFav == false) {
                                    log(
                                      isFav.toString(),
                                      name: 'ShowSeriesScreen isFav',
                                    );
                                    favoriteShowProvider.removeShow(
                                      e: favoriteShowProvider.favoriteShowsModel!
                                          .favoriteShows![index],
                                    );
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        image: decorationImageHelper(
                                          show?.show?.thumbnailImage?.url ?? '',
                                        ),
                                        border: Border.all(
                                            color: AppColorsNew.primary),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xff164B80),
                                            Color(0xff2C4D6D),
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xff93a7b7),
                                            blurRadius: 4,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                    ),
                                    if (!show!.show!.isReleased ||
                                        (checkIfVideoAllowed(
                                              isFree: show.show?.isFree,
                                              isGuest: show.show?.isGuest,
                                            ) !=
                                            null))
                                      Align(child: LockWidget())
                                    else
                                      SizedBox(),
                                    Padding(
                                      padding: EdgeInsets.all(1.sp),
                                      child: Align(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                            gradient: LinearGradient(
                                              colors: [
                                                AppColorsNew.black1.withValues(
                                                  alpha: 0.0,
                                                ),
                                                AppColorsNew.black1.withValues(
                                                  alpha: 0.2,
                                                ),
                                              ],
                                              stops: const [0, 1],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: favoriteShowProvider
                              .favoriteShowsModel?.favoriteShows?.length,
                        )
                      : const SizedBox.shrink();
        },
      ),
    );
  }
}
