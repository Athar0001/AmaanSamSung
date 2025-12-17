// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reals_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReelsModel _$ReelsModelFromJson(Map<String, dynamic> json) => ReelsModel(
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => ReelModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ReelsModelToJson(ReelsModel instance) =>
    <String, dynamic>{'data': instance.data};

ReelModel _$ReelModelFromJson(Map<String, dynamic> json) => ReelModel(
  title: json['title'] as String?,
  description: json['description'] as String?,
  reelLikesCount: (json['reelLikesCount'] as num?)?.toInt(),
  likedByCurrentUser: json['likedByCurrentUser'] as bool?,
  videoUrl: json['videoUrl'] as String?,
  id: json['id'] as String?,
  thumbnailImage: json['thumbnailImage'] == null
      ? null
      : ForgroundImage.fromJson(json['thumbnailImage'] as Map<String, dynamic>),
  presignedUrl: json['presignedUrl'] as String?,
);

Map<String, dynamic> _$ReelModelToJson(ReelModel instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'reelLikesCount': instance.reelLikesCount,
  'likedByCurrentUser': instance.likedByCurrentUser,
  'videoUrl': instance.videoUrl,
  'id': instance.id,
  'thumbnailImage': instance.thumbnailImage,
  'presignedUrl': instance.presignedUrl,
};
