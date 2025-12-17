class Category {

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
