import 'package:amaan_tv/core/models/pagination_model.dart';
import 'package:amaan_tv/core/models/serialized_object.dart';

class ResponseModel<T extends SerializedObject> {

  ResponseModel({
    required this.data, this.isSuccess,
    this.statusCode,
    this.pagination,
    this.error,
    this.errorMessage,
  });

  factory ResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) =>
      ResponseModel(
        isSuccess: json['isSuccess'],
        statusCode: json['statusCode'],
        data: json['data'] == null
            ? []
            : List<T>.from(json['data']!.map((x) => fromJson(x))),
        pagination: json['pagination'] == null
            ? null
            : PaginationModel.fromJson(json['pagination']),
        error: json['error'],
        errorMessage: json['errorMessage'],
      );
  final bool? isSuccess;
  final int? statusCode;
  List<T> data = const [];

  final PaginationModel? pagination;
  final dynamic error;
  final dynamic errorMessage;

  int? get length => pagination?.totalCount ?? data.length;

  Map<String, dynamic> toJson() => {
        'isSuccess': isSuccess,
        'statusCode': statusCode,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
        'pagination': pagination?.toJson(),
        'error': error,
        'errorMessage': errorMessage,
      };
}
