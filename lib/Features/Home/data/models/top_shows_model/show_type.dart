class ShowType {

  ShowType({this.id, this.name});

  factory ShowType.fromJson(Map<String, dynamic> json) => ShowType(
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
