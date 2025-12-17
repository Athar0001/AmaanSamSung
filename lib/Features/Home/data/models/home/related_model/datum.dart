import 'package:amaan_tv/Features/Home/data/models/home/episodes_show_model/show_type.dart';
import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/image.dart';

class Datum {

  Datum({
    this.id,
    this.title,
    this.duration,
    this.thumbnailImageId,
    this.isFavourite,
    this.releaseDate,
    this.showType,
    this.thumbnailImage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json['id'] as String?,
      title: json['title'] as String?,
      duration: json['duration'] as String?,
      thumbnailImageId: json['thumbnailImageId'] as String?,
      isFavourite: json['isFavourite'] as dynamic,
      releaseDate: json['releaseDate'] as String?,
      showType: json['showType'] == null
          ? null
          : ShowType.fromJson(json['showType'] as Map<String, dynamic>),
      thumbnailImage: json['thumbnailImage'] == null
          ? null
          : ForgroundImage.fromJson(json['thumbnailImage']));
  String? id;
  String? title;
  String? duration;
  String? thumbnailImageId;
  dynamic isFavourite;
  String? releaseDate;
  ShowType? showType;
  ForgroundImage? thumbnailImage;
}
