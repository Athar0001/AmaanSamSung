import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/genre.dart';

class BannerGeners {

  BannerGeners({this.id, this.genreId, this.genre});

  factory BannerGeners.fromJson(Map<String, dynamic> json) => BannerGeners(
        id: json['id'] as String?,
        genreId: json['genreId'] as String?,
        genre: json['genre'] == null
            ? null
            : Genre.fromJson(json['genre'] as Map<String, dynamic>),
      );
  String? id;
  String? genreId;
  Genre? genre;

  Map<String, dynamic> toJson() => {
        'id': id,
        'genreId': genreId,
        'genre': genre?.toJson(),
      };
}
