import 'show_type.dart';

class Show {

  Show({this.id, this.title, this.showType});

  factory Show.fromJson(Map<String, dynamic> json) => Show(
        id: json['id'] as String?,
        title: json['title'] as String?,
        showType: json['showType'] == null
            ? null
            : ShowType.fromJson(json['showType'] as Map<String, dynamic>),
      );
  String? id;
  String? title;
  ShowType? showType;
}
