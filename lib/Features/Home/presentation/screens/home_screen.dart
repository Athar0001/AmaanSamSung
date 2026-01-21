import 'package:amaan_tv/Features/Home/presentation/widget/heros_widget.dart';
import 'package:amaan_tv/Features/characters/presentation/screens/characters_screen.dart';
import 'package:amaan_tv/Features/favorite/presentation/screens/favorite_screen.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/models/characters_model.dart';
import 'package:amaan_tv/core/utils/app_navigation.dart';
import 'package:amaan_tv/core/widget/circle_progress_helper.dart';
import 'package:flutter/material.dart';
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
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/enum.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;
  final ScrollController scrollController = ScrollController();

  void _onTabChanged(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

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
          // Content area with padding for navigation bar
          Padding(
            padding: EdgeInsets.only(
              top: 60.h + MediaQuery.of(context).padding.top,
            ),
            child: IndexedStack(
              index: _selectedTabIndex,
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
                selectedIndex: _selectedTabIndex,
                onTabChanged: _onTabChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return RefreshIndicator(
          onRefresh: context.read<HomeProvider>().getAllHomeData,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 350,
                child: Skeletonizer(
                  enabled: provider.stateBanner == AppState.loading,
                  child: HomeBannerWidget(),
                ),
              ),
              // ////////////////////////////////<---- Modules -->//////////////////////////////////////
              // if (provider.modulesModel?.data?.isNotEmpty ?? false) ...[
              //   8.verticalSpace,
              //   Skeletonizer(
              //     enabled: provider.stateModules == AppState.loading,
              //     child: CarouselSilderHomeItems(
              //       categories: provider.modulesModel!.data!,
              //     ),
              //   ),
              //   // 24.verticalSpace,
              // ],
              30.verticalSpace,
              ////////////////////////////////<---- continue watching  -->//////////////////////////////////////
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  // physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (context.read<UserNotifier>().userData != null) ...[
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
                                  HerosWidget(characters: charactersModel.data),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      50.verticalSpace,
                    ],
                  ),
                ),
              ),
              // 24.verticalSpace,
            ],
          ),
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
