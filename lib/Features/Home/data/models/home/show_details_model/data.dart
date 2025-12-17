import 'dart:developer';
import 'package:amaan_tv/core/models/content_type.dart';
import 'package:amaan_tv/core/models/favorite_model.dart';
import 'package:amaan_tv/Features/Home/data/models/home/banner_geners.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/seasons.dart';
import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/image.dart';
import 'package:amaan_tv/core/utils/constant.dart';

import 'age_range.dart';
import 'category.dart';
import 'package:amaan_tv/core/models/characters_model.dart';
import 'genre.dart';
import 'show_video.dart';

enum Module {
  video(1);

  final int id;

  const Module(this.id);
}

enum ShowDetailsType {
  movie,
  series,

  episode;

  String? get id {
    switch (this) {
      case ShowDetailsType.movie:
        return Constant.movieTypeId;
      case ShowDetailsType.series:
        return Constant.seriesTypeId;

      case ShowDetailsType.episode:
        return null;
    }
  }

  bool get isShow => this == ShowDetailsType.movie;

  bool get isEpisode => this == ShowDetailsType.episode;

  bool get isSeries => this == ShowDetailsType.series;
}

class Details extends FavoriteModel {
  Details({
    required super.id,
    this.idContinueWatching,
    this.showId,
    this.title = '',
    this.description,
    this.videoId,
    this.duration,
    this.fromMinute,
    this.presignedUrl,
    super.isFavorite = false,
    this.hasExam = false,
    this.childTakedExam = false,
    this.releaseDate,
    this.season,
    this.showUniverse,
    this.episodeId,
    this.thumbnailImage,
    this.eposideNumber,
    this.showTypeId,
    this.rate,
    this.categories,
    this.genres,
    this.showGenres,
    this.characters,
    this.showVideos,
    this.episodeVideos,
    this.bannerThumbnailImage,
    this.ageRanges,
    this.isGuest,
    this.isFree,
    this.trailerDuration,
    this.isRepeat = false,
    this.closingDuration,
    super.contentType = ContentType.show,
  });

