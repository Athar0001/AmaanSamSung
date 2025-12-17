import 'data.dart';

class SubCategoriesModel {

  SubCategoriesModel({
    this.isSuccess,
    this.statusCode,
    this.data,
    this.pagination,
    this.error,
    this.errorMessage,
  });

  factory SubCategoriesModel.fromJson(Map<String, dynamic> json) {
    return SubCategoriesModel(
      isSuccess: json['isSuccess'] as bool?,
      statusCode: json['statusCode'] as int?,
      data: json['data'] == null
          ? null
          : SubCategories.fromJson(json['data'] as Map<String, dynamic>),
      pagination: json['pagination'] as dynamic,
      error: json['error'] as dynamic,
      errorMessage: json['errorMessage'] as dynamic,
    );
  }
  bool? isSuccess;
  int? statusCode;
  SubCategories? data;
  dynamic pagination;
  dynamic error;
  dynamic errorMessage;

  Map<String, dynamic> toJson() => {
        'isSuccess': isSuccess,
        'statusCode': statusCode,
        'data': data?.toJson(),
        'pagination': pagination,
        'error': error,
        'errorMessage': errorMessage,
      };
}
