import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_provider/flutter_state_provider.dart';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/Features/Home/data/data_source/home_service.dart';
import 'package:amaan_tv/Features/Home/data/models/home/episodes_show_model/episodes_show_model.dart';
import 'package:amaan_tv/Features/Home/data/models/home/related_model/related_model.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/Features/Home/data/models/show_seasons_model/show_seasons_model.dart';
import 'package:amaan_tv/Features/Home/data/models/video_model.dart';
import 'package:amaan_tv/core/models/characters_model.dart';
import 'package:amaan_tv/core/utils/enum.dart';
import 'package:provider/provider.dart';

class ShowProvider extends ChangeNotifier {
  ShowProvider(this.homeService, this.userNotifier);
  HomeService homeService;
  final UserNotifier userNotifier;

  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }

  String showId = '';

  Future<void> getAllData(String id) async {
    showId = id;
    await Future.wait([
      getShowDetailsProvide(),
      getRelatedShowsProvide(),
      getShowsEpisodesProvide(),
      getCharactersShows(id: id, page: 1),
      // Time validation removed for now as TimeProvider might be missing or different
    ]);
  }

  /////////////////////////////////////////////////////////////////////////////////
  CharactersModel? _charactersModelShows;

  CharactersModel? get charactersModelShows => _charactersModelShows;

  StateProvider<CharactersModel, String> stateCharactersShows =
      const StateProvider.loading();
  bool hasMore = true;
  bool isLoading = false;

  Future getCharactersShows({required String id, required int page}) async {
    if (isLoading || !hasMore) return;
    if (page == 1) {
      stateCharactersShows = const StateProvider.loading();
    } else {
      isLoading = true;
    }
    notifyListeners();
    (await homeService.getShowDetailsCharacters(id: id, page: page)).fold(
      (failure) {
        stateCharactersShows = StateProvider.error(failure.message);
        notifyListeners();
      },
      (data) {
        if (page == 1) {
          _charactersModelShows = data;
        } else {
          _charactersModelShows?.data.addAll(data.data);
        }
        hasMore = data.pagination?.hasNextPage ?? false;
        stateCharactersShows = StateProvider.success(_charactersModelShows);
        isLoading = false;
        notifyListeners();
      },
    );
  }

  /////////////////////////////////////////////////////////////////////////////////

  Details? _showDetailsModel;

  Details? get showDetailsModel => _showDetailsModel;
  AppState stateShowDetails = AppState.init;

  Future<void> getShowDetailsProvide() async {
    stateShowDetails = AppState.loading;
    notifyListeners();
    (await homeService.getShowDetials(id: showId)).fold(
      (failure) {
        stateShowDetails = AppState.error;
        stateShowDetails.errorMsg(error: failure.message);
        notifyListeners();
      },
      (data) {
        _showDetailsModel = data;
        stateShowDetails = AppState.success;
        generateVideoUrl();
        notifyListeners();

        if (data.showUniverse?.id != null) {
          getSeasons(id: data.showUniverse!.id!);
        }
      },
    );
  }

  /////////////////////////////////////////////////////////////////////////////////

  ShowSeasonsModel? _seasonsModel;

  ShowSeasonsModel? get seasonsModel => _seasonsModel;
  StateProvider stateSeasons = const StateProvider.loading();

  Future getSeasons({required String id}) async {
    stateSeasons = const StateProvider.loading();
    notifyListeners();
    (await homeService.getSeasons(id: id)).fold(
      (failure) {
        stateSeasons = StateProvider.error(failure.message);
        notifyListeners();
      },
      (data) {
        _seasonsModel = data;
        stateSeasons = const StateProvider.success();
        notifyListeners();
      },
    );
  }

  /////////////////////////////////////////////////////////////////////////////////

  List<RelatedModel> relatedModels = [];
  RelatedModel? _relatedModel;

  RelatedModel? get relatedModel => _relatedModel;
  AppState stateRelatedShows = AppState.loading;

  Future<void> getRelatedShowsProvide() async {
    stateRelatedShows = AppState.loading;
    notifyListeners();
    (await homeService.getRelatedShows(id: showId)).fold(
      (failure) {
        stateRelatedShows = AppState.error;
        stateRelatedShows.errorMsg(error: failure.message);
        notifyListeners();
      },
      (data) {
        _relatedModel = data;
        stateRelatedShows = AppState.success;
        notifyListeners();
      },
    );
  }

  /////////////////////////////////////////////////////////////////////////////////

  EpisodesShowModel? _showsEpisodesModel;

  EpisodesShowModel? get showsEpisodesModel => _showsEpisodesModel;
  AppState stateShowsEpisodes = AppState.init;

  Future<void> getShowsEpisodesProvide() async {
    stateShowsEpisodes = AppState.loading;
    notifyListeners();
    (await homeService.getEpisodeShows(
      id: showId,
      pageNumber: 1,
      pageSize: 500,
    )).fold(
      (failure) {
        stateShowsEpisodes = AppState.error;
        stateShowsEpisodes.errorMsg(error: failure.message);
        notifyListeners();
      },
      (data) {
        _showsEpisodesModel = data;
        stateShowsEpisodes = AppState.success;
        notifyListeners();
      },
    );
  }

  /////////////////////////////////////////////////////////////////////////////////

  AppState stateGenerateVideoUrl = AppState.init;
  VideoModel? showVideo;
  String? videoId;

  Future generateVideoUrl() async {
    // Basic implementation for now, add restriction checks if needed
    videoId = null;
    showVideo = null;
    if (showDetailsModel?.showVideos?.isNotEmpty ?? false) {
      videoId = showDetailsModel?.showVideos
          ?.firstWhereOrNull((e) => e.videoTypeId == '1')
          ?.id;
      if (videoId != null) {
        stateGenerateVideoUrl = AppState.loading;
        notifyListeners();
        (await homeService.generateVideoUrl(id: videoId!)).fold(
          (failure) {
            stateGenerateVideoUrl = AppState.error;
            stateGenerateVideoUrl.errorMsg(error: failure.message);
            notifyListeners();
          },
          (data) {
            stateGenerateVideoUrl = AppState.success;
            showVideo = data;
            notifyListeners();
          },
        );
      }
    }
  }

  /////////////////////////////////////////////////////////////////////////////////

  bool isSuggested = false;
  AppState stateIsSuggested = AppState.init;

  Future checkIsSuggested({required String showId}) async {
    stateIsSuggested = AppState.loading;
    notifyListeners();
    (await homeService.checkSuggestionsShow(showId: showId)).fold(
      (failure) {
        stateIsSuggested = AppState.error;
        stateIsSuggested.errorMsg(error: failure.message);
        notifyListeners();
      },
      (data) {
        isSuggested = data;
        stateIsSuggested = AppState.success;
        notifyListeners();
      },
    );
  }
}
