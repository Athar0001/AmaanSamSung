import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/Features/Home/data/models/home_categories_model/categories.dart';
import 'package:amaan_tv/Features/Home/provider/home_provider.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:go_router/go_router.dart';
import 'package:amaan_tv/core/utils/app_router.dart';
import 'package:amaan_tv/core/utils/enum.dart';
import 'package:amaan_tv/core/widget/black_and_white_widget.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:provider/provider.dart';

class CarouselSilderHomeItems extends StatefulWidget {
  const CarouselSilderHomeItems({required this.categories, super.key});

  final List<Category>? categories;

  @override
  State<CarouselSilderHomeItems> createState() =>
      _CarouselSilderHomeItemsState();
}

class _CarouselSilderHomeItemsState extends State<CarouselSilderHomeItems> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    // Calculate responsive dimensions
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    final carouselHeight = isTablet ? 250.r : 150.r;
    final itemWidth = isTablet ? 300.r : 165.r;
    final itemHeight = isTablet ? 180.r : 110.r;
    final imageSize = isTablet ? 210.r : 130.r;
    final smallImageSize = isTablet ? 160.r : 90.r;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            height: carouselHeight,
            // aspectRatio: 145.r / 110.r,
            viewportFraction: 0.4,
            autoPlay: true,
            enlargeCenterPage: true,
            enlargeFactor: isTablet ? 0.43 : 0.36,
            onPageChanged: (index, reason) {
              _currentIndex.value = index;
            },
          ),
          itemCount: widget.categories?.length ?? 0,
          itemBuilder: (context, index, _) {
            final category = widget.categories?[index];
            return GestureDetector(
              onTap: () {
                if (category == null) {
                  context.pushNamed(AppRoutes.soonRadio.routeName);
                  return;
                }
                final routeName = category.moduleType.screen(category);
                if (routeName == AppRoutes.categories.routeName) {
                  context.pushNamed(routeName, extra: category);
                } else {
                  context.pushNamed(routeName);
                }
              },
              child: FittedBox(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: isTablet ? 30.r : 20.r),
                          child: Container(
                            height: itemHeight,
                            width: itemWidth,
                            decoration: homeDecoration(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: category?.moduleType.isActive == false
                                  ? Banner(
                                      color: AppColorsNew.yellow1,
                                      location: BannerLocation.topEnd,
                                      message: AppLocalization.strings.soon,
                                      textStyle: AppTextStylesNew
                                          .style12RegularAlmarai
                                          .copyWith(
                                            fontSize: isTablet ? 16.r : 12.r,
                                          ),
                                      child: BlackAndWhiteWidget(
                                        isNoColors: true,
                                        child: CachedNetworkImageHelper(
                                          height: double.infinity,
                                          width: double.infinity,
                                          imageUrl: widget
                                              .categories?[index]
                                              .backgroundImage
                                              ?.url,
                                        ),
                                      ),
                                    )
                                  : BlackAndWhiteWidget(
                                      isNoColors: false,
                                      child: CachedNetworkImageHelper(
                                        height: double.infinity,
                                        width: double.infinity,
                                        imageUrl: widget
                                            .categories?[index]
                                            .backgroundImage
                                            ?.url,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        if (Provider.of<HomeProvider>(context).stateModules !=
                            AppState.loading)
                          ValueListenableBuilder<int>(
                            valueListenable: _currentIndex,
                            builder: (context, currentIndex, child) {
                              // Scale when in focus
                              final isFocused = index == currentIndex;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                transformAlignment: Alignment.bottomCenter,
                                height: isFocused ? imageSize : smallImageSize,
                                width: isFocused ? imageSize : smallImageSize,
                                child: BlackAndWhiteWidget(
                                  isNoColors:
                                      category?.moduleType.isActive == false,
                                  child: CachedNetworkImageHelper(
                                    imageUrl:
                                        widget.categories?[index].image?.url,
                                    cacheKey: widget.categories![index].name,
                                    showShimmer: false,
                                  ),
                                ),
                              );
                            },
                          )
                        else
                          SizedBox.shrink(),
                      ],
                    ),
                    3.verticalSpace,
                    Text(
                      '${widget.categories![index].name}',
                      style: AppTextStylesNew.style14BoldAlmarai.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: isTablet ? 18.r : 14.r,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (kDebugMode && 1 < 0) ...[
          Positioned(
            left: 0,
            top: 0,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Container(
                height: 140.r,
                width: 100.r,
                decoration: BoxDecoration(
                  //color: Colors.red,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(
                        context,
                      ).scaffoldBackgroundColor.withValues(alpha: 1.0),
                      Theme.of(
                        context,
                      ).scaffoldBackgroundColor.withValues(alpha: 0.6),
                      Theme.of(
                        context,
                      ).scaffoldBackgroundColor.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              height: 140.r,
              width: 100.r,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(
                      context,
                    ).scaffoldBackgroundColor.withValues(alpha: 1.0),
                    Theme.of(
                      context,
                    ).scaffoldBackgroundColor.withValues(alpha: 0.6),
                    Theme.of(
                      context,
                    ).scaffoldBackgroundColor.withValues(alpha: 0.0),
                  ],
                  end: Alignment.centerLeft,
                  begin: Alignment.centerRight,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

BoxDecoration homeDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(17.r),
    border: Border.all(width: 1.r, color: AppColorsNew.yellow1),
  );
}
