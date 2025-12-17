import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:amaan_tv/core/error/error_handler.dart';
import 'package:amaan_tv/core/error/failure.dart';
import 'package:amaan_tv/Features/Home/data/models/reels/comment_parm_model.dart';
import 'package:amaan_tv/Features/Home/data/models/reels/comments_reels_model/comments_reels_model.dart';
import 'package:amaan_tv/core/utils/api/api_service.dart';
import 'package:amaan_tv/core/utils/api/end_point.dart';

class ReelsService {

  ReelsService(
    this.serverConstants,
  );
  ApiService serverConstants;

  Future<Either<Failure, List<CommentsReelsModel>>> getCommentsReels(
      {required String reelId}) async {
    try {
      final response = await serverConstants.makeGetRequest(
        '${EndPoint.getCommentReel}/$reelId',
      );
      return Right(List<CommentsReelsModel>.from(
          response.data['data'].map((x) => CommentsReelsModel.fromJson(x))));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

//////////////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, CommentsReelsModel>> makeCommentReels(
      {required CommentParmModel model}) async {
    try {
      final response = await serverConstants.makePostRequest(
        EndPoint.makeReelComments,
        isMultipart: true,
        postValues: model.toJson(),
      );
      return Right(CommentsReelsModel.fromJson(response.data['data']));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

//////////////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, bool>> likeReel({required String reelId}) async {
    try {
      await serverConstants.makePostRequest(EndPoint.likeReel,
          postValues: FormData.fromMap({
            'ReelId': reelId,
          }));
      return Right(true);
    } catch (error, st) {
      return Left(ErrorHandler.handle(error, st).failure);
    }
  }

  //////////////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, bool>> likeReelComment(
      {required String commentId}) async {
    try {
      await serverConstants.makePostRequest(EndPoint.likeReelComment,
          isMultipart: true,
          postValues: FormData.fromMap({
            'CommentId': commentId,
          }));
      return Right(true);
    } catch (error, st) {
      return Left(ErrorHandler.handle(error, st).failure);
    }
  }
}
