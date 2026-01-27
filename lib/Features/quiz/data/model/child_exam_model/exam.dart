import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/image.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';

enum ExamType {
  show(1),
  series(2);

  final int id;

  const ExamType(this.id);

  String get title {
    switch (this) {
      case ExamType.show:
        return AppLocalization.strings.show;
      case ExamType.series:
        return AppLocalization.strings.series;
    }
  }

  factory ExamType.fromInt(int value) => ExamType.values.firstWhere(
        (element) => element.id == value,
        orElse: () => ExamType.show,
      );
}

class Exam {
  Exam({
    this.id,
    this.name,
    this.showId,
    this.episodeId,
    this.noQuestions,
    this.examType,
    this.attachment,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    ForgroundImage? attachment;
    try {
      attachment = json['attachment'] != null
          ? ForgroundImage.fromJson(json['attachment'])
          : null;
    } catch (e) {
      attachment = null;
    }
    return Exam(
      id: json['id'] as String?,
      name: json['name'] as String?,
      showId: json['showId'] as String?,
      episodeId: json['episodeId'] as String?,
      noQuestions: json['noQuestions'] as int?,
      examType: ExamType.fromInt(json['examType'] as int? ?? 1),
      attachment: attachment,
    );
  }
  String? id;
  String? name;
  String? showId;
  String? episodeId;
  int? noQuestions;
  ExamType? examType;
  ForgroundImage? attachment;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'showId': showId,
        'episodeId': episodeId,
        'noQuestions': noQuestions,
        'examType': examType?.id,
        'attachment': attachment?.toJson()
      };
}
