class Seasons {

  Seasons({
    this.id,
    this.title,
    this.description,
    this.totalShows,
    this.originDate,
  });

  factory Seasons.fromJson(Map<String, dynamic> json) => Seasons(
        id: json['id'] as String?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        totalShows: json['totalShows'] as int?,
        originDate: json['originDate'] as String?,
      );
  String? id;
  String? title;
  String? description;
  int? totalShows;
  String? originDate;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'totalShows': totalShows,
        'originDate': originDate,
      };
}
