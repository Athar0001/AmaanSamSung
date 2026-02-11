import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/Features/Home/provider/home_provider.dart';
import 'package:amaan_tv/core/widget/buttons/back_button.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:amaan_tv/Features/search/provider/search_provider.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/injection/injection_imports.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/asset_manager.dart';
import 'package:amaan_tv/core/widget/SVG_Image/svg_img.dart';
import 'package:amaan_tv/core/widget/circle_progress_helper.dart';
import 'package:amaan_tv/core/widget/max_width_widget.dart';
import 'package:amaan_tv/core/widget/radio%20button/radio_button_multi_select_package.dart';
import 'package:amaan_tv/core/widget/scaffold_gradient_background.dart';
import 'package:couchkeys/couchkeys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simple_tv_navigation/simple_tv_navigation.dart';
import '../../../../core/Themes/app_text_styles_new.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/focus_helper.dart';
import '../../../../core/widget/Text Field/text_field_widget.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/widget/keyboard_widget.dart';
import '../../../../core/widget/tv_click.dart';
import '../widgets/empty_search_widget.dart';
import '../widgets/search_item_widget.dart';
import 'dart:async'; // Import for Timer

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  Timer? _debounce;
  late SearchProvider searchProvider;
  final FocusNode _searchInputFocus = FocusNode();
  @override
  void dispose() {
    _debounce
        ?.cancel(); // Cancel the debounce timer when the widget is disposed
    searchController.dispose();
    _searchInputFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.setFocus(FocusKeys.searchInput);
    searchProvider = sl<SearchProvider>()
      ..recentSearch()
      ..getSuggestedData();
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() {});
    }
    // Cancel any existing timer
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    // Set a new timer
    _debounce = Timer(const Duration(milliseconds: 700), () async {
      // Trim the query to remove leading and trailing spaces
      final trimmedQuery = query.trim();

      // If the trimmed query is empty, do nothing
      if (trimmedQuery.isEmpty) {
        return;
      }
      // Trigger search logic after debounce time
      if (searchController.text.isNotEmpty) {
        await searchProvider.searchData(searchText: query);
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
                padding: EdgeInsets.only(
                  right: Constant.paddingLeftRight,
                  left: Constant.paddingLeftRight,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TvClick(
                          id: FocusKeys.searchBack,
                          downId: FocusKeys.searchInput,
                          onSelect: (){
                            Navigator.pop(context);
                          },
                          child: BackButtonWidget(
                            onPressed: (){},
                          ),
                        ),
                      ),
                    ),
                    12.verticalSpace,
                    Center(
                      child: Text(
                        AppLocalization.strings.search,
                        style: AppTextStylesNew.style20BoldAlmarai,
                      ),
                    ),
                    12.verticalSpace,
                    MaxWidthWidget(
                      child: TvClick(
                        id: FocusKeys.searchInput,
                        upId: FocusKeys.searchBack,
                        dynamicDownId: () {


                          if (searchController.text.isEmpty &&
                              provider.recentSearchModel?.data?.isNotEmpty == true) {
                            return FocusKeys.searchDeleteHistory;
                          }

                         else if (provider.searchModel?.searchList?.isNotEmpty == true) {
                            return FocusId.grid(FocusKeys.searchResults, 0, 0);
                          }

                          else if (provider.suggestedSearchModel.searchList?.isNotEmpty == true) {
                            return FocusId.list(FocusKeys.searchSuggestions, 0);
                          }

                          return FocusKeys.searchDeleteHistory;
                        },
                        radius:  40.r,
                        onSelect: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            barrierColor: Colors.transparent,
                            constraints: BoxConstraints(
                              minWidth:  1.sw,
                              minHeight: 200
                            ),
                            builder: (_) {
                              return TvKeyboardOverlay(
                              controller: searchController,
                              initialArabic: true,
                              onDone: () {
                                Navigator.pop(context);
                                context.setFocus(FocusKeys.searchInput);
                              },
                              onSearch: () async {
                                await provider.searchData(searchText: searchController.text);
                                provider.recentSearch();
                                Navigator.pop(context);
                                context.setFocus(FocusId.grid(FocusKeys.searchResults, 0, 0));
                              },
                                                             );
                            },
                          ).then((value){
                            if(provider.searchModel!.searchList?.isEmpty == true){
                              context.setFocus(FocusKeys.searchInput);
                            }
                          });
                        },

                        child: TextFieldWidget(
                          onChanged: _onSearchChanged,
                          focusNode: _searchInputFocus,
                          borderRadius: 40.r,
                          readOnly: false,
                          enableInteractiveSelection: true,
                          onFieldSubmitted: (value) {
                            _searchInputFocus.unfocus();
                            SystemChannels.textInput.invokeMethod('TextInput.hide');

                            // optional: run search
                            _onSearchChanged(value);
                          },
                          textInputAction: TextInputAction.search,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30),
                          ],
                          hintText: AppLocalization.strings.search,
                          prefixIcon: SVGImage(path: Assets.imagesSearch),
                          controller: searchController,
                        ),
                      ),
                    ),
                    40.verticalSpace,
                    if (searchController.text.isEmpty &&
                        context.read<UserNotifier>().userData != null)
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
                                    if(provider.recentSearchModel?.data?.isNotEmpty == true)
                                    TvClick(
                                      id: FocusKeys.searchDeleteHistory,
                                      upId: FocusKeys.searchInput,
                                      downId: FocusId.list(FocusKeys.searchHistory, 0),
                                      onSelect: () {
                                        provider.deleteRecentSearch();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              AppLocalization
                                                  .strings.clearHistory,
                                              style: AppTextStylesNew
                                                  .style12BoldAlmarai
                                                  .copyWith(
                                                color: AppColorsNew.red3,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            SVGImage(
                                              path: Assets.imagesTrash,
                                              color: AppColorsNew.red3,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                16.verticalSpace,
                                if (provider.stateRecentSearch ==
                                    AppState.loading)
                                  const AppCircleProgressHelper()
                                else
                                  provider.stateRecentSearch == AppState.error
                                      ? const SizedBox()
                                      : (provider.recentSearchModel?.data?.isNotEmpty ?? true)
                                          ? Wrap(
                                              children: (provider
                                                  .recentSearchModel?.data ?? []).asMap()
                                                  .entries
                                                  .map((entry) {
                                                final index = entry.key;
                                                final e = entry.value;
                                                return Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: TvClick(
                                                    id: FocusId.list(FocusKeys.searchHistory, index),
                                                    isList: true,
                                                    listBaseId: FocusKeys.searchHistory,
                                                    index: index,
                                                    length: provider.recentSearchModel?.data?.length ?? 0,
                                                    upId: FocusKeys.searchDeleteHistory,
                                                    dynamicDownId: () {
                                                      if (provider.searchModel?.searchList?.isNotEmpty == true) {
                                                        return FocusId.list(FocusKeys.searchResults, 0);
                                                      }
                                                      if (provider.suggestedSearchModel.searchList?.isNotEmpty == true) {
                                                        return FocusId.list(FocusKeys.searchSuggestions, 0);
                                                      }
                                                      return null;
                                                    },

                                                    onSelect: () {
                                                      searchController.text =
                                                          e.text ?? '';
                                                      provider.searchData(
                                                        searchText:
                                                            searchController.text,
                                                      );
                                                      provider.recentSearch();
                                                      context.setFocus(FocusKeys.searchInput);
                                                    },
                                                    child: Container(

                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 18.w,
                                                        vertical: 7.h,
                                                      ),
                                                      decoration:
                                                          containerDecoration(
                                                        context,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                          20.r,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        e.text ?? '',
                                                        style: AppTextStylesNew
                                                            .style12RegularAlmarai,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            )
                                          : Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalization
                                                      .strings.noSearchResult,
                                                  style: AppTextStylesNew
                                                      .style14RegularAlmarai
                                                      .copyWith(
                                                    color:
                                                        AppColorsNew.darkGrey1,
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
                            50.verticalSpace,
                            if (provider.suggestedSearchState ==
                                AppState.loading)
                              const AppCircleProgressHelper()
                            else
                              (provider.suggestedSearchState ==
                                          AppState.success &&
                                      provider.suggestedSearchModel.searchList
                                              ?.isNotEmpty ==
                                          true)
                                  ? SearchItemWidget(
                                      searchModel:
                                          provider.suggestedSearchModel,
                                    )
                                  : const SizedBox.shrink(),
                          ],
                        ),
                      )
                    else
                      provider.searchState == AppState.loading
                          ? const AppCircleProgressHelper()
                          : (provider.searchState == AppState.success &&
                                  provider.searchModel?.searchList
                                          ?.isNotEmpty ==
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
                                  ? EmptySearchWidget(
                                      searchText: searchController.text)
                                  : const SizedBox.shrink(),
                    // CacheHelper.currentUser != null
                    //     ? CacheHelper.currentUser!.userType.isChild
                    //         ? 0.verticalSpace
                    //         : 90.verticalSpace
                    //     : 90.verticalSpace
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
