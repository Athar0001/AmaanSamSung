import 'dart:convert';

class VideoModel {

  VideoModel({this.presignedUrl, this.title, this.description, this.videoName});

  factory VideoModel.fromRawJson(String str) =>
      VideoModel.fromJson(json.decode(str));

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        presignedUrl: json['presignedUrl'],
        videoName: json['videoName'],
        title: json['title'],
        description: json['description'],
      );
  final String? presignedUrl;
  final String? title;
  final String? videoName;
  final String? description;
}
