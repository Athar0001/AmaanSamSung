import 'dart:convert';

class VideoTransactionModel {

  VideoTransactionModel({
    required this.videoTransactionType,
    required this.userId,
    required this.showId,
    this.episodeId,
    this.videoId,
    this.fromMinute,
  });
  VideoTransactionType videoTransactionType;
  String userId;
  String showId;
  String? episodeId;
  String? videoId;
  String? fromMinute;

  // Method to convert the model instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'VideoTransactionTypeId': videoTransactionType.id.toString(),
      'UserId': userId.toString(),
      'ShowId': showId.toString(),
      if (episodeId != null) 'EpisodeId': episodeId.toString(),
      'VideoId': videoId.toString(),
      'FromMinute': fromMinute.toString(),
    };
  }

  // Optional: To get a JSON string from the model
  String toJsonString() => json.encode(toJson());
}

enum VideoTransactionType {
  playVideo(1),
  stopVideo(2),
  completeVideo(3),
  forwardVideo(4),
  backwardVideo(5),
  changeSpeedVideo(6),
  closePage(7);

  final int id;

  const VideoTransactionType(this.id);
}
