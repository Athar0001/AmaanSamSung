import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/Features/Home/data/models/show_seasons_model/show_seasons.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:amaan_tv/core/utils/app_router.dart';

void showSeasonsBottomSheet(
  BuildContext context, {
  required List<ShowSeasons> season,
}) {
  final seasons = orderSeasons(season);
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return DraggableScrollableSheet(
        maxChildSize: 0.8,
        minChildSize: 0.3,
        expand: false,
        builder: (_, scrollController) {
          return DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Column(
              children: [
                // Top indicator
                TopIndicator(),
                // Title
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "${AppLocalization.strings.seasonsShow} ${seasons[0].title ?? ""}",
                    style: AppTextStylesNew.style16BoldAlmarai,
                  ),
                ),
                // List of items
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => 10.verticalSpace,
                    controller: scrollController,
                    itemCount: seasons.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        title: Text(
                          seasons[index].title ?? '',
                          style: AppTextStylesNew.style16BoldAlmarai,
                        ),
                        leading: AvatarPersonImageWidget(
                          imageUrl: seasons[index].thumbnailImage?.url ?? '',
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          context.pushReplacementNamed(
                            AppRoutes.showDetails.routeName,
                            pathParameters: {'id': seasons[index].id!},
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

class AvatarPersonImageWidget extends StatelessWidget {
  const AvatarPersonImageWidget({
    required this.imageUrl,
    super.key,
    this.width,
    this.height,
  });
  final String imageUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 48.r,
      width: width ?? 48.r,
      child: ClipOval(
        child: CachedNetworkImageHelper(
          height: double.infinity,
          width: double.infinity,
          imageUrl: imageUrl,
        ),
      ),
    );
  }
}

class TopIndicator extends StatelessWidget {
  const TopIndicator({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 50.w,
      height: 4,
      decoration: BoxDecoration(
        color: color ?? AppColorsNew.grey18,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
