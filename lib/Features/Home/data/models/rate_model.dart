import 'package:amaan_tv/core/models/serialized_object.dart';

/// rate : 0
/// comment : "string"
/// showId : "string"
/// userId : "string"

/// id : "string"
/// rate : 0
/// comment : "string"
/// showId : "string"
/// userId : "string"

class RateModel extends SerializedObject {

  RateModel({
    this.id,
    this.rate,
    this.comment,
    this.showId,
    this.userId,
  });

  RateModel.fromJson(json) {
    id = json['id'];
    rate = json['rate'];
    comment = json['comment'];
    showId = json['showId'];
    userId = json['userId'];
  }
  String? id;
  int? rate;
  String? comment;
  String? showId;
  String? userId;

  RateModel copyWith({
    String? id,
    int? rate,
    String? comment,
    String? showId,
    String? userId,
  }) =>
      RateModel(
        id: id ?? this.id,
        rate: rate ?? this.rate,
        comment: comment ?? this.comment,
        showId: showId ?? this.showId,
        userId: userId ?? this.userId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['rate'] = rate;
    map['comment'] = comment;
    map['showId'] = showId;
    map['userId'] = userId;
    return map;
  }
}
