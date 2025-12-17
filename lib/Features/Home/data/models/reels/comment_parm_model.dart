import 'package:dio/dio.dart';

class CommentParmModel {

  CommentParmModel({this.comment, this.reelId});
  String? comment;
  String? reelId;

  FormData toJson() => FormData.fromMap({'Comment': comment, 'ReelId': reelId});
}
