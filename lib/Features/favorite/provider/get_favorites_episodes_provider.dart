import 'package:amaan_tv/Features/favorite/data/models/favorite_episodes_model.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/enum.dart';
import '../data/data_source/favorite_service.dart';
import '../../../core/widget/app_toast.dart';

enum GetFavoriteEpisodeState { init, loading, success, error }

class GetFavoritesEpisodesProvider extends ChangeNotifier {
  GetFavoritesEpisodesProvider(this._favoriteEpisodesService);
  final FavoritesService _favoriteEpisodesService;

  GetFavoriteEpisodeState state = GetFavoriteEpisodeState.init;
  AppState childFavoriteState = AppState.init;
  FavoriteEpisodesModel? childFavoriteModel;

  void removeEpisode(FavoriteEpisode e) {
    childFavoriteModel?.favoriteShow?.remove(e);
    notifyListeners();

    _favoriteEpisodesService.addFavoriteEpisode(id: e.episodeId!);
  }

  Future<void> getFavoritesEpisodes({String? childId}) async {
    childFavoriteState = AppState.loading;
    notifyListeners();
    (await _favoriteEpisodesService.getFavoriteEpisodes(childId: childId)).fold(
        (failure) {
      childFavoriteState = AppState.error;

      childFavoriteState.errorMsg(error: failure.message);
      AppToast.show(failure.message);
    }, (data) {
      childFavoriteModel = data;
      childFavoriteState = AppState.success;
      notifyListeners();
    });
  }
}
