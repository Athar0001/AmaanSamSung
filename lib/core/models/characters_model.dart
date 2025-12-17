import 'dart:convert';
import 'package:amaan_tv/core/models/content_type.dart';
import 'package:amaan_tv/core/models/favorite_model.dart';
import 'package:amaan_tv/core/models/pagination_model.dart';
import 'package:amaan_tv/core/models/serialized_object.dart';
import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/image.dart';

class CharactersModel {

  CharactersModel({
    required this.data, this.isSuccess,
    this.statusCode,
    this.pagination,
    this.error,
    this.errorMessage,
  });

  factory CharactersModel.fromRawJson(String str) =>
      CharactersModel.fromJson(json.decode(str));

  factory CharactersModel.fromJson(Map<String, dynamic> json) =>
      CharactersModel(
        isSuccess: json['isSuccess'],
        statusCode: json['statusCode'],
        data: json['data'] == null
            ? []
            : List<CharacterData>.from(
                json['data']!.map((x) => CharacterData.fromJson(x))),
        pagination: json['pagination'] == null
            ? null
            : PaginationModel.fromJson(json['pagination']),
        error: json['error'],
        errorMessage: json['errorMessage'],
      );
  final bool? isSuccess;
  final int? statusCode;
  List<CharacterData> data = const [];

  final PaginationModel? pagination;
  final dynamic error;
  final dynamic errorMessage;

  int? get length => pagination?.totalCount ?? data.length;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'isSuccess': isSuccess,
        'statusCode': statusCode,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
        'pagination': pagination?.toJson(),
        'error': error,
        'errorMessage': errorMessage,
      };
}

class CharacterData extends FavoriteModel with SerializedObjectMixin {

  CharacterData({
    required super.id,
    this.name,
    this.description,
    super.isFavorite = false,
    this.image,
    this.backgroundImage,
  }) : super(contentType: ContentType.character);

  factory CharacterData.fromRawJson(String str) =>
      CharacterData.fromJson(json.decode(str));

  factory CharacterData.fromJson(Map<String, dynamic> json) {
    //to parse favorite model
    final character = json['character'] ?? json;
    final isFavorite =
        character['isFavorite'] == true || json['character'] != null;
    return CharacterData(
      id: character['id'],
      name: character['name'],
      description: character['description'],
      isFavorite: isFavorite,
      image: character['image'] == null
          ? null
          : ForgroundImage.fromJson(character['image']),
      backgroundImage: character['backgroundImage'] == null
          ? null
          : ForgroundImage.fromJson(character['backgroundImage']),
    );
  }
  final String? name;
  final String? description;
  final ForgroundImage? image;
  final ForgroundImage? backgroundImage;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'isFavorite': isFavorite.value,
        'image': image?.toJson(),
        'backgroundImage': backgroundImage?.toJson(),
      };
}
