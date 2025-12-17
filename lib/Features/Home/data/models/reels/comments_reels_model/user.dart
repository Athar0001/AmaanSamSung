import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/image.dart';

class User {

  User({this.fullName, this.profilePicture});

  factory User.fromJson(Map<String, dynamic> json) => User(
        fullName: json['fullName'] as String?,
        profilePicture: json['profilePicture'] == null
            ? null
            : ForgroundImage.fromJson(
                {'id': null, 'name': null, 'url': json['profilePicture']}),
      );
  String? fullName;
  ForgroundImage? profilePicture;
}
