import 'package:amaan_tv/core/models/pagination_model.dart';
import 'package:amaan_tv/Features/quiz/data/model/child_exam_model/child_exam_model.dart';

class QuizzesModel {
  QuizzesModel({
    this.isSuccess,
    this.statusCode,
    this.data,
    this.pagination,
    this.error,
    this.errorMessage,
  });

  QuizzesModel.fromJson(json) {
    isSuccess = json['isSuccess'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? QuizzesData.fromJson(json['data']) : null;
    pagination = PaginationModel.fromJson(json['data']['pagination']);
    error = json['error'];
    errorMessage = json['errorMessage'];
  }

  int get length => pagination?.totalCount ?? data?.all.length ?? 0;

  bool? isSuccess;
  int? statusCode;
  QuizzesData? data;
  PaginationModel? pagination;
  dynamic error;
  dynamic errorMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['statusCode'] = statusCode;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['pagination'] = pagination?.toJson();
    map['error'] = error;
    map['errorMessage'] = errorMessage;
    return map;
  }
}

class QuizzesData {
  QuizzesData({
    this.completedExams,
    this.unfinishedExams,
    this.unstartedExams,
  });

  QuizzesData.fromJson(json) {
    if (json['completedExams'] != null) {
      completedExams = [];
      json['completedExams'].forEach((v) {
        completedExams?.add(ChildExamModel.fromJson(v));
      });
    }
    if (json['unfinishedExams'] != null) {
      unfinishedExams = [];
      json['unfinishedExams'].forEach((v) {
        unfinishedExams?.add(ChildExamModel.fromJson(v));
      });
    }
    if (json['unstartedExams'] != null) {
      unstartedExams = [];
      json['unstartedExams'].forEach((v) {
        unstartedExams?.add(ChildExamModel.fromJson(v));
      });
    }
    totalUnfinishedExams = json['totalUnfinishedExams'];
    totalUnstartedExams = json['totalUnstartedExams'];
    totalCompletedExams = json['totalCompletedExams'];
  }

  List<ChildExamModel>? completedExams;
  List<ChildExamModel>? unfinishedExams;
  List<ChildExamModel>? unstartedExams;

  int? totalUnfinishedExams;
  int? totalUnstartedExams;
  int? totalCompletedExams;

  List<ChildExamModel> get all =>
      List.from([...?unfinishedExams, ...?unstartedExams, ...?completedExams]);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (completedExams != null) {
      map['completedExams'] = completedExams?.map((v) => v.toJson()).toList();
    }
    if (unfinishedExams != null) {
      map['unfinishedExams'] = unfinishedExams?.map((v) => v.toJson()).toList();
    }
    if (unstartedExams != null) {
      map['unstartedExams'] = unstartedExams?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
