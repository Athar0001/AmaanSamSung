
import 'dart:io';

import 'package:amaan_tv/Features/Home/presentation/widget/heros_widget.dart';
import 'package:amaan_tv/Features/favorite/presentation/screens/favorite_screen.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/models/characters_model.dart';
import 'package:amaan_tv/core/utils/app_navigation.dart';
import 'package:amaan_tv/core/widget/circle_progress_helper.dart';
import 'package:amaan_tv/core/widget/custom_dialog.dart';
import 'package:amaan_tv/core/widget/tv_click.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/Features/Home/provider/home_provider.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/continue_watching_widget.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/home_poster_widget.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/top_ten_widget.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/series_content_view.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/constant.dart';
import 'package:amaan_tv/core/widget/scaffold_gradient_background.dart';
import 'package:amaan_tv/core/widget/app_navigation_bar.dart';
import 'package:flutter_state_provider/flutter_state_provider.dart';
import 'package:provider/provider.dart';
import 'package:simple_tv_navigation/simple_tv_navigation.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/utils/focus_helper.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final ScrollController scrollController = ScrollController();



  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<UserNotifier>().userData != null) {
        context.read<HomeProvider>().getAllHomeData();
        context.setFocus(FocusKeys.homeTab);
      }
    });
  }

  @override
  void dispose() {

    scrollController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 60.h + MediaQuery.of(context).padding.top,
                ),
                child: IndexedStack(
                  index: provider.selectedTabIndex,
                  children: [
                    // Tab 0: Home Content
                    _buildHomeContent(),
                    // Tab 1: Series Content
                    SeriesContentView(),
                    // Tab 2: Favorites Content
                    _buildFavoritesContent(),
                  ],
                ),
              ),
              // Navigation Bar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: AppNavigationBar(
                    selectedIndex: provider.selectedTabIndex,
                    onTabChanged: provider.onTabChanged,
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }

  Widget _buildHomeContent() {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return  ListView(
          children: [
            20.verticalSpace,
            SizedBox(
              height: 500,
              child: Skeletonizer(
                enabled: provider.stateBanner == AppState.loading,
                child: HomeBannerWidget(
                  onFocus: (){
                    // Scrollable.of(context)..animateTo(
                    //   0,
                    //   duration: const Duration(milliseconds: 300),
                    //   curve: Curves.easeInOut,
                    // );

                  },
                ),
              ),
            ),
            30.verticalSpace,
            // if (context.read<UserNotifier>().userData != null) ...[
              Skeletonizer(
                enabled: provider.stateContinueWatching ==
                    AppState.loading,
                child: provider.stateContinueWatching ==
                    AppState.success &&
                    provider
                        .continueWatchingModel!.data!.isNotEmpty
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: Constant.paddingLeftRight,
                      ),
                      child: Text(
                        AppLocalization
                            .strings.continueWatching,
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
            // ],

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
                child: provider.suggestedSearchState ==
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
                            .strings.suggestionsForYou,
                        style:
                        AppTextStylesNew.style16BoldAlmarai,
                      ),
                    ),
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
            //////////////<---- characters  -->//////////////////////////////////////
            Selector<HomeProvider,
                StateProvider<CharactersModel, String>>(
              selector: (context, provider) =>
              provider.stateCharacters,
              builder: (context, stateCharacters, child) {
                return provider.stateCharacters.when<Widget>(
                      () => const AppCircleProgressHelper(),
                      (error) => SizedBox.shrink(),
                      (data) {
                    final charactersModel = data;
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Constant.paddingLeftRight,
                          ),
                          child: Row(
                            children: [
                              Text(
                                AppLocalization.strings.characters,
                                style: AppTextStylesNew
                                    .style16BoldAlmarai,
                              ),
                              // Spacer(),
                              // InkWell(
                              //   onTap: () {
                              //     AppNavigation.navigationPush<void>(
                              //       context,
                              //       screen: CharactersScreen(),
                              //     );
                              //   },
                              //   child: Text(
                              //     AppLocalization.strings.more,
                              //     style: AppTextStylesNew
                              //         .style16BoldAlmarai
                              //         .copyWith(
                              //       color: AppColorsNew.primary,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        16.verticalSpace,
                        HerosWidgetHome(characters: charactersModel.data),
                      ],
                    );
                  },
                );
              },
            ),
            50.verticalSpace,
          ],
        );
      },
    );
  }

  Widget _buildFavoritesContent() {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: FavoriteScreen(),
    );
  }
}
