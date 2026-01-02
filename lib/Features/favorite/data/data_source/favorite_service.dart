import 'dart:developer';

import 'package:amaan_tv/Features/favorite/data/models/favorite_shows_model.dart';
import 'package:amaan_tv/core/error/error_handler.dart';
import 'package:amaan_tv/core/error/failure.dart';
import 'package:amaan_tv/core/models/characters_model.dart';
import 'package:amaan_tv/core/models/content_type.dart';
import 'package:amaan_tv/core/models/favorite_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/utils/api/api_service.dart';
import '../../../../core/utils/api/end_point.dart';
import '../models/favorite_episodes_model.dart';

class FavoritesService {
  FavoritesService(this._api);
  ApiService _api;

  Future<Either<Failure, bool>> addFavoriteShow({required String? id}) async {
    try {
      await _api.makePostRequest(
        EndPoint.userFavoriteShows,
        postValues: {'showId': '$id'},
      );
      return Right(true);
    } catch (error, st) {
      return Left(ErrorHandler.handle(error, st).failure);
    }
  }

  Future<Either<Failure, Unit>> addFavoriteEpisode({
    required String? id,
  }) async {
    try {
      final response = await _api.makePostRequest(EndPoint.userFavoriteEpisodes,
          postValues: {'EpisodeId': id});
      //     for remove                    // for add
      assert(response.statusCode == 200 || response.statusCode == 201);
      return Right(unit);
    } catch (error, st) {
      log(error.toString(), stackTrace: st, name: 'addFavoriteEpisode');
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Either<Failure, Unit>> updateFavorite({
    required FavoriteModel model,
  }) async {
    try {
      final response = await _api.makePostRequest(
        model.contentType.url,
        postValues: model.contentType.postValues(model.id),
      );
      //     for remove                    // for add
      assert(response.statusCode == 200 || response.statusCode == 201);
      return Right(unit);
    } catch (error, st) {
      return Left(ErrorHandler.handle(error, st).failure);
    }
  }

  Future<Either<Failure, FavoriteEpisodesModel>> getFavoriteEpisodes(
      {String? childId}) async {
    try {
      final urlSuffix = "/${childId != null ? childId : ""}";
      final response =
          await _api.makeGetRequest(EndPoint.userFavoriteEpisodes + urlSuffix);
      return Right(FavoriteEpisodesModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Either<Failure, FavoriteShowsModel>> getFavoriteShows(
      {String? childId, int? moduleId}) async {
    //
    try {
      final urlSuffix = (childId != null ? '/$childId' : '');
      final response = await _api.makeGetRequest(
        EndPoint.userFavoriteShows + urlSuffix,
        query: {'ModuleId': moduleId},
      );
      return Right(FavoriteShowsModel.fromJson(response.data));
    } catch (error, st) {
      return Left(ErrorHandler.handle(error, st).failure);
    }
    // } else {
    //   return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    // }
  }

  Future<Either<Failure, CharactersModel>> getFavoritesCharacters(
      {String? childId}) async {
    try {
      final urlSuffix = "/${childId != null ? childId : ""}";
      final response = await _api
          .makeGetRequest(EndPoint.userFavoriteCharacters + urlSuffix);
      return Right(CharactersModel.fromJson(response.data));
    } catch (error, st) {
      return Left(ErrorHandler.handle(error, st).failure);
    }
  }
}

extension ContentTypeUtils on ContentType {
  String get url {
    switch (this) {
      case ContentType.episode:
        return EndPoint.userFavoriteEpisodes;
      case ContentType.show || ContentType.audio:
        return EndPoint.userFavoriteShows;
      case ContentType.character:
        return EndPoint.userFavoriteCharacters;
    }
  }

  Map<String, dynamic> postValues(String id) {
    switch (this) {
      case ContentType.episode:
        return {'EpisodeId': id};
      case ContentType.show || ContentType.audio:
        return {'showId': id};
      case ContentType.character:
        return {'characterId': id};
    }
  }
}
