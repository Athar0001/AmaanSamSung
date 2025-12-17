import 'package:amaan_tv/core/models/serialized_object.dart';
import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/image.dart';
import 'show_type.dart';

class Shows extends SerializedObject {

  Shows({
    this.id,
    this.episodeId,
    this.title,
    this.duration,
    this.fromMinute,
    this.thumbnailImageId,
    this.isFavourite,
    this.releaseDate,
    this.showType,
    this.thumbnailImage,
    this.isFree,
    this.isGuest,
  });

  factory Shows.fromJson(Map<String, dynamic> json) => Shows(
        id: json['id'] as String?,
        episodeId: json['episodeId'] as String?,
        title: json['title'] as String?,
        duration: json['duration'] as String?,
        fromMinute: json['fromMinute'] as String?,
        thumbnailImageId: json['thumbnailImageId'] as String?,
        isFavourite: json['isFavourite'] as dynamic,
        releaseDate: json['releaseDate'] as String?,
        isFree: json['isFree'] as bool?,
        isGuest: json['isGuest'] as bool?,
        showType: json['showType'] == null
            ? null
            : ShowType.fromJson(json['showType'] as Map<String, dynamic>),
        thumbnailImage: json['thumbnailImage'] == null
            ? null
            : ForgroundImage.fromJson(
                json['thumbnailImage'] as Map<String, dynamic>),
      );
  String? id;
  String? episodeId;
  String? title;
  String? duration;
  String? fromMinute;
  String? thumbnailImageId;
  dynamic isFavourite;
  bool? isFree;
  bool? isGuest;
  String? releaseDate;
  ShowType? showType;
  ForgroundImage? thumbnailImage;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'duration': duration,
        'thumbnailImageId': thumbnailImageId,
        'isFavourite': isFavourite,
        'releaseDate': releaseDate,
        'showType': showType?.toJson(),
        'thumbnailImage': thumbnailImage?.toJson(),
      };
}
