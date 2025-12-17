import 'data.dart';

class TopTenShowsModel {

  TopTenShowsModel({
    this.isSuccess,
    this.statusCode,
    this.data,
    this.pagination,
    this.error,
    this.errorMessage,
  });

  factory TopTenShowsModel.fromJson(Map<String, dynamic> json) =>
      TopTenShowsModel(
        isSuccess: json['isSuccess'] as bool?,
        statusCode: json['statusCode'] as int?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        pagination: json['pagination'] as dynamic,
        error: json['error'] as dynamic,
        errorMessage: json['errorMessage'] as dynamic,
      );
  bool? isSuccess;
  int? statusCode;
  Data? data;
  dynamic pagination;
  dynamic error;
  dynamic errorMessage;
}
