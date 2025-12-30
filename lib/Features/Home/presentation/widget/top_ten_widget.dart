import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/Features/Home/functions.dart';
import 'package:amaan_tv/Features/favorite/presentation/widgets/favorite_icon_button.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'lock_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:amaan_tv/core/utils/app_router.dart';

class TopTenWidget extends StatefulWidget {
  const TopTenWidget({
    required this.topTenModel,
    super.key,
    this.isTopTenWidget = true,
    this.isNew = false,
  });

  final List<Details> topTenModel;
  final bool isTopTenWidget;
  final bool isNew;

  @override
  State<TopTenWidget> createState() => _TopTenWidgetState();
}

class _TopTenWidgetState extends State<TopTenWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.sw > 1100
          ? 270.r
          : 1.sw > 600
              ? 210.r
              : 180.r,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.topTenModel.length,
        separatorBuilder: (context, index) => 16.horizontalSpaceRadius,
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        itemBuilder: (context, index) {
          final child = _itemWidget(
            details: widget.topTenModel[index],
            number: index + 1,
            isTopTenWidget: widget.isTopTenWidget,
          );
          if (!widget.isNew) return child;
          return ClipRRect(
            child: Banner(
              location: BannerLocation.topStart,
              message: AppLocalization.strings.new_,
              color: Colors.green.withValues(alpha: 0.6),
              shadow: const BoxShadow(color: Colors.black87),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                letterSpacing: 1.0,
              ),
              textDirection: TextDirection.ltr,
              child: child,
            ),
          );
        },
      ),
    );
  }
}

class _itemWidget extends StatelessWidget {
  const _itemWidget({
    required this.details,
    required this.number,
    this.isTopTenWidget = true,
  });

  final Details details;
  final bool isTopTenWidget;
  final int number;

  @override
  Widget build(BuildContext context) {
    return TvClickButton(onTap: () {
      final id = details.id;
      context.pushNamed(
        AppRoutes.showDetails.routeName,
        pathParameters: {'id': id},
      );
    }, builder: (context, focused) {
      return AspectRatio(
        aspectRatio: 137 / 184,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: focused ? Border.all(color: AppColorsNew.white) : null),
          child: Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CachedNetworkImageHelper(
                  imageUrl: details.thumbnailImage?.url ?? '',
                  cacheKey: details.title,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
              if (checkIfVideoAllowed(
                    isFree: details.isFree,
                    isGuest: details.isGuest,
                  ) !=
                  null)
                const LockWidget(),
              Padding(
                padding: EdgeInsets.all(1.r),
                child: Align(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        strokeAlign: BorderSide.strokeAlignOutside,
                        width: 1.r,
                        color: AppColorsNew.white1.withValues(alpha: 0.3),
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                      gradient: LinearGradient(
                        colors: [
                          AppColorsNew.black1.withValues(alpha: 0.7),
                          AppColorsNew.black1.withValues(alpha: 0.0),
                        ],
                        stops: const [0.0, 0.5],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
              ),
              if (isTopTenWidget)
                Positioned(
                  bottom: -26.r,
                  right: -2.r, // Adjust for proper alignment
                  child: Stack(
                    children: <Widget>[
                      // Stroked text as border
                      Text(
                        (number).toString(),
                        style:
                            AppTextStylesNew.style32ExtraBoldAlmarai.copyWith(
                          fontSize: 50.r, // Adjust size as needed
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2.r
                            ..color = Colors.white, // Border color
                        ),
                      ),
                      // Transparent inner text
                      Text(
                        (number).toString(),
                        style:
                            AppTextStylesNew.style32ExtraBoldAlmarai.copyWith(
                          fontSize: 60.r,
                          // Match size with border text
                          color: Colors.transparent, // Transparent fill
                        ),
                      ),
                    ],
                  ),
                )
              else
                const SizedBox(),
              Positioned(top: 0, left: 0, child: FavoriteIconButton(details)),
            ],
          ),
        ),
      );
    });
  }
}
