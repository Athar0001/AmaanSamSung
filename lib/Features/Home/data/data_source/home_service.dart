import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:amaan_tv/core/models/content_type.dart';
import 'package:amaan_tv/core/models/response_model.dart';
import 'package:amaan_tv/Features/Home/data/models/home/episodes_show_model/episodes_show_model.dart';
import 'package:amaan_tv/Features/Home/data/models/home/related_model/related_model.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/Features/Home/data/models/home_categories_model/home_categories_model.dart';
import 'package:amaan_tv/Features/Home/data/models/rate_model.dart';
import 'package:amaan_tv/Features/Home/data/models/show_seasons_model/show_seasons_model.dart';
import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/sub_categories_model.dart';
import 'package:amaan_tv/Features/Home/data/models/top_shows_model/top_shows_model.dart';
import 'package:amaan_tv/Features/Home/data/models/top_ten_model/top_ten_model.dart';
import 'package:amaan_tv/Features/Home/data/models/video_transaction_model.dart';

import 'package:amaan_tv/core/utils/cash_services/cashe_helper.dart';
import 'package:amaan_tv/core/utils/constant.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../models/home/banner_model.dart';
import '../../../../core/models/characters_model.dart';
import '../models/home/reals_model.dart';
import '../models/home/shows_model.dart';
import '../../../../core/utils/api/api_service.dart';
import '../../../../core/utils/api/end_point.dart';
import '../models/video_model.dart';

import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';

class HomeService {
  HomeService(this.serverConstants, this.userNotifier);
  ApiService serverConstants;
  final UserNotifier userNotifier;

