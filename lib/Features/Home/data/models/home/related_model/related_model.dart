import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';

class RelatedModel {

  RelatedModel({
    this.isSuccess,
    this.statusCode,
    this.data,
    this.pagination,
    this.error,
    this.errorMessage,
  });

  factory RelatedModel.fromJson(Map<String, dynamic> json) => RelatedModel(
        isSuccess: json['isSuccess'] as bool?,
        statusCode: json['statusCode'] as int?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Details.fromJson(e as Map<String, dynamic>))
            .toList(),
        pagination: json['pagination'] as dynamic,
        error: json['error'] as dynamic,
        errorMessage: json['errorMessage'] as dynamic,
      );
  bool? isSuccess;
  int? statusCode;
  List<Details>? data;
  dynamic pagination;
  dynamic error;
  dynamic errorMessage;
}
