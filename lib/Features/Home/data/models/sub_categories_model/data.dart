import 'package:amaan_tv/Features/Home/data/models/home_categories_model/categories.dart';
import 'image.dart';

class SubCategories {

  SubCategories({
    this.id,
    this.name,
    this.description,
    this.image,
    this.backgroundImage,
    this.childCategories,
  });

  factory SubCategories.fromJson(Map<String, dynamic> json) => SubCategories(
        id: json['id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        image: json['image'] == null
            ? null
            : ForgroundImage.fromJson(json['image'] as Map<String, dynamic>),
        backgroundImage: json['backgroundImage'] == null
            ? null
            : ForgroundImage.fromJson(
                json['backgroundImage'] as Map<String, dynamic>),
        childCategories: (json['childCategories'] as List<dynamic>?)
            ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  String? id;
  String? name;
  String? description;
  ForgroundImage? image;
  ForgroundImage? backgroundImage;
  List<Category>? childCategories;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'image': image?.toJson(),
        'backgroundImage': backgroundImage?.toJson(),
        'childCategories': childCategories?.map((e) => e.toJson()).toList(),
      };
}
