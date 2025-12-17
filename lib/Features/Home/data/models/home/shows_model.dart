import 'dart:convert';

import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/image.dart';

class ShowsModel {

  ShowsModel({
    this.isSuccess,
    this.statusCode,
    this.data,
    this.pagination,
    this.error,
    this.errorMessage,
  });

  factory ShowsModel.fromRawJson(String str) =>
      ShowsModel.fromJson(json.decode(str));

  factory ShowsModel.fromJson(Map<String, dynamic> json) => ShowsModel(
        isSuccess: json['isSuccess'],
        statusCode: json['statusCode'],
        data: json['data'] == null
            ? []
            : List<Details>.from(
                json['data']!.map((x) => Details.fromJson(x))),
        pagination: json['pagination'] == null
            ? null
            : Pagination.fromJson(json['pagination']),
        error: json['error'],
        errorMessage: json['errorMessage'],
      );
  final bool? isSuccess;
  final int? statusCode;
  final List<Details>? data;
  final Pagination? pagination;
  final dynamic error;
  final dynamic errorMessage;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'isSuccess': isSuccess,
        'statusCode': statusCode,
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        'pagination': pagination?.toJson(),
        'error': error,
        'errorMessage': errorMessage,
      };
}

class ShowData {

  ShowData({
    this.id,
    this.title,
    this.duration,
    this.thumbnailImageId,
    this.isFavourite,
    this.releaseDate,
    this.showType,
    this.thumbnailImage,
    this.showCategories,
    this.showAgeRadnges,
    this.genres,
  });

  factory ShowData.fromRawJson(String str) =>
      ShowData.fromJson(json.decode(str));

  factory ShowData.fromJson(Map<String, dynamic> json) => ShowData(
        id: json['id'],
        title: json['title'],
        duration: json['duration'],
        thumbnailImageId: json['thumbnailImageId'],
        isFavourite: json['isFavourite'] ?? false,
        releaseDate: json['releaseDate'] == null
            ? null
            : DateTime.parse(json['releaseDate']),
        showType:
            json['showType'] == null ? null : Type.fromJson(json['showType']),
        thumbnailImage: json['thumbnailImage'] == null
            ? null
            : ForgroundImage.fromJson(json['thumbnailImage']),
        showCategories: json['showCategories'] == null
            ? []
            : List<dynamic>.from(json['showCategories']!.map((x) => x)),
        showAgeRadnges: json['showAgeRadnges'] == null
            ? []
            : List<dynamic>.from(json['showAgeRadnges']!.map((x) => x)),
        genres: json['genres'] == null
            ? []
            : List<Genre>.from(json['genres']!.map((x) => Genre.fromJson(x))),
      );
  final String? id;
  final String? title;
  final String? duration;
  final String? thumbnailImageId;
  bool? isFavourite = false;
  final DateTime? releaseDate;
  final Type? showType;
  final ForgroundImage? thumbnailImage;
  final List<dynamic>? showCategories;
  final List<dynamic>? showAgeRadnges;
  final List<Genre>? genres;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'duration': duration,
        'thumbnailImageId': thumbnailImageId,
        'isFavourite': isFavourite,
        'releaseDate': releaseDate?.toIso8601String(),
        'showType': showType?.toJson(),
        'thumbnailImage': thumbnailImage?.toJson(),
        'showCategories': showCategories == null
            ? []
            : List<dynamic>.from(showCategories!.map((x) => x)),
        'showAgeRadnges': showAgeRadnges == null
            ? []
            : List<dynamic>.from(showAgeRadnges!.map((x) => x)),
        'genres': genres == null
            ? []
            : List<dynamic>.from(genres!.map((x) => x.toJson())),
      };
}

class Genre {

  Genre({
    this.id,
    this.name,
  });

  factory Genre.fromRawJson(String str) => Genre.fromJson(json.decode(str));

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json['id'],
        name: json['name'],
      );
  final String? id;
  final String? name;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

class Type {

  Type({
    this.id,
    this.name,
    this.isActive,
  });

  factory Type.fromRawJson(String str) => Type.fromJson(json.decode(str));

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json['id'],
        name: json['name'] != null ? nameValues.map[json['name']] : Name.EMPTY,
        isActive: json['isActive'],
      );
  final String? id;
  final Name? name;
  final bool? isActive;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': nameValues.reverse[name],
        'isActive': isActive,
      };
}

enum Name { EMPTY, MOVIEE, NAME, PURPLE, SERIES, TEST_TEST_TES }

final nameValues = EnumValues({
  'فيلمم': Name.EMPTY,
  'Moviee': Name.MOVIEE,
  'مسلسل': Name.NAME,
  'تيست': Name.PURPLE,
  'Series': Name.SERIES,
  'test test tes ': Name.TEST_TEST_TES
});

class DatumTranslation {

  DatumTranslation({
    this.title,
    this.description,
  });

  factory DatumTranslation.fromRawJson(String str) =>
      DatumTranslation.fromJson(json.decode(str));

  factory DatumTranslation.fromJson(Map<String, dynamic> json) =>
      DatumTranslation(
        title: json['title'],
        description: json['description'],
      );
  final String? title;
  final String? description;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
      };
}

class Pagination {

  Pagination({
    this.pageNumber,
    this.totalPages,
    this.totalCount,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory Pagination.fromRawJson(String str) =>
      Pagination.fromJson(json.decode(str));

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        pageNumber: json['pageNumber'],
        totalPages: json['totalPages'],
        totalCount: json['totalCount'],
        hasPreviousPage: json['hasPreviousPage'],
        hasNextPage: json['hasNextPage'],
      );
  final int? pageNumber;
  final int? totalPages;
  final int? totalCount;
  final bool? hasPreviousPage;
  final bool? hasNextPage;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'pageNumber': pageNumber,
        'totalPages': totalPages,
        'totalCount': totalCount,
        'hasPreviousPage': hasPreviousPage,
        'hasNextPage': hasNextPage,
      };
}

class EnumValues<T> {

  EnumValues(this.map);
  Map<String, T> map;
  late Map<T, String> reverseMap;

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
