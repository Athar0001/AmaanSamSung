import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_provider/flutter_state_provider.dart';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/Features/Home/data/models/home_categories_model/home_categories_model.dart';
import 'package:amaan_tv/Features/Home/data/models/home_dummy.dart';
import 'package:amaan_tv/Features/Home/data/models/top_shows_model/top_shows_model.dart';
import 'package:amaan_tv/Features/Home/data/models/top_ten_model/top_ten_model.dart';
import 'package:amaan_tv/Features/Home/provider/module_mixin.dart';
import '../../../core/utils/enum.dart';
import '../data/models/home/banner_model.dart';
import '../../../core/models/characters_model.dart';
import '../data/models/home/reals_model.dart';
import '../data/data_source/home_service.dart';
import '../../../core/widget/app_toast.dart';

class HomeProvider extends ChangeNotifier with APICalls {
  HomeProvider(this.homeService, this.userNotifier);
  @override
  Module get module => Module.video;
  final HomeService homeService;
  final UserNotifier userNotifier;

  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    reelsTimer?.cancel();
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }

  BannerModel? _bannerModel;

  BannerModel? get bannerModel => _bannerModel;
  AppState stateBanner = AppState.init;

  Future getBannerProvider() async {
    try {
      stateBanner = AppState.loading;
      notifyListeners();

      final result = await homeService.getBannerService();
      result.fold(
        (failure) {
          stateBanner = AppState.error;

          notifyListeners();
        },
        (data) {
          _bannerModel = data;
          stateBanner = AppState.success;
          notifyListeners();
        },
      );
    } catch (e) {
      stateBanner = AppState.error;
      notifyListeners();
    }
  }

  Future<void> getAllHomeData() async {
    await Future.wait([
      getModules(),
      // if (AppFlavor.data.showModules) getModules() else getCategoriesProvide(),
      getCharactersProvide(),
      getTopTenProvide(),
      getLatestProvide(),
      // getLiveRadio(),
      getLatestReels(),
      getBannerProvider(),
      getContinueWatchingProvide(),
      getSuggestedData(),
    ]);
  }

  /////////////////////////////////////////////////////////////////////////////////
  ReelsModel _reelsModel = ReelsModel.fromJson(HomeDummy.reels);

  ReelsModel? get reelsModel => _reelsModel;
  AppState stateReels = AppState.init;

  Timer? reelsTimer;

  void initTimer() {
    reelsTimer?.cancel();
    reelsTimer = Timer(const Duration(minutes: 100), () {
      log('getAllReelsProvider', name: 'reelsTimer');
      getAllReelsProvider(showLoadingState: false);
    });
  }

  /////////////////////////////////////////////////////////////////////////////////

  Future getAllReelsProvider({bool showLoadingState = true}) async {
    initTimer();
    if (showLoadingState) {
      stateReels = AppState.loading;
      notifyListeners();
    }
    (await homeService.getAllReelsService()).fold(
      (failure) {
        if (showLoadingState) {
          stateReels = AppState.error;
          stateReels.errorMsg(error: failure.message);
          AppToast.show(failure.message);
          notifyListeners();
        }
      },
      (data) {
        _reelsModel = data;
        stateReels = AppState.success;
        notifyListeners();
      },
    );
  }

  /////////////////////////////////////////////////////////////////////////////////
  ReelsModel _reelsHomeModel = ReelsModel.fromJson(HomeDummy.reels);

  ReelsModel? get reelsHomeModel => _reelsHomeModel;
  AppState stateHomeReels = AppState.init;

  Future getLatestReels({bool showLoadingState = true}) async {
    initTimer();
    if (showLoadingState) {
      stateHomeReels = AppState.loading;
      notifyListeners();
    }
    (await homeService.getLatestReels()).fold(
      (failure) {
        if (showLoadingState) {
          stateHomeReels = AppState.error;
          stateHomeReels.errorMsg(error: failure.message);
          AppToast.show(failure.message);
          notifyListeners();
        }
      },
      (data) {
        _reelsHomeModel = data;
        stateHomeReels = AppState.success;
        notifyListeners();
      },
    );
  }

  /////////////////////////////////////////////////////////////////////////////////

  StateProvider<CharactersModel, String> stateCharacters =
      const StateProvider.loading();
  CharactersModel? charactersModel;

  Future getCharactersProvide() async {
    stateCharacters = const StateProvider.loading();
    notifyListeners();
    (await homeService.getCharacters()).fold(
      (failure) {
        stateCharacters = StateProvider.error(failure.message);
        AppToast.show(failure.message);
        notifyListeners();
      },
      (data) {
        data.data.shuffle();
        charactersModel = data;
        stateCharacters = StateProvider.success(data);
        notifyListeners();
      },
    );
  }

  /////////////////////////////////////////////////////////////////////////////////
  CharactersModel? _charactersModelShows;

  CharactersModel? get charactersModelShows => _charactersModelShows;

  StateProvider<CharactersModel, String> stateCharactersShows =
      const StateProvider.loading();

  // Future getCharactersShows({required String id}) async {
  //   stateCharactersShows = const StateProvider.loading();
  //   notifyListeners();
  //   (await homeService.getShowDetailsCharacters(id: id)).fold((failure) {
  //     stateCharactersShows = StateProvider.error(failure.message);
  //
  //     AppToast.show(failure.message);
  //     notifyListeners();
  //   }, (data) {
  //     _charactersModelShows = data;
  //     stateCharactersShows = StateProvider.success(data);
  //     notifyListeners();
  //   });
  // }

  /////////////////////////////////////////////////////////////////////////////////

  HomeCategoriesModel? _modulesModel;

  HomeCategoriesModel? get modulesModel => _modulesModel;

  // AppFlavor.data.showModules ? _modulesModel : categoriesModel;
  AppState _stateModules = AppState.init;

  AppState get stateModules => _stateModules;

  Future getModules() async {
    _stateModules = AppState.loading;
    notifyListeners();
    (await homeService.getHomeModules()).fold(
      (failure) {
        _stateModules = AppState.error;
        _stateModules.errorMsg(error: failure.message);
        AppToast.show(failure.message);
        notifyListeners();
      },
      (data) {
        _modulesModel = data;
        _stateModules = AppState.success;
        notifyListeners();
      },
    );
  }

  /////////////////////////////////////////////////////////////////////////////////

  TopTenShowsModel? _topTenModel = TopTenShowsModel.fromJson(
    HomeDummy.topShows,
  );

  TopTenShowsModel? get topTenModel => _topTenModel;
  AppState stateTopTen = AppState.init;

  Future getTopTenProvide() async {
    stateTopTen = AppState.loading;
    notifyListeners();
    (await homeService.topTen(module: module)).fold(
      (failure) {
        stateTopTen = AppState.error;
        stateTopTen.errorMsg(error: failure.message);
        AppToast.show(failure.message);
        notifyListeners();
      },
      (data) {
        _topTenModel = data;
        stateTopTen = AppState.success;
        notifyListeners();
      },
    );
  }

  /////////////////////////////////////////////////////////////////////////////////

  ContinueWatchingModel? _cotinueWatchingModel = ContinueWatchingModel.fromJson(
    HomeDummy.continueWatching,
  );

  ContinueWatchingModel? get continueWatchingModel => _cotinueWatchingModel;
  AppState stateContinueWatching = AppState.init;

  //need to change end point to top ten
  Future getContinueWatchingProvide() async {
    stateContinueWatching = AppState.loading;
    notifyListeners();
    (await homeService.getInCompletedShows(module: module)).fold(
      (failure) {
        stateContinueWatching = AppState.error;
        stateContinueWatching.errorMsg(error: failure.message);
        AppToast.show(failure.message);
        notifyListeners();
      },
      (data) {
        _cotinueWatchingModel = data;
        stateContinueWatching = AppState.success;
        notifyListeners();
      },
    );
  }

  /////////////////////////////////////////////////////////////////////////////////
}
