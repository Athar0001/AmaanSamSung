import 'package:json_annotation/json_annotation.dart';
import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/image.dart';
import 'package:amaan_tv/core/models/serialized_object.dart';

part 'reals_model.g.dart';

@JsonSerializable()
class ReelsModel {
  List<ReelModel>? data;

  ReelsModel({this.data});

  factory ReelsModel.fromJson(Map<String, dynamic> json) =>
      _$ReelsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReelsModelToJson(this);
}

@JsonSerializable()
class ReelModel implements SerializedObject {
  String? title;
  String? description;
  int? reelLikesCount;
  bool? likedByCurrentUser;
  String? videoUrl;
  String? id;
  ForgroundImage? thumbnailImage;
  String? presignedUrl;

  ReelModel({
    this.title,
    this.description,
    this.reelLikesCount,
    this.likedByCurrentUser,
    this.videoUrl,
    this.id,
    this.thumbnailImage,
    this.presignedUrl,
  });

  factory ReelModel.fromJson(Map<String, dynamic> json) =>
      _$ReelModelFromJson(json);
  factory ReelModel.dummy() => ReelModel(title: "Dummy");
  Map<String, dynamic> toJson() => _$ReelModelToJson(this);
}
