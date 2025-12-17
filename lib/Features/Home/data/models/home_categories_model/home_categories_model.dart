import 'categories.dart';

class HomeCategoriesModel {

  HomeCategoriesModel({
    this.isSuccess,
    this.statusCode,
    this.data,
    this.pagination,
    this.error,
    this.errorMessage,
  });

  factory HomeCategoriesModel.fromJson(Map<String, dynamic> json) {
    return HomeCategoriesModel(
      isSuccess: json['isSuccess'] as bool?,
      statusCode: json['statusCode'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] as dynamic,
      error: json['error'] as dynamic,
      errorMessage: json['errorMessage'] as dynamic,
    );
  }
  bool? isSuccess;
  int? statusCode;
  List<Category>? data;
  dynamic pagination;
  dynamic error;
  dynamic errorMessage;

  Map<String, dynamic> toJson() => {
        'isSuccess': isSuccess,
        'statusCode': statusCode,
        'data': data?.map((e) => e.toJson()).toList(),
        'pagination': pagination,
        'error': error,
        'errorMessage': errorMessage,
      };
}
