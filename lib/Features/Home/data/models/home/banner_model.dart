import 'dart:convert';

import 'package:amaan_tv/Features/Home/data/models/home/banner_geners.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/image.dart';

class BannerModel {

  BannerModel({
    this.isSuccess,
    this.statusCode,
    this.data,
    this.pagination,
    this.error,
    this.errorMessage,
  });

  factory BannerModel.fromRawJson(String str) =>
      BannerModel.fromJson(json.decode(str));

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        isSuccess: json['isSuccess'],
        statusCode: json['statusCode'],
        data: json['data'] == null
            ? []
            : List<BannerData>.from(
                json['data']!.map((x) => BannerData.fromJson(x))),
        pagination: json['pagination'],
        error: json['error'],
        errorMessage: json['errorMessage'],
      );
  final bool? isSuccess;
  final int? statusCode;
  final List<BannerData>? data;
  final dynamic pagination;
  final dynamic error;
  final dynamic errorMessage;
}

class BannerData {

  BannerData({
    required this.show, this.showId,
    this.order,
  });

  factory BannerData.fromRawJson(String str) =>
      BannerData.fromJson(json.decode(str));

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
        showId: json['showId'],
        order: json['order'],
        show: Details.fromJson(json['show']),
      );
  final String? showId;
  final int? order;
  final Details show;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'showId': showId,
        'order': order,
        'show': show.toJson(),
      };
}

class Show {

  Show({
    this.id,
    this.title,
    this.duration,
    this.isFavourite,
    this.bannerGeners,
    this.releaseDate,
    this.showType,
    this.thumbnailImage,
    this.bannerThumbnailImage,
    this.showCategories,
    this.showAgeRadnges,
  });

  factory Show.fromRawJson(String str) => Show.fromJson(json.decode(str));

  factory Show.fromJson(Map<String, dynamic> json) => Show(
        id: json['id'],
        title: json['title'],
        duration: json['duration'],
        isFavourite: json['isFavourite'],
        releaseDate: json['releaseDate'] as String?,
        showType:
            json['showType'] == null ? null : Type.fromJson(json['showType']),
        thumbnailImage: json['thumbnailImage'] == null
            ? null
            : ForgroundImage.fromJson(json['thumbnailImage']),
        bannerThumbnailImage: json['bannerThumbnailImage'] == null
            ? null
            : ForgroundImage.fromJson(json['bannerThumbnailImage']),
        bannerGeners: json['showGenres'] == null
            ? []
            : List<BannerGeners>.from(
                json['showGenres']!.map((x) => BannerGeners.fromJson(x))),
        showCategories: json['showCategories'] == null
            ? []
            : List<ShowCategory>.from(
                json['showCategories']!.map((x) => ShowCategory.fromJson(x))),
        showAgeRadnges: json['showAgeRadnges'] == null
            ? []
            : List<dynamic>.from(json['showAgeRadnges']!.map((x) => x)),
      );
  final String? id;
  final String? title;
  final String? duration;
  bool? isFavourite;
  final Type? showType;
  String? releaseDate;
  final ForgroundImage? thumbnailImage;
  final ForgroundImage? bannerThumbnailImage;
  final List<ShowCategory>? showCategories;
  final List<dynamic>? showAgeRadnges;
  final List<BannerGeners>? bannerGeners;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'duration': duration,
        'isFavourite': isFavourite,
        'showType': showType?.toJson(),
        'thumbnailImage': thumbnailImage?.toJson(),
        'showCategories': showCategories == null
            ? []
            : List<dynamic>.from(showCategories!.map((x) => x.toJson())),
        'showAgeRadnges': showAgeRadnges == null
            ? []
            : List<dynamic>.from(showAgeRadnges!.map((x) => x)),
      };
}

class ShowCategory {

  ShowCategory({
    this.id,
    this.categoryId,
    this.category,
  });

  factory ShowCategory.fromRawJson(String str) =>
      ShowCategory.fromJson(json.decode(str));

  factory ShowCategory.fromJson(Map<String, dynamic> json) => ShowCategory(
        id: json['id'],
        categoryId: json['categoryId'],
        category: json['category'] == null
            ? null
            : Category.fromJson(json['category']),
      );
  final String? id;
  final String? categoryId;
  final Category? category;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'categoryId': categoryId,
        'category': category?.toJson(),
      };
}

class Category {

  Category({
    this.id,
    this.name,
    this.description,
    this.parentCategoryId,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        parentCategoryId: json['parentCategoryId'],
      );
  final String? id;
  final String? name;
  final String? description;
  final dynamic parentCategoryId;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'parentCategoryId': parentCategoryId,
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
        name: json['name'],
        isActive: json['isActive'],
      );
  final String? id;
  final String? name;
  final bool? isActive;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'isActive': isActive,
      };
}
