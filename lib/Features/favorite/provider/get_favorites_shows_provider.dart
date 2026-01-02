import 'package:flutter/material.dart';
import '../../../core/utils/enum.dart';
import '../../Home/data/models/home/show_details_model/data.dart';
import '../data/data_source/favorite_service.dart';
import '../../../core/widget/app_toast.dart';
import '../data/models/favorite_shows_model.dart';

enum GetFavoriteShowsState { init, loading, success, error }

class GetFavoritesShowsProvider extends ChangeNotifier {
  GetFavoritesShowsProvider(this.favoriteEpisodesService);
  final FavoritesService favoriteEpisodesService;

  GetFavoriteShowsState state = GetFavoriteShowsState.init;
  AppState childFavoriteState = AppState.init;
  FavoriteShowsModel? favoriteShowsModel;

  void removeShow(
      {FavoriteShow? e, Details? details, bool removeFromServer = false}) {
    assert(e != null || details != null);

    if (e != null) {
      _removeShow(e, removeFromServer: removeFromServer);
    } else if (details != null) {
      _removeShowDetails(details, removeFromServer: removeFromServer);
    }
  }

  void _removeShowDetails(Details? details, {bool removeFromServer = false}) {
    final e = favoriteShowsModel?.favoriteShows
        ?.firstWhere((element) => element.showId == details?.id);
    if (e == null) return;
    favoriteShowsModel?.favoriteShows?.remove(e);
    notifyListeners();
    if (removeFromServer) {
      favoriteEpisodesService.addFavoriteShow(id: e.showId!);
    }
  }

  void _removeShow(FavoriteShow e, {bool removeFromServer = false}) {
    favoriteShowsModel?.favoriteShows?.remove(e);
    notifyListeners();
    if (removeFromServer) {
      favoriteEpisodesService.addFavoriteShow(id: e.showId!);
    }
  }

  Future<void> getFavoritesShows({String? childId, int? moduleId}) async {
    childFavoriteState = AppState.loading;
    notifyListeners();
    (await favoriteEpisodesService.getFavoriteShows(
            childId: childId, moduleId: moduleId))
        .fold((failure) {
      childFavoriteState = AppState.error;

      childFavoriteState.errorMsg(error: failure.message);
      AppToast.show(failure.message);
    }, (data) {
      favoriteShowsModel = data;
      childFavoriteState = AppState.success;
      notifyListeners();
    });
  }
}
