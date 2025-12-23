import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/models/content_type.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/lock_widget.dart';
import 'package:amaan_tv/Features/favorite/presentation/widgets/favorite_icon_button.dart';
import 'package:go_router/go_router.dart';
import 'package:amaan_tv/core/utils/app_router.dart';
import 'package:amaan_tv/core/utils/grid_config.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:amaan_tv/core/widget/gradient_container.dart';
import '../../../../core/Themes/app_colors_new.dart';
import '../../data/model/search_model.dart';
// Removed unused strings.dart import

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
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      gridDelegate: GridConfig.getDefaultGridDelegate(),
      itemBuilder: (context, index) {
        final item = widget.searchModel.searchList![index];
        return InkWell(
          onTap: () {
            final id = item.id;
            final contentType = item.contentType;
            switch (contentType) {
              case ContentType.character:
                {
                  // Fallback to showDetails until character details route is confirmed/added
                  context.pushNamed(
                    AppRoutes.showDetails.name,
                    pathParameters: {'id': id},
                  );
                }
                break;

              case ContentType.show:
                {
                  context.pushNamed(
                    AppRoutes.showDetails.name,
                    pathParameters: {'id': id},
                  );
                }
                break;

              case ContentType.audio:
                {
                  // Fallback to radio or relevant route
                  context.pushNamed(AppRoutes.soonRadio.name);
                }
                break;

              case ContentType.episode:
                {
                  context.pushNamed(
                    AppRoutes.showDetails.name,
                    pathParameters: {'id': item.showId ?? ''},
                  );
                }
                break;
            }
          },
          child: Stack(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColorsNew.primary),
                ),
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
              GradientContainer(borderRadius: 12.r),
              Positioned(top: 0, left: 0, child: FavoriteIconButton(item)),
              if (item.isReleased) SizedBox() else LockWidget(),
            ],
          ),
        );
      },
    );
  }
}
