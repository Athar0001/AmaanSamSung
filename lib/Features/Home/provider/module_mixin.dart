import 'package:flutter/widgets.dart';
import 'package:amaan_tv/Features/Home/data/data_source/home_service.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/Features/Home/data/models/home/shows_model.dart';
import 'package:amaan_tv/Features/Home/data/models/home_categories_model/home_categories_model.dart';
import 'package:amaan_tv/Features/Home/data/models/home_dummy.dart';
import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/sub_categories_model.dart';
import 'package:amaan_tv/Features/Home/data/models/top_shows_model/top_shows_model.dart';

import 'package:amaan_tv/core/utils/enum.dart';
import 'package:amaan_tv/core/widget/app_toast.dart';

mixin APICalls on ChangeNotifier {
  Module get module;

  HomeService get homeService;

  // Pagination parameters
  int _currentPage = 1;
  final int _pageSize = 10;
  bool _hasMoreData = true;
  bool _isLoadingMore = false;

  // Getters for pagination state
  int get currentPage => _currentPage;

  bool get hasMoreData => _hasMoreData;

  bool get isLoadingMore => _isLoadingMore;

  HomeCategoriesModel? _categoriesModel;

  HomeCategoriesModel? get categoriesModel => _categoriesModel;
  AppState stateCategories = AppState.init;

  Future getCategoriesProvide() async {
    stateCategories = AppState.loading;
    notifyListeners();
    (await homeService.getHomeCategories(module: module)).fold(
      (failure) {
        stateCategories = AppState.error;
        stateCategories.errorMsg(error: failure.message);
        AppToast.show(failure.message);
        notifyListeners();
      },
      (data) {
        _categoriesModel = data;
        stateCategories = AppState.success;
        categoriesModel!.data!.isNotEmpty
            ? getShowsCategoryProvide(categoryId: categoriesModel!.data![0].id)
            : null;
        notifyListeners();
      },
    );
  }

  /////////////////////////////////////////////////////////////////////////////////

  SubCategoriesModel? _subCategoriesModel;

  SubCategoriesModel? get subCategoriesModel => _subCategoriesModel;
  AppState stateSubCategories = AppState.init;

  Future getSubCategoriesProvide({required String id}) async {
    stateSubCategories = AppState.loading;
    notifyListeners();
    (await homeService.getSubCategories(id: id, module: module)).fold(
      (failure) {
        stateSubCategories = AppState.error;
        stateSubCategories.errorMsg(error: failure.message);
        AppToast.show(failure.message);
        notifyListeners();
      },
      (data) {
        data.data!.childCategories!.isNotEmpty
            ? getShowsCategoryProvide(
                categoryId: data.data!.childCategories!.first.id,
              )
            : null;
        _subCategoriesModel = data;
        stateSubCategories = AppState.success;
        notifyListeners();
      },
    );
  }

  /////////////////////////////////////////////////////////////////////////////////

  ShowsModel? _showsModel;

  ShowsModel? get showsModel => _showsModel;
  AppState stateShows = AppState.init;

  // Method to reset pagination when changing categories
  void _resetPagination() {
    _currentPage = 1;
    _hasMoreData = true;
    _showsModel = null;
  }

  // Initial data load - resets pagination
  Future getShowsCategoryProvide({
    String? categoryId,
    String? characterId,
    String? search,
  }) async {
    _resetPagination();
    stateShows = AppState.loading;
    notifyListeners();

    await _fetchShowsPage(
      categoryId: categoryId,
      characterId: characterId,
      search: search,
    );
  }

  void resetShowsCategoryProvide() {
    _resetPagination();
    stateShows = AppState.init;
    notifyListeners();
  }

  // Load more data - increments page
  Future loadMoreShows({String? categoryId, String? characterId}) async {
    if (!_hasMoreData || _isLoadingMore) return;

    _isLoadingMore = true;
    notifyListeners();

    await _fetchShowsPage(
      categoryId: categoryId,
      characterId: characterId,
      isLoadMore: true,
    );
  }

  // Common fetch method for initial and load more
  Future _fetchShowsPage({
    String? categoryId,
    String? characterId,
    String? search,
    bool isLoadMore = false,
  }) async {
    (await homeService.getShows(
      module: module,
      categoryId: categoryId,
      characterId: characterId,
      page: _currentPage,
      pageSize: _pageSize,
      search: search,
    )).fold(
      (failure) {
        stateShows = AppState.error;
        stateShows.errorMsg(error: failure.message);
        AppToast.show(failure.message);
        _isLoadingMore = false;
        notifyListeners();
      },
      (data) {
        if (isLoadMore) {
          // Append new data to existing data
          if (_showsModel != null && _showsModel!.data != null) {
            if (data.data != null && data.data!.isNotEmpty) {
              _showsModel!.data!.addAll(data.data!);
            }
          } else {
            _showsModel = data;
          }
        } else {
          // First page load
          _showsModel = data;
        }

        // Always update hasMoreData from pagination
        _hasMoreData = data.pagination?.hasNextPage ?? false;

        // Only increment page if there's more data
        if (_hasMoreData) {
          _currentPage++;
        }

        stateShows = AppState.success;
        _isLoadingMore = false;
        notifyListeners();
      },
    );
  }

  // Method to check if we should load more data (for scroll listeners)
  bool shouldLoadMore(int index) {
    return hasMoreData &&
        !isLoadingMore &&
        index == (_showsModel?.data?.length ?? 0) - 3;
  }

  // Favorite update method (keeping this from your existing code)
  void updateFav(String? id, bool isFavorite) {
    // if (id == null || _showsModel?.data == null) return;
    //
    // final index = _showsModel!.data!.indexWhere((element) => element.id == id);
    // if (index != -1) {
    //   _showsModel!.data![index].isFavorite = isFavorite;
    //   notifyListeners();
    // }
  }

  /////////////////////////////////////////////////////////////////////////////////

  ContinueWatchingModel? _latestModel = ContinueWatchingModel.fromJson(
    HomeDummy.continueWatching,
  );

  //latest
  ContinueWatchingModel? get latestModel => _latestModel;
  AppState stateLatest = AppState.init;

  Future getLatestProvide() async {
    stateLatest = AppState.loading;
    notifyListeners();
    (await homeService.getLatest(module: module)).fold(
      (failure) {
        stateLatest = AppState.error;
        stateLatest.errorMsg(error: failure.message);
        AppToast.show(failure.message);
        notifyListeners();
      },
      (data) {
        _latestModel = data;
        stateLatest = AppState.success;
        notifyListeners();
      },
    );
  }

  /////////////////////////////////////////////////////////////////////////////////

  ContinueWatchingModel? _suggestedModel;

  ContinueWatchingModel get suggestedSearchModel => _suggestedModel!;
  AppState suggestedSearchState = AppState.init;

  Future getSuggestedData() async {
    suggestedSearchState = AppState.loading;
    notifyListeners();
    (await homeService.getSuggestedData(module: module)).fold(
      (failure) {
        suggestedSearchState = AppState.error;
        suggestedSearchState.errorMsg(error: failure.message);
        notifyListeners();
      },
      (data) {
        suggestedSearchState = AppState.success;
        _suggestedModel = data;
        notifyListeners();
      },
    );
  }
}
