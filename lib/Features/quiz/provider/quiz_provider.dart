import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:amaan_tv/Features/quiz/data/data_source/quiz_service.dart';
import 'package:amaan_tv/Features/quiz/data/model/answer_question_model.dart';
import 'package:amaan_tv/Features/quiz/data/model/child_exam_model/child_exam_model.dart';
import 'package:amaan_tv/Features/quiz/data/model/child_exam_model/quizzes_model.dart';
import 'package:amaan_tv/Features/quiz/data/model/exam_score_model.dart';
import 'package:amaan_tv/Features/quiz/data/model/quiz_questions_model/quiz_questions_model.dart';
import 'package:amaan_tv/Features/quiz/data/model/top_ten_model.dart';
import 'package:amaan_tv/core/utils/enum.dart';

class QuizProvider extends ChangeNotifier {
  QuizProvider(this.quizService);
  QuizService quizService;

  /////////////////////////////////////////////////////////////////////////////////

  Future<ChildExamModel?> addChildExams({
    required String showId,
    String? episodeId,
  }) async {
    final result =
        await quizService.addChildExam(showId: showId, episodeId: episodeId);

    return result.fold((failure) {
      return null;
    }, (childExamModel) {
      return childExamModel;
    });
  }

/////////////////////////////////////////////////////////////////////////////////

  QuizQuestionsModel? _quizQuestionsModel;

  QuizQuestionsModel? get quizQuestionsModel => _quizQuestionsModel;
  AppState stateGetQuizQuestions = AppState.loading;

  Future getQuizQuestions({required String examId}) async {
    stateGetQuizQuestions = AppState.loading;
    notifyListeners();
    (await quizService.getQuizQuestions(examId: examId)).fold((failure) {
      stateGetQuizQuestions = AppState.error;
      notifyListeners();
    }, (data) {
      _quizQuestionsModel = data;
      stateGetQuizQuestions = AppState.success;
      notifyListeners();
    });
  }

/////////////////////////////////////////////////////////////////////////////////

  AppState examScoreState = AppState.loading;
  ExamScoreModel? _examScoreModel;
  ExamScoreModel? get examScoreModel => _examScoreModel;

  Future getExamScore({required String examId}) async {
    examScoreState = AppState.loading;
    notifyListeners();
    (await quizService.getExamScore(examId)).fold((failure) {
      examScoreState = AppState.error;
      notifyListeners();
    }, (data) {
      _examScoreModel = data;
      examScoreState = AppState.success;
      notifyListeners();
    });
  }

/////////////////////////////////////////////////////////////////////////////////

  AppState topTenState = AppState.loading;
  TopTenModel? _topTenModel;
  TopTenModel? get topTenModel => _topTenModel;

  Future getTopTen({required String? examId}) async {
    topTenState = AppState.loading;
    notifyListeners();
    (await quizService.getTopTen(examId)).fold((failure) {
      topTenState = AppState.error;
      notifyListeners();
    }, (data) {
      _topTenModel = data;
      topTenState = AppState.success;
      notifyListeners();
    });
  }

/////////////////////////////////////////////////////////////////////////////////
  AppState answerQuestionState = AppState.loading;

  Future<bool> answerQuestion(AnswerQuestionModel answer) async {
    var isSuccess = false;
    answerQuestionState = AppState.loading;
    notifyListeners();

    final result = await quizService.answerQuestion(answer);

    result.fold((failure) {
      answerQuestionState = AppState.error;
      notifyListeners();
    }, (data) {
      isSuccess = true;
      answerQuestionState = AppState.success;
      notifyListeners();
    });
    return isSuccess;
  }

/////////////////////////////////////////////////////////////////////////////////
  int get pageSize => 10;

  int pageNumber = 1;

  bool get hasNextPage => quizzesModel?.pagination?.hasNextPage != false;

  QuizzesModel? quizzesModel;

  AppState postponedQuizzesState = AppState.loading;

  Future<bool> postponedQuizzes({bool refresh = false}) async {
    var isSuccess = false;
    if (pageNumber == 0 || refresh) {
      pageNumber = 1;
      postponedQuizzesState = AppState.loading;
      notifyListeners();
    }

    final result = await quizService.postponedQuizzes(
      pageNumber: pageNumber,
      pageSize: pageSize,
    );

    result.fold((failure) {
      postponedQuizzesState = AppState.error;
      notifyListeners();
    }, (data) {
      isSuccess = true;
      data.data?.unstartedExams = List<ChildExamModel>.from([
        ...?quizzesModel?.data?.unstartedExams,
        ...?data.data?.unstartedExams,
      ]);
      data.data?.unfinishedExams = List<ChildExamModel>.from([
        ...?quizzesModel?.data?.unfinishedExams,
        ...?data.data?.unfinishedExams,
      ]);
      data.data?.completedExams = List<ChildExamModel>.from([
        ...?quizzesModel?.data?.completedExams,
        ...?data.data?.completedExams,
      ]);
      quizzesModel = data;
      postponedQuizzesState = AppState.success;
      notifyListeners();
    });
    return isSuccess;
  }

  void loadPageForIndex(int index) {
    final indexAvailableRange = index > (quizzesModel?.length ?? 0);
    log('$indexAvailableRange', name: 'indexAvailableRange');
    if (indexAvailableRange) return;

    final newPageNumber = ((index + 1) / pageSize).ceil();

    final pageAvailableRange =
        newPageNumber > (quizzesModel?.pagination?.totalPages ?? 0);
    log('$newPageNumber', name: 'newPageNumber');
    if (pageAvailableRange) return;

    if (newPageNumber <= pageNumber) return;
    pageNumber += 1;
    postponedQuizzes();
  }

  ///////////////////////////////////////////////////////////////////////
  AppState stateRetake = AppState.init;

  Future<ChildExamModel?> retakeExam({required String examId}) async {
    stateRetake = AppState.loading;
    notifyListeners();
    return (await quizService.retakeExam(examId)).fold((failure) {
      stateRetake = AppState.error;
      notifyListeners();
      return null;
    }, (data) {
      if (quizzesModel?.data?.unstartedExams != null) {
        quizzesModel!.data!.unstartedExams!.insert(0, data);
        stateRetake = AppState.success;
        notifyListeners();
      }
      return data;
    });
  }
}
