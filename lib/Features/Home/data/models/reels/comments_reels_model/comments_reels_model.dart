import 'user.dart';

class CommentsReelsModel {

  CommentsReelsModel({
    this.id,
    this.userId,
    this.isLiked = false,
    this.comment,
    this.user,
  });

  factory CommentsReelsModel.fromJson(Map<String, dynamic> json) {
    return CommentsReelsModel(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      comment: json['comment'] as String?,
      isLiked: json['isLikedByCurrentUser'] as bool,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
  String? id;
  String? userId;
  bool isLiked = false;
  String? comment;
  User? user;
}