  factory Details.fromJson(
    Map<String, dynamic> json, {
    ContentType contentType = ContentType.show,
  }) {
    final durationString = json['duration'] as String?;
    final duration = durationString != null
        ? Duration(seconds: int.tryParse(durationString) ?? 0)
        : null;

    return Details(
      // FIXED: Handle null id by using episodeId as fallback or generating a unique ID
      id:
          json['id'] as String? ??
          json['episodeId'] as String? ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      idContinueWatching: json['id'] as String?,
      showId: json['showId'] as String?,
      title: json['title'] as String? ?? '',
      videoId: json['videoId'] as String?,
      description: json['description'] as String?,
      fromMinute: json['fromMinute'] as String?,
      presignedUrl: json['presignedUrl'] as String?,
      duration: duration,
      isFavorite: json['isFavorite'] ?? json['isFavourite'],
      episodeId: json['episodeId'] as String?,
      hasExam: json['hasExam'] as bool? ?? false,
      childTakedExam: json['childTakedExam'] as bool? ?? false,
      isGuest: json['isGuest'] as bool? ?? false,
      isFree: json['isFree'] as bool? ?? false,
      isRepeat: json['isRepeat'] as bool? ?? false,
      releaseDate: json['releaseDate'] as String?,
      season: json['season'] as int?,
      eposideNumber: json['eposideNumber'] as int?,
      trailerDuration: int.tryParse(json['trailerDuration'].toString()),
      closingDuration: int.tryParse(json['closingDuration'].toString()),
      showUniverse: json['showUniverse'] == null
          ? null
          : Seasons.fromJson(json['showUniverse']),
      thumbnailImage: json['thumbnailImage'] == null
          ? null
          : ForgroundImage.fromJson(json['thumbnailImage']),
      bannerThumbnailImage: json['bannerThumbnailImage'] == null
          ? null
          : ForgroundImage.fromJson(json['bannerThumbnailImage']),
      showTypeId: json['showTypeId'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
      showGenres: (json['showGenres'] as List<dynamic>?)
          ?.map((e) => BannerGeners.fromJson(e as Map<String, dynamic>))
          .toList(),
      characters: (json['characters'] as List<dynamic>?)
          ?.map((e) => CharacterData.fromJson(e as Map<String, dynamic>))
          .toList(),
      showVideos: (json['showVideos'] as List<dynamic>?)
          ?.map((e) => ShowVideo.fromJson(e as Map<String, dynamic>))
          .toList(),
      episodeVideos: (json['episodeVideos'] as List<dynamic>?)
          ?.map((e) => ShowVideo.fromJson(e as Map<String, dynamic>))
          .toList(),
      ageRanges:
          (json['ageRanges'] as List<dynamic>?)
              ?.map((e) => AgeRange.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      contentType: contentType,
    );
  }
  String? idContinueWatching;
  String? showId;
  String? episodeId;
  String? presignedUrl;
  String? videoId;
  String? fromMinute;
  String title;
  String? description;
  Duration? duration;
  bool? isFree;
  bool? isGuest;
  bool hasExam;
  bool isRepeat;
  bool childTakedExam;
  String? releaseDate;
  int? season;
  int? trailerDuration;
  Seasons? showUniverse;
  int? eposideNumber;
  ForgroundImage? thumbnailImage;
  ForgroundImage? bannerThumbnailImage;
  int? closingDuration;

  DateTime? get releaseDateTime =>
      releaseDate != null ? DateTime.tryParse(releaseDate!) : null;

  bool get isReleased =>
      releaseDateTime == null || releaseDateTime!.isBefore(DateTime.now());

  ShowDetailsType get type {
    log(showTypeId.toString(), name: 'showTypeId');
    return ShowDetailsType.values.firstWhere(
      (element) => element.id == showTypeId,
      orElse: () => ShowDetailsType.episode,
    );
  }

  Duration? get remainingDurationUntilRelease {
    if (releaseDateTime == null) return null;
    final now = DateTime.now();
    return releaseDateTime!.isAfter(now)
        ? releaseDateTime!.difference(now)
        : Duration.zero;
  }

  String? showTypeId;
  double? rate;
  List<Category>? categories;
  List<Genre>? genres;
  List<BannerGeners>? showGenres;
  List<CharacterData>? characters;
  List<ShowVideo>? showVideos;
  List<ShowVideo>? episodeVideos;
  List<AgeRange>? ageRanges;

  String get genreString => genres?.map((e) => e.name).join(',') ?? '';

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'duration': duration,
    'isFavorite': isFavorite,
    'hasExam': hasExam,
    'childTakedExam': childTakedExam,
    'isGuest': isGuest,
    'isFree': isFree,
    'releaseDate': releaseDate,
    'season': season,
    'thumbnailImage': thumbnailImage?.toJson(),
    'showTypeId': showTypeId,
    'rate': rate,
    'trailerDuration': trailerDuration,
    'categories': categories?.map((e) => e.toJson()).toList(),
    'genres': genres?.map((e) => e.toJson()).toList(),
    'showGenres': showGenres?.map((e) => e.toJson()).toList(),
    'characters': characters?.map((e) => e.toJson()).toList(),
    'showVideos': showVideos?.map((e) => e.toJson()).toList(),
    'episodeVideos': episodeVideos?.map((e) => e.toJson()).toList(),
    'ageRanges': ageRanges?.map((e) => e.toJson()).toList(),
  };
}

class Rating {
  final double? average;
  Rating({this.average});
  factory Rating.fromJson(Map<String, dynamic> json) =>
      Rating(average: (json['average'] as num?)?.toDouble());
  static Rating newPercentageRating(dynamic value) =>
      Rating(average: (value as num?)?.toDouble());
}
