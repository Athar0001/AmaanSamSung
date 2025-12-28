import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/Features/search/data/data_source/search_service.dart';
import 'package:amaan_tv/Features/search/data/model/recent_search_model/recent_search_model.dart';
import 'package:amaan_tv/Features/search/data/model/search_model.dart';
import 'package:amaan_tv/core/utils/cash_services/cashe_helper.dart';
import 'package:amaan_tv/core/utils/enum.dart';
import 'package:flutter/material.dart';
import '../../../core/widget/app_toast.dart';

enum SearchState { init, loading, success, error }

class SearchProvider extends ChangeNotifier {
  SearchProvider(this._searchService, this.userNotifier);
  final SearchService _searchService;
  final UserNotifier userNotifier;

  SearchModel? searchModel;
  AppState searchState = AppState.init;

  Future searchData({required String searchText}) async {
    searchState = AppState.loading;
    notifyListeners();
    (await _searchService.searchData(searchText: searchText)).fold(
      (failure) {
        searchState = AppState.error;

        searchState.errorMsg(error: failure.message);
        notifyListeners();

        AppToast.show(failure.message);
      },
      (data) {
        searchState = AppState.success;
        searchModel = data;
        notifyListeners();
      },
    );
  }

  //////////////////////////////////////////////////////////////////////////////////
  AppState stateRecentSearch = AppState.init;
  RecentSearchModel? _recentSearchModel;

  RecentSearchModel get recentSearchModel => _recentSearchModel!;

  Future recentSearch() async {
    stateRecentSearch = AppState.loading;
    notifyListeners();
    CacheHelper.currentUser != null
        ? (await _searchService.recentSearch()).fold(
            (failure) {
              stateRecentSearch = AppState.error;
              searchState.errorMsg(error: failure.message);
              notifyListeners();
              AppToast.show(failure.message);
            },
            (data) {
              stateRecentSearch = AppState.success;
              _recentSearchModel = data;
              notifyListeners();
            },
          )
        : null;
  }

  //////////////////////////////////////////////////////////////////////////////////
  AppState stateDeleteRecentSearch = AppState.init;

  Future deleteRecentSearch() async {
    stateDeleteRecentSearch = AppState.loading;
    _recentSearchModel?.data?.clear();
    notifyListeners();
    (await _searchService.deleteRecentSearch()).fold(
      (failure) {
        stateDeleteRecentSearch = AppState.error;
        searchState.errorMsg(error: failure.message);
        notifyListeners();
        AppToast.show(failure.message);
      },
      (data) {
        stateDeleteRecentSearch = AppState.success;
        notifyListeners();
      },
    );
  }

  //////////////////////////////////////////////////////////////////////////////////
  SearchModel? _suggestedSearchModel;

  SearchModel get suggestedSearchModel => _suggestedSearchModel!;
  AppState suggestedSearchState = AppState.init;

  Future getSuggestedData() async {
    suggestedSearchState = AppState.loading;
    notifyListeners();
    (await _searchService.getSuggestedData()).fold(
      (failure) {
        suggestedSearchState = AppState.error;
        suggestedSearchState.errorMsg(error: failure.message);
        notifyListeners();
      },
      (data) {
        suggestedSearchState = AppState.success;
        _suggestedSearchModel = data;
        notifyListeners();
      },
    );
  }
}
