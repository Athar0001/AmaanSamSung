import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/image.dart';
import 'package:amaan_tv/core/models/characters_model.dart';
import 'package:amaan_tv/core/models/content_type.dart';
import 'package:amaan_tv/core/models/favorite_model.dart';

class SearchModel {
  SearchModel({
    this.isSuccess,
    this.statusCode,
    this.searchList,
    this.pagination,
    this.error,
    this.errorMessage,
  });

  SearchModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      searchList = <SearchItem>[];
      json['data'].forEach((v) {
        searchList!.add(SearchItem.fromJson(v));
      });
    }
    pagination = json['pagination'];
    error = json['error'];
    errorMessage = json['errorMessage'];
  }
  bool? isSuccess;
  int? statusCode;
  List<SearchItem>? searchList;
  dynamic pagination;
  dynamic error;
  dynamic errorMessage;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isSuccess'] = isSuccess;
    data['statusCode'] = statusCode;
    if (this.searchList != null) {
      data['data'] = this.searchList!.map((v) => v.toJson()).toList();
    }
    data['pagination'] = pagination;
    data['error'] = error;
    data['errorMessage'] = errorMessage;
    return data;
  }
}

class SearchItem extends FavoriteModel {
  SearchItem({
    required super.id,
    this.title,
    this.showId,
    this.releaseDate,
    this.description,
    super.contentType = ContentType.show,
    this.thumbnailImage,
    super.isFavorite = false,
  });

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
      id: json['id'],
      title: json['title'],
      showId: json['showId'],
      description: json['description'],
      releaseDate: json['releaseDate'] as String?,
      contentType: ContentType.values.firstWhere(
        (element) =>
            element.name.toLowerCase() ==
            json['contentType'].toString().toLowerCase(),
        orElse: () => ContentType.show,
      ),
      isFavorite: json['isFavorite'] ?? json['isFavourite'],
      thumbnailImage: json['thumbnailImage'] == null
          ? null
          : ForgroundImage.fromJson(
              json['thumbnailImage'] is Map<String, dynamic>
                  ? json['thumbnailImage']
                  : {'id': null, 'name': null, 'url': json['thumbnailImage']},
            ),
    );
  }
  String? showId;
  String? title;
  String? description;
  ForgroundImage? thumbnailImage;
  String? releaseDate;

  DateTime? get releaseDateTime =>
      releaseDate != null ? DateTime.tryParse(releaseDate!) : null;

  bool get isReleased =>
      releaseDateTime == null || releaseDateTime!.isBefore(DateTime.now());

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['contentType'] = contentType.name;
    data['isFavorite'] = isFavorite;
    data['thumbnailImage'] = thumbnailImage;
    return data;
  }

  //mappers to content type
  CharacterData get toCharacterData {
    return CharacterData(
      id: id,
      name: title,
      description: description,
      image: thumbnailImage,
      isFavorite: isFavorite.value,
    );
  }
}
