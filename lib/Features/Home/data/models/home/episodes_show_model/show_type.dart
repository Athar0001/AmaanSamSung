class ShowType {

  ShowType({
    this.id,
    this.name,
    this.isActive,
  });

  factory ShowType.fromJson(Map<String, dynamic> json) => ShowType(
        id: json['id'] as String?,
        name: json['name'] as String?,
        isActive: json['isActive'] as bool?,
      );
  String? id;
  String? name;
  bool? isActive;
}
