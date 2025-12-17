import 'package:amaan_tv/core/models/serialized_object.dart';
import 'package:amaan_tv/core/utils/api/end_point.dart';

class ForgroundImage extends SerializedObject {
  ForgroundImage({this.name, String? url, this.presignedUrl})
    : url = getUrl(url);

  factory ForgroundImage.fromJson(Map<String, dynamic> json) => ForgroundImage(
    name: json['name'] as String?,
    url: json['url'] as String?,
    presignedUrl: json['presignedUrl'] as String?,
  );
  String? name;
  String? url;
  String? presignedUrl;

  static String? getUrl(String? url) =>
      (url is String && url.trim().isNotEmpty)
      ? EndPoint.baseImageUrl + url
      : null;

  Map<String, dynamic> toJson() => {
    'name': name,
    'url': url,
    'presignedUrl': presignedUrl,
  };
}
