import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_state_provider/flutter_state_provider.dart';
import 'package:amaan_tv/Features/Home/data/models/home/episodes_show_model/episodes_show_model.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/Features/Home/functions.dart';
import '../../../core/utils/enum.dart';
import '../data/data_source/home_service.dart';
import '../../../core/widget/app_toast.dart';
import '../data/models/video_model.dart';

class EpisodeProvider extends ChangeNotifier {

  EpisodeProvider(this.homeService);
  HomeService homeService;

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

////////////////////////////////////////////////////////////////////////////////////////////////////
  Details? episodeDetails;
  StateProvider stateEpisodeDetails = const StateProvider.loading();

  Future getEpisodeDetails({required String id}) async {
    stateEpisodeDetails = const StateProvider.loading();
    notifyListeners();
    (await homeService.getEpisodeDetails(id: id)).fold((failure) {
      stateEpisodeDetails = StateProvider.error(failure.message);
      AppToast.show(failure.message);
      notifyListeners();
    }, (data) {
      episodeDetails = data;
      stateEpisodeDetails = const StateProvider.success();
      getShowsEpisodesProvide(id: data.showId!);
      // generateEpisodeVideoUrl();
      notifyListeners();
    });
  }

/////////////////////////////////////////////////////////////////////////////////

  int pageNumber = 1;

  bool get hasNextPage => showsEpisodesModel?.pagination?.hasNextPage != false;

  EpisodesShowModel? get quizzesModel => stateShowsEpisodes
      .whenSuccess<EpisodesShowModel>(([success]) => success!);

  EpisodesShowModel? get showsEpisodesModel => _showsEpisodesModel;

  EpisodesShowModel? _showsEpisodesModel;

  StateProvider stateShowsEpisodes = const StateProvider.loading();

  Future getShowsEpisodesProvide({
    required String id,
  }) async {
    (await homeService.getEpisodeShows(id: id, pageNumber: pageNumber)).fold(
        (failure) {
      stateShowsEpisodes = StateProvider.error(failure.message);
      AppToast.show(failure.message);
      notifyListeners();
    }, (data) {
      data.data =
          List<Details>.from([...?_showsEpisodesModel?.data, ...?data.data]);
      _showsEpisodesModel = data;
      stateShowsEpisodes = StateProvider.success(data);

      notifyListeners();
    });
  }

  void loadPageForIndex(int index, String id) {
    // Check if the index is within available range
    log('$index', name: 'index');
    log('${_showsEpisodesModel?.data!.length}', name: '_showsEpisodesModel');
    final indexAvailableRange =
        index > (_showsEpisodesModel?.data!.length ?? 0);
    log('$indexAvailableRange', name: 'indexAvailableRange');

    if (indexAvailableRange) return;

    final newPageNumber = ((index + 1) / 10).ceil();

    // Check if the new page number is within available range
    final pageAvailableRange =
        newPageNumber > (_showsEpisodesModel?.pagination?.totalPages ?? 0);
    log('$newPageNumber', name: 'newPageNumber');

    if (pageAvailableRange) return;

    // Check if the page for this index is loading or already loaded
    if (newPageNumber <= pageNumber) return;
    pageNumber += 1;
    getShowsEpisodesProvide(
      id: id,
    );
  }

/////////////////////////////////////////////////////////////////////////////////

  AppState stateGenerateVideoUrl = AppState.init;
  VideoModel? showVideo;
  String? videoId;

  Future generateEpisodeVideoUrl(String id, BuildContext context) async {
    if (checkIfVideoAllowed(
          isFree: episodeDetails?.isFree,
          isGuest: episodeDetails?.isGuest,
        ) ==
        null) {
      videoId = null;
      showVideo = null;
      // if (episodeDetails?.data?.episodeVideos?.isNotEmpty ?? false) {
      // videoId = episodeDetails?.data?.episodeVideos
      //     ?.firstWhereOrNull((e) => e.videoTypeId == '1')
      //     ?.id;
      // log(videoId.toString());

      stateGenerateVideoUrl = AppState.loading;
      notifyListeners();
      (await homeService.generateEpisodeVideoUrl(id: id)).fold((failure) {
        stateGenerateVideoUrl = AppState.error;
        stateGenerateVideoUrl.errorMsg(error: failure.message);
        AppToast.show(failure.message);
        notifyListeners();
      }, (data) {
        print(data);
        stateGenerateVideoUrl = AppState.success;
        showVideo = data;
        // AppNavigation.navigationPush(context,
        //     screen:  ShowPlayerScreen(
        //       url: model.presignedUrl!,
        //       show: model,
        //       videoId: model.episodeId!,
        //     ););

        notifyListeners();
      });

      // }
    }
  }

/////////////////////////////////////////////////////////////////////////////////
}
