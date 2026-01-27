import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/image.dart';

class QuestionAnswer {
  QuestionAnswer({
    this.id,
    this.text,
    this.score = 0,
    this.questionId,
    this.attachmentId,
    this.attachment,
  });

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) {
    return QuestionAnswer(
      id: json['id'] as String?,
      text: json['text'] as String?,
      score: json['score'] as int? ?? 0,
      questionId: json['questionId'] as String?,
      attachmentId: json['attachmentId'] as String?,
      attachment: (json['attachment'] is Map)
          ? ForgroundImage.fromJson(json['attachment'])
          : null,
    );
  }
  String? id;
  String? text;
  int score;
  String? questionId;
  String? attachmentId;
  ForgroundImage? attachment;

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'score': score,
        'questionId': questionId,
        'attachmentId': attachmentId,
        'attachment': attachment,
      };
}
