import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
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

class SuggestionsWidget extends StatelessWidget {
  const SuggestionsWidget({required this.relatedModel, super.key});

  final RelatedModel relatedModel;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 8.r, right: 8.r, top: 16.r, bottom: 70.r),
      sliver: SliverGrid(
        gridDelegate: GridConfig.getDefaultGridDelegate(),
        delegate: SliverChildBuilderDelegate(
          childCount: relatedModel.data?.length ?? 0,
          (context, index) => ShowWidget(relatedModel.data![index]),
        ),
      ),
    );
  }
}

class ShowWidget extends StatefulWidget {
  const ShowWidget(this.show, {super.key});

  final Details show;

  @override
  State<ShowWidget> createState() => _ShowWidgetWidgetState();
}

class _ShowWidgetWidgetState extends State<ShowWidget> {
  @override
  Widget build(BuildContext context) {
    return TvClickButton(
      onTap: () {
        final id = widget.show.id;
        context.pushNamed(
          AppRoutes.showDetails.routeName,
          pathParameters: {'id': id},
        );
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: Container(
              decoration: BoxDecoration(
                image: decorationImageHelper(widget.show.thumbnailImage?.url),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(1.sp),
            child: Align(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    strokeAlign: BorderSide.strokeAlignOutside,
                    width: 1.sp,
                    color: AppColorsNew.white1.withValues(alpha: 0.3),
                  ),
                  borderRadius: BorderRadius.circular(24.r),
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
          PositionedDirectional(
            end: 0,
            top: 0,
            child: FavoriteIconButton(widget.show),
          ),
        ],
      ),
    );
  }
}
