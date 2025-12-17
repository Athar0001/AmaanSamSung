class ImageModel0 {

  ImageModel0({
    required this.id,
    required this.url, required this.presignedUrl, this.name = '',
    this.attachmentType,
  });

  factory ImageModel0.fromJson(json) => ImageModel0(
      id: json['id'],
      name: json['name'] ?? '',
      url: json['url'],
      presignedUrl: json['presignedUrl'],
      attachmentType: json['attachmentType'] != null
          ? AttachmentType.fromJson(json['attachmentType'])
          : null);
  final String id;
  final String name;
  final String url;
  final String? presignedUrl;
  final AttachmentType? attachmentType;

  ImageModel0 copyWith({
    String? id,
    String? name,
    String? url,
    String? presignedUrl,
    AttachmentType? attachmentType,
  }) =>
      ImageModel0(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
        presignedUrl: presignedUrl ?? this.presignedUrl,
        attachmentType: attachmentType ?? this.attachmentType,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['url'] = url;
    map['presignedUrl'] = presignedUrl;
    if (attachmentType != null) {
      map['attachmentType'] = attachmentType?.toJson();
    }
    return map;
  }
}

/// id : "dbf32d5e-a59f-4198-96ec-e4baf7a297c0"
/// name : "test test tes  fares"
/// isActive : true
/// translations : [{"language":"en","name":"test test tes  fares"},{"language":"ar","name":"تيست"}]

class AttachmentType {

  const AttachmentType({
    required this.id,
    required this.name,
    required this.isActive,
    required this.translations,
  });

  factory AttachmentType.fromJson(json) => AttachmentType(
        id: json['id'],
        name: json['name'],
        isActive: json['isActive'],
        translations: json['translations'] != null
            ? (json['translations'] as List)
                .map(Translations.fromJson)
                .toList()
            : null,
      );
  final String id;
  final String name;
  final bool isActive;
  final List<Translations>? translations;

  AttachmentType copyWith({
    String? id,
    String? name,
    bool? isActive,
    List<Translations>? translations,
  }) =>
      AttachmentType(
        id: id ?? this.id,
        name: name ?? this.name,
        isActive: isActive ?? this.isActive,
        translations: translations ?? this.translations,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['isActive'] = isActive;
    if (translations != null && translations!.isNotEmpty) {
      map['translations'] = translations?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// language : "en"
/// name : "test test tes  fares"

class Translations {
  Translations({
    String? language,
    String? name,
  }) {
    _language = language;
    _name = name;
  }

  Translations.fromJson(json) {
    _language = json['language'];
    _name = json['name'];
  }

  String? _language;
  String? _name;

  Translations copyWith({
    String? language,
    String? name,
  }) =>
      Translations(
        language: language ?? _language,
        name: name ?? _name,
      );

  String? get language => _language;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['language'] = _language;
    map['name'] = _name;
    return map;
  }
}
