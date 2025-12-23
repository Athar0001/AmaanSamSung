import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/Features/Home/provider/home_provider.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/carousel_silder_home_item.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/continue_watching_widget.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/home_poster_widget.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/top_ten_widget.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/constant.dart';
import 'package:amaan_tv/core/widget/scaffold_gradient_background.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/enum.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<UserNotifier>().userData != null) {
        context.read<HomeProvider>().getAllHomeData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      body: Stack(
        children: [
          Consumer<HomeProvider>(
            builder: (context, provider, child) {
              return RefreshIndicator(
                onRefresh: context.read<HomeProvider>().getAllHomeData,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Skeletonizer(
                          enabled: provider.stateBanner == AppState.loading,
                          child: HomeBannerWidget(),
                        ),
                      ),
                      ////////////////////////////////<---- Modules -->//////////////////////////////////////
                      if (provider.modulesModel?.data?.isNotEmpty ?? false) ...[
                        8.verticalSpace,
                        Skeletonizer(
                          enabled: provider.stateModules == AppState.loading,
                          child: CarouselSilderHomeItems(
                            categories: provider.modulesModel!.data!,
                          ),
                        ),
                        // 24.verticalSpace,
                      ],
                      ////////////////////////////////<---- continue watching  -->//////////////////////////////////////
                      if (context.read<UserNotifier>().userData != null) ...[
                        Skeletonizer(
                          enabled:
                              provider.stateContinueWatching ==
                              AppState.loading,
                          child:
                              provider.stateContinueWatching ==
                                      AppState.success &&
                                  provider
                                      .continueWatchingModel!
                                      .data!
                                      .isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        start: Constant.paddingLeftRight,
                                      ),
                                      child: Text(
                                        AppLocalization
                                            .strings
                                            .continueWatching,
                                        style:
                                            AppTextStylesNew.style16BoldAlmarai,
                                      ),
                                    ),
                                    16.verticalSpace,
                                    ContinueWatchingWidget(
                                      cotinueWatchingModel:
                                          provider.continueWatchingModel!,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                        ),
                        24.verticalSpace,
                      ],

                      ////////////////////////////////<---- whatIsNew  -->//////////////////////////////////////
                      Skeletonizer(
                        enabled: provider.stateLatest == AppState.loading,
                        child: Builder(
                          builder: (context) {
                            final latest = provider.latestModel?.data;
                            if (latest == null || latest.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    start: Constant.paddingLeftRight,
                                  ),
                                  child: Text(
                                    AppLocalization.strings.whatIsNew,
                                    style: AppTextStylesNew.style16BoldAlmarai,
                                  ),
                                ),
                                16.verticalSpace,
                                TopTenWidget(
                                  topTenModel: latest,
                                  isTopTenWidget: false,
                                  isNew: true,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      24.verticalSpace,
                      ////////////////////////////////<---- top ten  -->//////////////////////////////////////
                      Skeletonizer(
                        enabled: provider.stateTopTen == AppState.loading,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                start: Constant.paddingLeftRight,
                              ),
                              child: Text(
                                AppLocalization.strings.topTen,
                                style: AppTextStylesNew.style16BoldAlmarai,
                              ),
                            ),
                            16.verticalSpace,
                            TopTenWidget(
                              topTenModel:
                                  provider.topTenModel!.data!.topShows!,
                            ),
                          ],
                        ),
                      ),
                      24.verticalSpace,
                      ////////////////////////////////<---- suggested  -->//////////////////////////////////////
                      if (context.read<UserNotifier>().userData != null)
                        Skeletonizer(
                          enabled:
                              provider.suggestedSearchState == AppState.loading,
                          child:
                              provider.suggestedSearchState ==
                                      AppState.success &&
                                  (provider.suggestedSearchModel.data ?? [])
                                      .isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        start: Constant.paddingLeftRight,
                                      ),
                                      child: Text(
                                        AppLocalization
                                            .strings
                                            .suggestionsForYou,
                                        style:
                                            AppTextStylesNew.style16BoldAlmarai,
                                      ),
                                    ),
                                    16.verticalSpace,
                                    TopTenWidget(
                                      topTenModel:
                                          provider.suggestedSearchModel.data!,
                                      isTopTenWidget: false,
                                    ),
                                    16.verticalSpace,
                                  ],
                                )
                              : SizedBox(),
                        ),
                      // 24.verticalSpace,
                      130.verticalSpace,
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
