class Genre {

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json['id'] as String?,
        name: json['name'] as String?,
      );
  String? id;
  String? name;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
