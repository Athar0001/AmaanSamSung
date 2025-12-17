import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/image.dart';
import 'show.dart';

class Episode {

  Episode({
    this.id,
    this.title,
    this.duration,
    this.showId,
    this.isFavorite,
    this.releaseDate,
    this.show,
    this.thumbnailImage,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        id: json['id'] as String?,
        title: json['title'] as String?,
        duration: json['duration'] as String?,
        showId: json['showId'] as String?,
        isFavorite: json['isFavorite'] as bool?,
        releaseDate: json['releaseDate'] as String?,
        show: json['show'] == null
            ? null
            : Show.fromJson(json['show'] as Map<String, dynamic>),
        thumbnailImage: json['thumbnailImage'] == null
            ? null
            : ForgroundImage.fromJson(
                json['thumbnailImage'] as Map<String, dynamic>),
      );
  String? id;
  String? title;
  String? duration;
  String? showId;
  bool? isFavorite;
  Show? show;
  String? releaseDate;
  ForgroundImage? thumbnailImage;
  DateTime? get releaseDateTime =>
      releaseDate != null ? DateTime.tryParse(releaseDate!) : null;

  bool get isReleased =>
      releaseDateTime == null || releaseDateTime!.isBefore(DateTime.now());
}
