import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/core/models/content_type.dart';

import 'pagination.dart';

class EpisodesShowModel {

  EpisodesShowModel({
    this.isSuccess,
    this.statusCode,
    this.data,
    this.pagination,
    this.error,
    this.errorMessage,
  });

  factory EpisodesShowModel.fromJson(Map<String, dynamic> json) {
    return EpisodesShowModel(
      isSuccess: json['isSuccess'] as bool?,
      statusCode: json['statusCode'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Details.fromJson(
                e as Map<String, dynamic>,
                contentType: ContentType.episode,
              ))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      error: json['error'] as dynamic,
      errorMessage: json['errorMessage'] as dynamic,
    );
  }
  bool? isSuccess;
  int? statusCode;
  List<Details>? data;
  Pagination? pagination;
  dynamic error;
  dynamic errorMessage;
}
