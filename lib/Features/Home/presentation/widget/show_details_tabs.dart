import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/Features/Home/data/models/home/reals_model.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/promo_widget.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/sliver_tab_view.dart';
import 'package:amaan_tv/Features/Home/provider/show_videos_provider.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/Features/Home/data/models/home/related_model/related_model.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/Suggestions_widget.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/episode_widget.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/more_widget.dart';
import 'package:amaan_tv/Features/Home/provider/show_provider.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/widget_sliver_extension.dart';
import 'package:amaan_tv/core/widget/app_state_builder.dart';
import 'package:amaan_tv/core/widget/pagination_widget.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../screens/show_details_screen.dart';

// class ShowDetailsTabs extends StatelessWidget {
//   const ShowDetailsTabs({required this.tabs, super.key});
//
//   final List<Tab> tabs;
//
//   @override
//   Widget build(BuildContext context) {
//     return ColoredBox(
//       color: AppColorsNew.scaffoldDarkColor,
//       child: Padding(
//         padding: EdgeInsets.only(top: 16.r),
//         child: TabBar(
//           tabs: tabs,
//           isScrollable: true,
//           dividerColor: Colors.transparent,
//           indicator: LineTabIndicator(
//             color: AppColorsNew.amber,
//             height: 3.r,
//             width: 25.r,
//             endRadius: 5.r,
//           ),
//           tabAlignment: TabAlignment.center,
//           labelColor: AppColorsNew.blue1,
//           labelStyle: AppTextStylesNew.style14RegularAlmarai.copyWith(
//             color: AppColorsNew.darkGrey1,
//           ),
//           unselectedLabelColor: Theme.of(context).textTheme.bodyMedium?.color,
//         ),
//       ),
//     );
//   }
// }

class ShowDetailsTabBarView extends StatefulWidget {
  const ShowDetailsTabBarView({
    required this.showId,
    required this.isSeries,
    required this.currentTap,
    super.key,
  });

  final String showId;
  final bool isSeries;
  final ShowDetailsTab currentTap;

  @override
  State<ShowDetailsTabBarView> createState() => _ShowDetailsTabBarViewState();
}

class _ShowDetailsTabBarViewState extends State<ShowDetailsTabBarView> {
  @override
  Widget build(BuildContext context) {
    return widget.isSeries && widget.currentTap == ShowDetailsTab.episodes
        ? AppStateBuilder<ShowProvider, List<Details>>(
            isSliver: true,
            initState: (provider) => provider.getShowsEpisodesProvide(),
            selector: (provider) => provider.showsEpisodesModel?.data,
            state: (provider) => provider.stateShowsEpisodes,
            builder: (context, episodes, child) {
              if (episodes.isEmpty) {
                return const SizedBox.shrink().sliver;
              }
              return SliverPadding(
                padding: epsPadding(),
                sliver: SliverGrid(
                  gridDelegate: epsGrid(),
                  delegate: SliverChildBuilderDelegate(
                    childCount: episodes.length,
                    (context, index) => EpisodeWidget(
                      model: episodes[index],
                      episodesModel: episodes,
                    ),
                  ),
                ),
              );
            },
          ) :

        // PaginationWidget(
        //   isSliver: true,
        //   paginationMixin: context.read<ShowPromosProvider>(),
        //   loadInitialData: true,
        //   itemBuilder: (context, index, promo) => PromoWidget(model: promo),
        //   loadingBuilder: (context, index) =>
        //       Skeletonizer(child: PromoWidget(model: ReelModel.dummy())),
        //   emptyStateBuilder: (context) => SizedBox(
        //     height: 300.r,
        //     child: Center(
        //       child: Text(
        //         AppLocalization.strings.emptyStateMessage,
        //         style: AppTextStylesNew.style24BoldAlmarai,
        //       ),
        //     ),
        //   ),
        //   listBuilder: (context, length, builder) {
        //     return SliverPadding(
        //       padding: epsPadding(),
        //       sliver: SliverGrid(
        //         gridDelegate: epsGrid(),
        //         delegate: SliverChildBuilderDelegate(
        //           childCount: length,
        //           (context, index) => builder(context, index),
        //         ),
        //       ),
        //     );
        //   },
        // ),
        widget.currentTap == ShowDetailsTab.related
            ? AppStateBuilder<ShowProvider, RelatedModel>(
                isSliver: true,
                initState: (provider) => provider.getRelatedShowsProvide(),
                state: (provider) => provider.stateRelatedShows,
                selector: (provider) => provider.relatedModel,
                builder: (context, data, child) {
                  return SuggestionsWidget(relatedModel: data);
                },
              )
            : widget.currentTap == ShowDetailsTab.suggestions
                ? AppStateBuilder<ShowProvider, RelatedModel>(
                    isSliver: true,
                    initState: (provider) =>
                        provider.getRelatedShowsProvide(),
                    state: (provider) => provider.stateRelatedShows,
                    selector: (provider) => provider.relatedModel,
                    builder: (context, data, child) {
                      return SuggestionsWidget(relatedModel: data);
                    },
                  )
                : widget.currentTap == ShowDetailsTab.more
                    ? MoreWidget(
                        model: context.read<ShowProvider>().showDetailsModel!,
                        seasons: context
                            .read<ShowProvider>()
                            .seasonsModel
                            ?.data
                            ?.length,
                        epsNum: context
                            .read<ShowProvider>()
                            .showsEpisodesModel
                            ?.data
                            ?.length,
                      ).sliver
                    : SizedBox.shrink().sliver;
  }

  EdgeInsets epsPadding() {
    return EdgeInsets.only(bottom: 100.h, left: 16.r, right: 16.r, top: 16.r);
  }

  SliverGridDelegateWithFixedCrossAxisCount epsGrid() {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      childAspectRatio: 343 / 284,
      mainAxisSpacing: 16.r,
      crossAxisSpacing: 16.r,
    );
  }
}

class LineTabIndicator extends Decoration {
  LineTabIndicator({
    required Color color,
    required double height,
    double? width,
    double endRadius = 0.0,
  }) : _painter = _LinePainter(color, height, width, endRadius);
  final BoxPainter _painter;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _LinePainter extends BoxPainter {
  _LinePainter(Color color, this.height, this.width, this.endRadius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true
          ..style = PaintingStyle.fill;
  final Paint _paint;
  final double height;
  final double? width;
  final double endRadius;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final lineWidth = width ?? cfg.size!.width;

    final startX = offset.dx + (cfg.size!.width - lineWidth) / 2;
    final startY = offset.dy + cfg.size!.height - height;

    final indicatorRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(startX, startY, lineWidth, height),
      Radius.circular(endRadius),
    );

    canvas.drawRRect(indicatorRRect, _paint);
  }
}
