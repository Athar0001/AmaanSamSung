class AnswerQuestionModel {
  const AnswerQuestionModel({
    required this.questionId,
    required this.childExamQuestionId,
    required this.childExamQuestionAnswerId,
  });

  factory AnswerQuestionModel.fromJson(json) {
    return AnswerQuestionModel(
      questionId: json['questionId'],
      childExamQuestionId: json['childExamQuestionId'],
      childExamQuestionAnswerId: json['childExamQuestionAnswerId'],
    );
  }
  final String questionId;
  final String childExamQuestionId;
  final String childExamQuestionAnswerId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['questionId'] = questionId;
    map['childExamQuestionId'] = childExamQuestionId;
    map['childExamQuestionAnswerId'] = childExamQuestionAnswerId;
    return map;
  }
}
