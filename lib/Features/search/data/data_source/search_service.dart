import 'package:dartz/dartz.dart';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/core/error/failure.dart';
import 'package:amaan_tv/Features/search/data/model/recent_search_model/recent_search_model.dart';
import 'package:amaan_tv/core/error/error_handler.dart';
import 'package:amaan_tv/core/utils/api/api_service.dart';
import 'package:amaan_tv/core/utils/api/end_point.dart';
import '../model/search_model.dart';

class SearchService {
  SearchService(this.serverConstant, this.userNotifier);
  ApiService serverConstant;
  final UserNotifier userNotifier;

  Future<Either<Failure, SearchModel>> searchData({
    required String? searchText,
  }) async {
    try {
      final response = await serverConstant.makeGetRequest(
        EndPoint.search,
        query: {'Search': searchText, 'ModuleId': 1},
      );
      return Right(SearchModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  /////////////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, RecentSearchModel>> recentSearch() async {
    try {
      final response = await serverConstant.makeGetRequest(
        EndPoint.recentSearch,
      );
      return Right(RecentSearchModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  /////////////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, bool>> deleteRecentSearch() async {
    try {
      await serverConstant.makeDeleteRequest(EndPoint.deleteRecentSearch);
      return Right(true);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  /////////////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, SearchModel>> getSuggestedData() async {
    try {
      final response = await serverConstant.makeGetRequest(
        EndPoint
            .suggestedSearch, // Note: mobile used query: {'userId': userNotifier.userData!.userId} but TV might be different. Retaining logic.
        query: {
          'userId': userNotifier.userData?.id,
        }, // userData.id is int in TV UserData?
      );
      return Right(SearchModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  /////////////////////////////////////////////////////////////////////////////////
}
