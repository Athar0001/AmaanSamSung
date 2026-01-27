import 'package:amaan_tv/core/utils/app_localiztion.dart';

import 'exam.dart';

enum ChildExamStatus {
  notCompleted(id: 1),
  notStarted(id: 2),
  completed(id: 3),
  ;

  final int id;

  String get button {
    switch (this) {
      case ChildExamStatus.notCompleted:
        return AppLocalization.strings.continueLabel;
      case ChildExamStatus.notStarted:
        return AppLocalization.strings.start;
      case ChildExamStatus.completed:
        return AppLocalization.strings.tryAgain;
    }
  }

  String get title {
    switch (this) {
      case ChildExamStatus.notCompleted:
        return AppLocalization.strings.thePostponedQuizzes;
      case ChildExamStatus.notStarted:
        return AppLocalization.strings.currentQuizzes;
      case ChildExamStatus.completed:
        return AppLocalization.strings.completedQuizzes;
    }
  }

  String get description {
    switch (this) {
      case ChildExamStatus.notCompleted:
        return AppLocalization.strings.notCompletedQuizzes;
      case ChildExamStatus.notStarted:
        return AppLocalization.strings.postponedQuizzesForLater;
      case ChildExamStatus.completed:
        return AppLocalization.strings.completedQuizzesDescription;
    }
  }

  bool get isCompleted => this == ChildExamStatus.completed;

  bool get isNotStarted => this == ChildExamStatus.notStarted;

  bool get isNotCompleted => this == ChildExamStatus.notCompleted;

  const ChildExamStatus({required this.id});
}

class ChildExamModel {
  ChildExamModel({
    this.id,
    this.userId,
    this.examId,
    this.fristTake = false,
    this.status = ChildExamStatus.notStarted,
    this.totalAnswers = 0,
    this.totalRetakes = 0,
    this.totalScore = 1,
    this.examScore = 0,
    this.createdOn,
    this.exam,
  });

  factory ChildExamModel.fromJson(Map<String, dynamic> json) {
    final id = json['childExamStatus'] as int? ?? 1;
    final childExamStatus = ChildExamStatus.values.firstWhere(
      (status) => status.id == id,
      orElse: () => ChildExamStatus.notStarted,
    );
    return ChildExamModel(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      examId: json['examId'] as String?,
      fristTake: json['fristTake'] as bool? ?? false,
      status: childExamStatus,
      totalAnswers: json['totalAnswers'] as int? ?? 0,
      totalRetakes: json['totalRetakes'] as int? ?? 0,
      totalScore: json['totalScore'] as int? ?? 0,
      examScore: json['examScore'] as int? ?? 0,
      createdOn: json['createdOn'] as String?,
      exam: json['exam'] == null
          ? null
          : Exam.fromJson(json['exam'] as Map<String, dynamic>),
    );
  }
  String? id;
  String? userId;
  String? examId;
  bool fristTake;
  ChildExamStatus status;
  int totalAnswers;
  int totalRetakes;
  int examScore;
  int totalScore;
  String? createdOn;
  Exam? exam;

  int get getPriority => status.id;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'examId': examId,
        'fristTake': fristTake,
        'childExamStatus': status.id,
        'exam': exam?.toJson(),
      };
}
