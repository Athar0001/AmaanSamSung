import 'package:dartz/dartz.dart';
import 'package:amaan_tv/core/error/error_handler.dart';
import 'package:amaan_tv/core/error/failure.dart';
import 'package:amaan_tv/Features/quiz/data/model/answer_question_model.dart';
import 'package:amaan_tv/Features/quiz/data/model/child_exam_model/child_exam_model.dart';
import 'package:amaan_tv/Features/quiz/data/model/child_exam_model/quizzes_model.dart';
import 'package:amaan_tv/Features/quiz/data/model/exam_score_model.dart';
import 'package:amaan_tv/Features/quiz/data/model/quiz_questions_model/quiz_questions_model.dart';
import 'package:amaan_tv/Features/quiz/data/model/top_ten_model.dart';
import 'package:amaan_tv/core/utils/api/api_service.dart';
import 'package:amaan_tv/core/utils/api/end_point.dart';

class QuizService {
  QuizService(this.serverConstants);
  ApiService serverConstants;

  Future<Either<Failure, QuizQuestionsModel>> getQuizQuestions(
      {required String examId}) async {
    try {
      final response = await serverConstants.makeGetRequest(
        '${EndPoint.getQuizExam}/$examId',
      );
      return Right(QuizQuestionsModel.fromJson(response.data['data']));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  /////////////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, ChildExamModel>> addChildExam({
    required String showId,
    String? episodeId,
  }) async {
    try {
      final response = await serverConstants.makePostRequest(
        EndPoint.childExam,
        postValues: {
          if (episodeId != null) 'episodeId': episodeId else 'showId': showId,
        },
      );
      return Right(ChildExamModel.fromJson(response.data['data']));
    } catch (error, st) {
      return Left(ErrorHandler.handle(error, st).failure);
    }
  }

  /////////////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, Unit>> answerQuestion(
    AnswerQuestionModel answer,
  ) async {
    try {
      await serverConstants.makePostRequest(
        EndPoint.answerQuestion,
        postValues: answer.toJson(),
      );
      return Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  /////////////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, ExamScoreModel>> getExamScore(String examId) async {
    try {
      final response = await serverConstants
          .makeGetRequest('${EndPoint.getExamScore}/$examId');
      return Right(ExamScoreModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  /////////////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, TopTenModel>> getTopTen(String? examId) async {
    try {
      final response =
          await serverConstants.makeGetRequest(EndPoint.getTopTen(examId));
      return Right(TopTenModel.fromJson(response.data));
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  /////////////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, ChildExamModel>> retakeExam(String examId) async {
    try {
      final response = await serverConstants
          .makePostRequest('${EndPoint.retakeExam}/$examId');
      return Right(ChildExamModel.fromJson(response.data['data']));
    } catch (error, st) {
      return Left(ErrorHandler.handle(error, st).failure);
    }
  }

  /////////////////////////////////////////////////////////////////////////////////
  Future<Either<Failure, QuizzesModel>> postponedQuizzes({
    int? pageNumber,
    int? pageSize,
  }) async {
    try {
      final response = await serverConstants.makeGetRequest(
        EndPoint.childExam,
        query: pageNumber != null
            ? {'PageNumber': pageNumber, 'PageSize': pageSize ?? 10}
            : null,
      );
      final responseModel = QuizzesModel.fromJson(response.data);
      return Right(responseModel);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
