import 'dart:async'; // Import for Timer
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/injection/injection_imports.dart';
import 'package:amaan_tv/Features/search/provider/search_provider.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/widget/circle_progress_helper.dart';
import 'package:amaan_tv/core/widget/max_width_widget.dart';
import 'package:amaan_tv/core/widget/scaffold_gradient_background.dart';
import 'package:provider/provider.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/utils/constant.dart';
import 'package:amaan_tv/core/widget/Text Field/text_field_widget.dart';
import 'package:amaan_tv/core/utils/enum.dart';
import '../widgets/empty_search_widget.dart';
import '../widgets/search_item_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  Timer? _debounce;
  late SearchProvider searchProvider;
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    searchProvider = sl<SearchProvider>()
      ..recentSearch()
      ..getSuggestedData();
    // Auto-focus search field on TV entrance
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() {});
    }
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), () async {
      final trimmedQuery = query.trim();

      if (trimmedQuery.isEmpty) return;

      if (searchController.text.isNotEmpty) {
        await searchProvider.searchData(searchText: query);
        // Updating recent search might be better done after clicking a result,
        // but mobile does it after search. TV typing is slow, maybe wait for explicit action?
        // Following mobile Logic for now.
        searchProvider.recentSearch();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ChangeNotifierProvider<SearchProvider>.value(
          value: searchProvider,
          builder: (context, child) {
            return Consumer<SearchProvider>(
              builder: (context, provider, child) => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Constant.paddingLeftRight,
                ),
                child: Column(
                  children: [
                    20.verticalSpace,
                    Center(
                      child: Text(
                        AppLocalization.strings.search,
                        style: AppTextStylesNew.style28ExtraBoldAlmarai,
                      ),
                    ),
                    30.verticalSpace,
                    MaxWidthWidget(
                      child: TextFieldWidget(
                        focusNode: _searchFocusNode,
                        onChanged: _onSearchChanged,
                        borderRadius: 40.r,
                        inputFormatters: [LengthLimitingTextInputFormatter(30)],
                        hintText: AppLocalization.strings.search,
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColorsNew.white1,
                        ),
                        controller: searchController,
                      ),
                    ),
                    16.verticalSpace,
                    if (searchController.text.isEmpty &&
                        UserNotifier.instance.userData != null)
                      // Using instance directly or provider if available in context.
                      // Provider is nicer. context.read<UserNotifier>()?
                      // UserNotifier is singleton registered in DI, but safer to use Provider if it's up in tree.
                      // In amaan_tv main/app it's likely provided.
                      // I'll assume UserNotifier.instance for safety or use the 'provider' argument if I passed it?
                      // SearchProvider has userNotifier.
                      Expanded(
                        child: ListView(
                          children: [
                            40.verticalSpace,
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalization.strings.searchHistory,
                                      style:
                                          AppTextStylesNew.style20BoldAlmarai,
                                    ),
                                    if (provider
                                            .recentSearchModel
                                            ?.data
                                            ?.isNotEmpty ==
                                        true)
                                      InkWell(
                                        onTap: () {
                                          provider.deleteRecentSearch();
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              AppLocalization
                                                  .strings
                                                  .clearHistory,
                                              style: AppTextStylesNew
                                                  .style12BoldAlmarai
                                                  .copyWith(
                                                    color: AppColorsNew.red3,
                                                  ),
                                            ),
                                            SizedBox(width: 8),
                                            Icon(
                                              Icons.delete,
                                              color: AppColorsNew.red3,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                                16.verticalSpace,
                                if (provider.stateRecentSearch ==
                                    AppState.loading)
                                  const AppCircleProgressHelper()
                                else if (provider.stateRecentSearch ==
                                    AppState.error)
                                  const SizedBox()
                                else if (provider
                                        .recentSearchModel
                                        ?.data
                                        ?.isNotEmpty ==
                                    true)
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: provider.recentSearchModel!.data!
                                        .map((e) {
                                          return InkWell(
                                            onTap: () {
                                              searchController.text =
                                                  e.text ?? '';
                                              provider.searchData(
                                                searchText:
                                                    searchController.text,
                                              );
                                              provider.recentSearch();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 18.w,
                                                vertical: 7.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColorsNew.white1
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                border: Border.all(
                                                  color: AppColorsNew.white1
                                                      .withOpacity(0.2),
                                                ),
                                              ),
                                              child: Text(
                                                e.text ?? '',
                                                style: AppTextStylesNew
                                                    .style12RegularAlmarai,
                                              ),
                                            ),
                                          );
                                        })
                                        .toList(),
                                  )
                                else
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalization.strings.noSearchResult,
                                        style: AppTextStylesNew
                                            .style14RegularAlmarai
                                            .copyWith(
                                              color: AppColorsNew.darkGrey1,
                                            ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            30.verticalSpace,
                            Text(
                              AppLocalization.strings.suggestionsForYou,
                              style: AppTextStylesNew.style20BoldAlmarai,
                            ),
                            16.verticalSpace,
                            if (provider.suggestedSearchState ==
                                AppState.loading)
                              const AppCircleProgressHelper()
                            else if (provider.suggestedSearchState ==
                                    AppState.success &&
                                provider
                                        .suggestedSearchModel
                                        ?.searchList
                                        ?.isNotEmpty ==
                                    true)
                              SearchItemWidget(
                                searchModel: provider.suggestedSearchModel!,
                              )
                            else
                              const SizedBox.shrink(),
                          ],
                        ),
                      )
                    else
                      provider.searchState == AppState.loading
                          ? const AppCircleProgressHelper()
                          : (provider.searchState == AppState.success &&
                                provider.searchModel?.searchList?.isNotEmpty ==
                                    true &&
                                searchController.text.isNotEmpty == true)
                          ? Expanded(
                              child: ListView(
                                children: [
                                  SearchItemWidget(
                                    searchModel: provider.searchModel!,
                                  ),
                                  110.verticalSpace,
                                ],
                              ),
                            )
                          : searchController.text.isNotEmpty == true
                          ? EmptySearchWidget(searchText: searchController.text)
                          : const SizedBox.shrink(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
