import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/image.dart';

class ShowSeasons {

  ShowSeasons(
      {this.id,
      this.title,
      this.season,
      this.showUniverseId,
      this.thumbnailImage});

  factory ShowSeasons.fromJson(Map<String, dynamic> json) => ShowSeasons(
        id: json['id'] as String?,
        title: json['title'] as String?,
        season: json['season'] as int?,
        showUniverseId: json['showUniverseId'] as String?,
        thumbnailImage: json['thumbnailImage'] == null
            ? null
            : ForgroundImage.fromJson(
                json['thumbnailImage'] as Map<String, dynamic>),
      );
  String? id;
  String? title;
  int? season;
  String? showUniverseId;
  ForgroundImage? thumbnailImage;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'season': season,
        'showUniverseId': showUniverseId,
      };
}

List<ShowSeasons> orderSeasons(List<ShowSeasons> seasons) {
  seasons.sort((a, b) => a.season!.compareTo(b.season!));
  return seasons;
}
