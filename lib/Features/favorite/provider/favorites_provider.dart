import 'package:amaan_tv/Features/favorite/data/data_source/favorite_service.dart';
import 'package:amaan_tv/core/models/favorite_model.dart';
import 'package:amaan_tv/core/widget/app_toast.dart';
import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  FavoritesProvider(this._service);
  final FavoritesService _service;

  Future<bool> updateFavorite({required FavoriteModel model}) async {
    notifyListeners();
    final result = await _service.updateFavorite(model: model);
    result.fold((failure) {
      AppToast.show(failure.message);
    }, (data) {
      notifyListeners();
    });
    return result.isRight();
  }
}
