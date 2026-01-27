import 'question.dart';

class ChildExamQuestion {
  ChildExamQuestion({
    this.id,
    this.userId,
    this.childExamId,
    this.questionId,
    this.score,
    this.isAnswered = false,
    this.question,
    this.childExamQuestionAnswers,
  });

  factory ChildExamQuestion.fromJson(Map<String, dynamic> json) {
    return ChildExamQuestion(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      childExamId: json['childExamId'] as String?,
      questionId: json['questionId'] as String?,
      score: json['score'] as int?,
      isAnswered: json['isAnswered'] as bool? ?? false,
      question: json['question'] == null
          ? null
          : Question.fromJson(json['question'] as Map<String, dynamic>),
      childExamQuestionAnswers:
          json['childExamQuestionAnswers'] as List<dynamic>?,
    );
  }
  String? id;
  String? userId;
  String? childExamId;
  String? questionId;
  int? score;
  bool isAnswered;
  Question? question;
  List<dynamic>? childExamQuestionAnswers;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'childExamId': childExamId,
        'questionId': questionId,
        'score': score,
        'isAnswered': isAnswered,
        'question': question?.toJson(),
        'childExamQuestionAnswers': childExamQuestionAnswers,
      };
}
