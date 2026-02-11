import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:amaan_tv/core/widget/tv_click.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/Features/Home/data/models/home/related_model/related_model.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/Features/Home/functions.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/lock_widget.dart';
import 'package:amaan_tv/Features/favorite/presentation/widgets/favorite_icon_button.dart';
import 'package:amaan_tv/core/utils/grid_config.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:amaan_tv/core/utils/app_router.dart';
import 'package:amaan_tv/core/utils/focus_helper.dart';
import 'package:simple_tv_navigation/simple_tv_navigation.dart';

class SuggestionsWidget extends StatelessWidget {
  const SuggestionsWidget({required this.relatedModel, super.key, this.focusKeyBase = FocusKeys.detailsSuggestions});

  final RelatedModel relatedModel;
  final String focusKeyBase;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 70.r),
      sliver: SliverGrid(
        gridDelegate: GridConfig.getDefaultGridDelegate(),
        delegate: SliverChildBuilderDelegate(
          childCount: relatedModel.data?.length ?? 0,
          (context, index) => ShowWidget(
            relatedModel.data![index],
            index: index,
            totalShows: relatedModel.data!.length,
            focusKeyBase: focusKeyBase,
          ),
        ),
      ),
    );
  }
}

class ShowWidget extends StatefulWidget {
  const ShowWidget(
    this.show, {
    super.key,
    this.index,
    this.totalShows,
    this.focusKeyBase = FocusKeys.detailsSuggestions,
  });

  final Details show;
  final int? index;
  final int? totalShows;
  final String focusKeyBase;

  @override
  State<ShowWidget> createState() => _ShowWidgetWidgetState();
}

class _ShowWidgetWidgetState extends State<ShowWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.index == null || widget.totalShows == null) {
      // Fallback without TvClick
      return _buildShowContent(context);
    }

    const columns = 6;
    final row = widget.index! ~/ columns;
    final col = widget.index! % columns;
    final totalRows = (widget.totalShows! / columns).ceil();

    return TvClick(
      id: FocusId.grid(widget.focusKeyBase, row, col),
      rightId: col > 0
          ? FocusId.grid(widget.focusKeyBase, row, col - 1)
          : null,
      leftId: col < columns - 1 && (row * columns + col + 1) < widget.totalShows!
          ? FocusId.grid(widget.focusKeyBase, row, col + 1)
          : null,
      upId: row > 0
          ? FocusId.grid(widget.focusKeyBase, row - 1, col)
          : FocusId.list(FocusKeys.detailsTab, 0),
      downId: row < totalRows - 1 && ((row + 1) * columns + col) < widget.totalShows!
          ? FocusId.grid(widget.focusKeyBase, row + 1, col)
          : null,
      radius: 8.r,
      onSelect: () {
        final id = widget.show.id;
        context.pushNamed(
          AppRoutes.showDetails.routeName,
          pathParameters: {'id': id},
        ).then((value){
          context.setFocus(FocusKeys.detailsPlay);

        });;
      },
      child: _buildShowContent(context),
    );
  }

  Widget _buildShowContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                image: decorationImageHelper(widget.show.thumbnailImage?.url),
              ),
            ),
          ),
          Align(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  strokeAlign: BorderSide.strokeAlignOutside,
                  width: 1.sp,
                  color: AppColorsNew.white1.withValues(alpha: 0.3),
                ),
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [
                    AppColorsNew.black1.withValues(alpha: 0.2),
                    AppColorsNew.black1.withValues(alpha: 0.2),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          if (!widget.show.isReleased ||
              (checkIfVideoAllowed(
                    isFree: widget.show.isFree,
                    isGuest: widget.show.isGuest,
                  ) !=
                  null))
            Align(child: LockWidget())
          else
            SizedBox(),

        ],
      ),
    );
  }
}
