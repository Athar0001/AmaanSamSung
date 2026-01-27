import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/image.dart';

import 'question_answer.dart';

enum QuestionType {
  text(1),
  character(2),
  gridView(3),
  listView(4),
  switchEmoji(5),
  ;

  final int id;

  const QuestionType(this.id);
}

class Question {
  Question({
    this.id,
    this.text,
    this.weight,
    this.examId,
    this.attachmentId,
    this.questionType = QuestionType.text,
    this.attachment,
    this.questionAnswers,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json['id'] as String?,
        text: json['text'] as String?,
        weight: json['weight'] as int?,
        examId: json['examId'] as String?,
        attachmentId: json['attachmentId'] as String?,
        questionType: QuestionType.values.firstWhere(
            (type) => type.id == (json['questionType'] as int? ?? 1)),
        attachment: (json['attachment'] is Map)
            ? ForgroundImage.fromJson(json['attachment'])
            : null,
        questionAnswers: (json['questionAnswers'] as List<dynamic>?)
            ?.map((e) => QuestionAnswer.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  String? id;
  String? text;
  int? weight;
  String? examId;
  String? attachmentId;
  QuestionType questionType;
  ForgroundImage? attachment;
  List<QuestionAnswer>? questionAnswers;

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'weight': weight,
        'examId': examId,
        'attachmentId': attachmentId,
        'questionType': questionType.id,
        'attachment': attachment,
        'questionAnswers': questionAnswers?.map((e) => e.toJson()).toList(),
      };
}