  Future<Either<Failure, BannerModel>> getBannerService() async {
    try {
      final response = await serverConstants.makeGetRequest(EndPoint.getBanner);
      return Right(BannerModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  //////////////////////////////////////////////////////////////////////////////////

  Future<Either<Failure, ReelsModel>> getAllReelsService() async {
    try {
      final response = await serverConstants.makeGetRequest(
        EndPoint.getAllReels,
      );
      return Right(ReelsModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  //////////////////////////////////////////////////////////////////////////////////

  Future<Either<Failure, ReelsModel>> getLatestReels() async {
    try {
      final response = await serverConstants.makeGetRequest(
        EndPoint.getLatestReels,
      );
      return Right(ReelsModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  //////////////////////////////////////////////////////////////////////////////////

  Future<Either<Failure, CharactersModel>> getCharacters() async {
    try {
      final response = await serverConstants.makeGetRequest(
        EndPoint.getHomeCharacters,
      );
      return Right(CharactersModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  //////////////////////////////////////////////////////////////////////////////////

  Future<Either<Failure, CharactersModel>> getShowDetailsCharacters({
    required String id,
    required int page,
  }) async {
    //
    try {
      final response = await serverConstants.makeGetRequest(
        EndPoint.getShowDetailsCharacters,
        query: {'ShowId': id, 'PageSize': 20, 'PageNumber': page},
      );
      return Right(CharactersModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
    // } else {
    //   return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    // }
  }

  Future<Either<Failure, Map<String, dynamic>>> validateVideoTime({
    required String id,
  }) async {
    //
    try {
      final response = await serverConstants.makeGetRequest(
        EndPoint.validateVideoTime,
        query: {'userId': id},
      );
      CacheHelper.saveData(
        key: Constant.kLogTime,
        value: response.data['data']['remainingTime'],
      );
      return Right(response.data);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
    // } else {
    //   return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    // }
  }

  //////////////////////////////////////////////////////////////////////////////////

  Future<Either<Failure, SubCategoriesModel>> getSubCategories({
    required String id,
    Module module = Module.video,
  }) async {
    try {
      final response = await serverConstants.makeGetRequest(
        '${EndPoint.getSubCategories}/$id',
        query: {'ModuleId': module.id},
      );
      return Right(SubCategoriesModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  //////////////////////////////////////////////////////////////////////////////////

  Future<Either<Failure, ShowSeasonsModel>> getSeasons({
    required String id,
  }) async {
    try {
      final response = await serverConstants.makeGetRequest(
        '${EndPoint.getSeasons}/$id',
      );
      return Right(ShowSeasonsModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  //////////////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, HomeCategoriesModel>> getHomeCategories({
    Module? module = Module.video,
  }) async {
    try {
      final response = await serverConstants.makeGetRequest(
        EndPoint.getCategories,
        query: {'ModuleId': module?.id},
      );
      return Right(HomeCategoriesModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Either<Failure, HomeCategoriesModel>> getHomeModules() async {
    try {
      final response = await serverConstants.makeGetRequest(
        EndPoint.getModules,
      );
      return Right(HomeCategoriesModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  //////////////////////////////////////////////////////////////////////////////////

  Future<Either<Failure, ShowsModel>> getShows({
    String? categoryId,
    String? characterId,
    String? search,
    Module module = Module.video,
    int page = 1,
    int pageSize = 10,
  }) async {
    final response = await serverConstants.makeGetRequest(
      EndPoint.getShows,
      query: {
        'CategoryIds': categoryId,
        'CharacterIds': characterId,
        'ModuleId': module.id,
        'PageNumber': page,
        'PageSize': pageSize,
        'Search': search,
      },
    );
    return Right(ShowsModel.fromJson(response.data));
  }

  //////////////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, TopTenShowsModel>> topTen({
    Module module = Module.video,
  }) async {
    try {
      final response = await serverConstants.makeGetRequest(
        EndPoint.getTop,
        query: {'ModuleId': module.id},
      );
      return Right(TopTenShowsModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  //////////////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, ContinueWatchingModel>> getLatest({
    Module module = Module.video,
  }) async {
    try {
      final response = await serverConstants.makeGetRequest(
        EndPoint.getLatest,
        query: {'ModuleId': module.id},
      );
      return Right(ContinueWatchingModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  //////////////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, ContinueWatchingModel>> getInCompletedShows({
    Module module = Module.video,
  }) async {
    final userId = await UserNotifier.instance.userData?.userId;
    //
    try {
      final response = await serverConstants.makeGetRequest(
        EndPoint.getInCompletedShows,
        query: {'userId': userId, 'ModuleId': module.id},
      );
      return Right(ContinueWatchingModel.fromJson(response.data));
    } catch (error, st) {
      log(st.toString());
      return Left(ErrorHandler.handle(error, st).failure);
    }
    // } else {
    //   return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    // }
  }

  //////////////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, Details>> getShowDetials({
    required String id,
    ContentType contentType = ContentType.show,
  }) async {
    //
    try {
      final response = await serverConstants.makeGetRequest(
        '${EndPoint.getShowDetails}/$id',
      );
      final details = Details.fromJson(
        response.data['data'],
        contentType: contentType,
      );
      return Right(details);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
    // } else {
    //   return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    // }
  }

  //////////////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, Details>> getEpisodeDetails({
    required String id,
  }) async {
    //
    try {
      final response = await serverConstants.makeGetRequest(
        '${EndPoint.getEpisodeDetails}/$id',
      );
      return Right(
        Details.fromJson(
          response.data['data'],
          contentType: ContentType.episode,
        ),
      );
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
    // } else {
    //   return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    // }
  }

  //////////////////////////////////////////////////////////////////////////////////

  Future<Either<Failure, RelatedModel>> getRelatedShows({
    required String id,
  }) async {
    //
    try {
      final response = await serverConstants.makeGetRequest(
        '${EndPoint.getRelated}?id=$id',
      );
      return Right(RelatedModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
    // } else {
    //   return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    // }
  }

  //////////////////////////////////////////////////////////////////////////////////

  Future<Either<Failure, EpisodesShowModel>> getEpisodeShows({
    required String id,
    int? pageNumber,
    int? pageSize,
  }) async {
    try {
      final response = await serverConstants.makeGetRequest(
        '${EndPoint.getShowEpisodes}?ShowId=$id',
        query: {
          'PageNumber': pageNumber,
          'PageSize': pageSize ?? 10,
          'sortOrder': 'asc',
        },
      );
      return Right(EpisodesShowModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  //////////////////////////////////////////////////////////////////////////////////

  Future<Either<Failure, VideoModel>> generateVideoUrl({
    required String id,
  }) async {
    try {
      final response = await serverConstants.makePostRequest(
        EndPoint.getShowsVideo,
        postValues: {'showVideoId': id},
      );
      return Right(VideoModel.fromJson(response.data['data']));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  //////////////////////////////////////////////////////////////////////////////////

  Future<Either<Failure, VideoModel>> generateEpisodeVideoUrl({
    required String id,
  }) async {
    //
    try {
      final response = await serverConstants.makePostRequest(
        EndPoint.getEpisodesVideo,
        postValues: {'episodeVideoId': id},
      );
      return Right(VideoModel.fromJson(response.data['data']));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
    // } else {
    //   return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    // }
  }

  //////////////////////////////////////////////////////////////////////////////////

  Future<Either<Failure, bool>> videoTransaction({
    required VideoTransactionModel model,
  }) async {
    //
    try {
      await serverConstants.makePostRequest(
        EndPoint.sendVideoTransaction,
        postValues: model.toJson(),
      );
      return Right(true);
    } catch (error, st) {
      return Left(ErrorHandler.handle(error, st).failure);
    }
    // } else {
    //   return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    // }
  }

  Future<Either<Failure, Map<String, dynamic>>> videoLog({
    required String userId,
    required String time,
  }) async {
    //
    try {
      final response = await serverConstants.makePostRequest(
        EndPoint.setTimeLog,
        isMultipart: true,
        postValues: FormData.fromMap({'UserId': userId, 'UsedTime': time}),
      );
      return Right(response.data['data']);
    } catch (error, st) {
      return Left(ErrorHandler.handle(error, st).failure);
    }
    // } else {
    //   return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    // }
  }

  Future<Either<Failure, bool>> continueWatching({required int time}) async {
    //
    try {
      await serverConstants.makePostRequest(
        EndPoint.continueWatching,
        postValues: {'duration': time},
      );
      return Right(true);
    } catch (error, st) {
      return Left(ErrorHandler.handle(error, st).failure);
    }
    // } else {
    //   return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    // }
  }

  //////////////////////////////////////////////////////////////////////////////////

  Future<Either<Failure, RateModel?>> getReview({required String id}) async {
    //
    try {
      final response = await serverConstants.makeGetRequest(
        '${EndPoint.review}?ShowId=$id&UserId=${CacheHelper.currentUser!.userId}',
      );
      final responseModel = ResponseModel.fromJson(
        response.data,
        RateModel.fromJson,
      );
      return Right(responseModel.data.firstOrNull);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
    // } else {
    //   return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    // }
  }

  //////////////////////////////////////////////////////////////////////////////////

  Future<Either<Failure, RateModel>> addReview(RateModel rateModel) async {
    try {
      final response = await serverConstants.makePostRequest(
        EndPoint.review,
        postValues: rateModel.toJson(),
      );
      return Right(RateModel.fromJson(response.data['data']));
    } catch (error, st) {
      return Left(ErrorHandler.handle(error, st).failure);
    }
  }

  //////////////////////////////////////////////////////////////////////////////////

  Future<Either<Failure, RateModel>> updateReview(RateModel rateModel) async {
    try {
      final response = await serverConstants.makePutRequest(
        '${EndPoint.review}/${rateModel.id}',
        postValues: rateModel.toJson(),
      );
      return Right(RateModel.fromJson(response.data['data']));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  Future<Either<Failure, bool>> checkSuggestionsShow({
    required String showId,
  }) async {
    try {
      final response = await serverConstants.makeGetRequest(
        '${EndPoint.isRecomendedByParent}/$showId',
      );
      return Right(response.data['data']);
    } catch (error, st) {
      return Left(ErrorHandler.handle(error, st).failure);
    }
  }

  //////////////////////////////////////////////////////////////////////////////////

  Future<Either<Failure, ContinueWatchingModel>> getSuggestedData({
    Module module = Module.video,
  }) async {
    try {
      final response = await serverConstants.makeGetRequest(
        EndPoint.suggestedSearch,
        query: {'userId': userNotifier.userData!.userId, 'moduleId': module.id},
      );
      return Right(ContinueWatchingModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
