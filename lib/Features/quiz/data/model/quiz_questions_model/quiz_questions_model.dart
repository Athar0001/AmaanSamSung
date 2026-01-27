import 'child_exam_question.dart';
import 'exam.dart';

class QuizQuestionsModel {
  QuizQuestionsModel({
    this.id,
    this.userId,
    this.examId,
    this.fristTake = true,
    this.totalScore,
    this.examStarted,
    this.isCompleted,
    this.exam,
    this.childExamQuestions,
  });

  factory QuizQuestionsModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionsModel(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      examId: json['examId'] as String?,
      fristTake: json['fristTake'] as bool? ?? true,
      totalScore: json['totalScore'] as int?,
      examStarted: json['examStarted'] as bool?,
      isCompleted: json['isCompleted'] as bool?,
      exam: json['exam'] == null
          ? null
          : Exam.fromJson(json['exam'] as Map<String, dynamic>),
      childExamQuestions: (json['childExamQuestions'] as List<dynamic>?)
          ?.map((e) => ChildExamQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  String? id;
  String? userId;
  String? examId;
  bool fristTake;
  int? totalScore;
  bool? examStarted;
  bool? isCompleted;
  Exam? exam;
  List<ChildExamQuestion>? childExamQuestions;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'examId': examId,
        'fristTake': fristTake,
        'totalScore': totalScore,
        'examStarted': examStarted,
        'isCompleted': isCompleted,
        'exam': exam?.toJson(),
        'childExamQuestions':
            childExamQuestions?.map((e) => e.toJson()).toList(),
      };
}
