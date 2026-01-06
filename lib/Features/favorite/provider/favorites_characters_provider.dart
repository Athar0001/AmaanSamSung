import 'package:amaan_tv/core/models/characters_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/enum.dart';

import '../data/data_source/favorite_service.dart';

import '../../../core/widget/app_toast.dart';

enum GetFavoritesCharactersState { init, loading, success, error }

class FavoritesCharactersProvider extends ChangeNotifier {
  FavoritesCharactersProvider(this._favoriteService);
  final FavoritesService _favoriteService;

  GetFavoritesCharactersState state = GetFavoritesCharactersState.init;
  AppState favoriteState = AppState.init;
  CharactersModel? charactersModel;

  Future<void> removeCharacter(CharacterData character) async {
    final index = charactersModel!.data.indexOf(character);
    charactersModel?.data.removeAt(index);
    character.isFavorite.value = false;
    notifyListeners();
    final result = await _favoriteService.updateFavorite(model: character);
    result.fold((l) {
      charactersModel?.data.insert(index, character);
      character.isFavorite.value = true;
    }, (r) => unit);
  }

  Future<void> getFavoritesCharacters({String? childId}) async {
    favoriteState = AppState.loading;
    notifyListeners();
    (await _favoriteService.getFavoritesCharacters(childId: childId)).fold(
        (failure) {
      favoriteState = AppState.error;

      favoriteState.errorMsg(error: failure.message);
      AppToast.show(failure.message);
    }, (data) {
      charactersModel = data;
      favoriteState = AppState.success;
      notifyListeners();
    });
  }
}
