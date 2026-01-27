import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/image.dart';

class TopTenModel {
  TopTenModel({
    this.isSuccess,
    this.statusCode,
    this.data,
    this.pagination,
    this.error,
    this.errorMessage,
  });

  TopTenModel.fromJson(json) {
    isSuccess = json['isSuccess'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ChildModel.fromJson(v));
      });
    }
    pagination = json['pagination'];
    error = json['error'];
    errorMessage = json['errorMessage'];
  }

  bool? isSuccess;
  int? statusCode;
  List<ChildModel>? data;
  dynamic pagination;
  dynamic error;
  dynamic errorMessage;
}

class ChildModel {
  ChildModel({
    required this.totalScore,
    required this.childId,
    this.childName,
    this.childImage,
    this.correctAnswers,
    this.wrongAnswers,
    this.examId,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    final child = json['child'] ?? {};

    return ChildModel(
      totalScore: json['totalScore'],
      childName:
          json.containsKey('childName') ? json['childName'] : child['fullName'],
      childImage: ForgroundImage(
          url: json.containsKey('childImage')
              ? json['childImage']
              : child['profilePicture']),
      childId: json['childId'],
      correctAnswers: json['correctAnswers'],
      wrongAnswers: json['wrongAnswers'],
      examId: json['examId'],
    );
  }
  final int totalScore;
  final String? childName;
  final ForgroundImage? childImage;
  final String childId;
  final int? correctAnswers;
  final int? wrongAnswers;
  final String? examId;
}
