class ExamScoreModel {
  ExamScoreModel({
    this.isSuccess,
    this.statusCode,
    this.data,
    this.pagination,
    this.error,
    this.errorMessage,
  });

  ExamScoreModel.fromJson(json) {
    isSuccess = json['isSuccess'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? ExamScoreData.fromJson(json['data']) : null;
    pagination = json['pagination'];
    error = json['error'];
    errorMessage = json['errorMessage'];
  }

  bool? isSuccess;
  int? statusCode;
  ExamScoreData? data;
  dynamic pagination;
  dynamic error;
  dynamic errorMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['statusCode'] = statusCode;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['pagination'] = pagination;
    map['error'] = error;
    map['errorMessage'] = errorMessage;
    return map;
  }
}

class ExamScoreData {
  ExamScoreData({
    this.totalScore,
    this.correctAnswers,
    this.wrongAnswers,
    this.childId,
    this.examId,
  });

  ExamScoreData.fromJson(json) {
    totalScore = json['totalScore'];
    correctAnswers = json['correctAnswers'];
    wrongAnswers = json['wrongAnswers'];
    childId = json['childId'];
    examId = json['examId'];
  }

  int? totalScore;
  int? correctAnswers;
  int? wrongAnswers;
  dynamic childId;
  dynamic examId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalScore'] = totalScore;
    map['correctAnswers'] = correctAnswers;
    map['wrongAnswers'] = wrongAnswers;
    map['childId'] = childId;
    map['examId'] = examId;
    return map;
  }
}
