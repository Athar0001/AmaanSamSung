import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';

class FavoriteShowsModel {
  FavoriteShowsModel(
      {this.isSuccess,
      this.statusCode,
      this.favoriteShows,
      this.pagination,
      this.error,
      this.errorMessage});

  FavoriteShowsModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      favoriteShows = <FavoriteShow>[];
      json['data'].forEach((v) {
        favoriteShows!.add(FavoriteShow.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    error = json['error'];
    errorMessage = json['errorMessage'];
  }
  bool? isSuccess;
  int? statusCode;

  List<FavoriteShow>? favoriteShows;
  Pagination? pagination;
  dynamic error;
  dynamic errorMessage;
}

class FavoriteShow {
  FavoriteShow({this.id, this.showId, this.userId, this.show});

  FavoriteShow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    showId = json['showId'];
    userId = json['userId'];
    show = json['show'] != null
        ? Details.fromJson(json['show']..['isFavorite'] = true)
        : null;
  }
  String? id;
  String? showId;
  String? userId;
  Details? show;
}

class Pagination {
  Pagination(
      {this.pageNumber,
      this.totalPages,
      this.totalCount,
      this.hasPreviousPage,
      this.hasNextPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    totalPages = json['totalPages'];
    totalCount = json['totalCount'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
  }
  int? pageNumber;
  int? totalPages;
  int? totalCount;
  bool? hasPreviousPage;
  bool? hasNextPage;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pageNumber'] = pageNumber;
    data['totalPages'] = totalPages;
    data['totalCount'] = totalCount;
    data['hasPreviousPage'] = hasPreviousPage;
    data['hasNextPage'] = hasNextPage;
    return data;
  }
}
