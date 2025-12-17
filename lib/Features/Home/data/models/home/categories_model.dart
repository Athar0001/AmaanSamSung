import 'dart:convert';
import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/image.dart';

class CategoriesModel {

  CategoriesModel({
    this.isSuccess,
    this.statusCode,
    this.data,
    this.pagination,
    this.error,
    this.errorMessage,
  });

  factory CategoriesModel.fromRawJson(String str) =>
      CategoriesModel.fromJson(json.decode(str));

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        isSuccess: json['isSuccess'],
        statusCode: json['statusCode'],
        data: json['data'] == null
            ? []
            : List<CategoryData>.from(
                json['data']!.map((x) => CategoryData.fromJson(x))),
        pagination: json['pagination'] == null
            ? null
            : Pagination.fromJson(json['pagination']),
        error: json['error'],
        errorMessage: json['errorMessage'],
      );
  final bool? isSuccess;
  final int? statusCode;
  final List<CategoryData>? data;
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

class CategoryData {

  CategoryData({
    this.id,
    this.name,
    this.description,
    this.parentCategoryId,
    this.isActive,
    this.totalNumShows,
    this.parentCategory,
    this.childCategories,
    this.image,
    this.backgroundImage,
  });

  factory CategoryData.fromRawJson(String str) =>
      CategoryData.fromJson(json.decode(str));

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        image: json['image'] == null
            ? null
            : ForgroundImage.fromJson(json['image']),
        backgroundImage: json['backgroundImage'] == null
            ? null
            : ForgroundImage.fromJson(json['backgroundImage']),
        id: json['id'],
        name: json['name'],
        description: json['description'],
        parentCategoryId: json['parentCategoryId'],
        isActive: json['isActive'],
        totalNumShows: json['totalNumShows'],
        parentCategory: json['parentCategory'] == null
            ? null
            : ParentCategory.fromJson(json['parentCategory']),
        childCategories: json['childCategories'] == null
            ? []
            : List<CategoryData>.from(
                json['childCategories']!.map((x) => CategoryData.fromJson(x))),
      );
  final String? id;
  final String? name;
  final String? description;
  final String? parentCategoryId;
  final bool? isActive;
  final int? totalNumShows;
  final ParentCategory? parentCategory;
  final List<CategoryData>? childCategories;
  final ForgroundImage? image;
  final ForgroundImage? backgroundImage;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'parentCategoryId': parentCategoryId,
        'isActive': isActive,
        'totalNumShows': totalNumShows,
        'parentCategory': parentCategory?.toJson(),
        'childCategories': childCategories == null
            ? []
            : List<dynamic>.from(childCategories!.map((x) => x.toJson())),
      };
}

class ParentCategory {

  ParentCategory({
    this.id,
    this.name,
    this.description,
    this.parentCategoryId,
    this.parentCategory,
  });

  factory ParentCategory.fromRawJson(String str) =>
      ParentCategory.fromJson(json.decode(str));

  factory ParentCategory.fromJson(Map<String, dynamic> json) => ParentCategory(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        parentCategoryId: json['parentCategoryId'],
        parentCategory: json['parentCategory'],
      );
  final String? id;
  final String? name;
  final String? description;
  final dynamic parentCategoryId;
  final dynamic parentCategory;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'parentCategoryId': parentCategoryId,
        'parentCategory': parentCategory,
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
