import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';

class FavoriteEpisodesModel {
  FavoriteEpisodesModel(
      {this.isSuccess,
      this.statusCode,
      this.favoriteShow,
      this.error,
      this.errorMessage});

  FavoriteEpisodesModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      favoriteShow = <FavoriteEpisode>[];
      json['data'].forEach((v) {
        favoriteShow!.add(FavoriteEpisode.fromJson(v));
      });
    }
    error = json['error'];
    errorMessage = json['errorMessage'];
  }
  bool? isSuccess;
  int? statusCode;
  List<FavoriteEpisode>? favoriteShow;
  dynamic error;
  dynamic errorMessage;
}

class FavoriteEpisode {
  FavoriteEpisode({this.id, this.episodeId, this.userId, this.episode});

  FavoriteEpisode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    episodeId = json['episodeId'];
    userId = json['userId'];
    episode =
        json['episode'] != null ? Details.fromJson(json['episode']) : null;
  }
  String? id;
  String? episodeId;
  String? userId;
  Details? episode;
}
