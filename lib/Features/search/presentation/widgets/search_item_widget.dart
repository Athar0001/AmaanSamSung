import 'package:amaan_tv/Features/Home/presentation/widget/lock_widget.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:amaan_tv/Features/favorite/presentation/widgets/favorite_icon_button.dart';
import 'package:amaan_tv/core/utils/grid_config.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:amaan_tv/core/widget/gradient_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/Themes/app_colors_new.dart';
import '../../../../core/models/content_type.dart';
import '../../data/model/search_model.dart';

class SearchItemWidget extends StatefulWidget {
  const SearchItemWidget({required this.searchModel, super.key});

  final SearchModel searchModel;

  @override
  State<SearchItemWidget> createState() => _SearchItemWidgetState();
}

class _SearchItemWidgetState extends State<SearchItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.searchModel.searchList!.length,
      shrinkWrap: true,
      // Allows GridView to size itself based on content
      physics: const NeverScrollableScrollPhysics(),
      // Enables scrolling within the GridView
      padding: GridConfig.getDefaultPadding(),
      gridDelegate: GridConfig.getDefaultGridDelegate(),
      itemBuilder: (context, index) {
        final item = widget.searchModel.searchList![index];
        return TvClickButton(
          onTap: () {
            final id = item.id;
            final contentType = item.contentType;
            switch (contentType) {
              case ContentType.character:
                {
                  context.pushNamed('character', extra: item.toCharacterData);
                }

              case ContentType.show:
                {
                  context.pushNamed('showDetails', pathParameters: {'id': id});
                }
              case ContentType.audio:
                {}
              case ContentType.episode:
                {
                  context.pushNamed(
                    'showDetails',
                    pathParameters: {'id': item.showId!},
                  );
                }
            }
          },
          builder: (context, hasFocus) {
            return Stack(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: hasFocus? AppColorsNew.white: AppColorsNew.primary, width: 2.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CachedNetworkImageHelper(
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: item.thumbnailImage?.url,
                      ),
                    ),
                  ),
                ),
                GradientContainer(borderRadius: 12.r),
                if (item.isReleased) SizedBox() else LockWidget(),
              ],
            );
          }
        );
      },
    );
  }
}
