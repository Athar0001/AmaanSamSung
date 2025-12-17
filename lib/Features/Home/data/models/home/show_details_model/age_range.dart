class AgeRange {

  AgeRange({
    this.id,
    this.name,
    this.min,
    this.max,
    this.isActive,
  });

  factory AgeRange.fromJson(Map<String, dynamic> json) => AgeRange(
        id: json['id'] as String?,
        name: json['name'] as String?,
        min: json['min'] as int?,
        max: json['max'] as int?,
        isActive: json['isActive'] as bool?,
      );
  String? id;
  String? name;
  int? min;
  int? max;
  bool? isActive;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'min': min,
        'max': max,
        'isActive': isActive,
      };
}
