import 'package:amaan_tv/core/utils/app_router.dart';
import 'package:amaan_tv/flavors.dart';
import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/image.dart';

enum ModuleType {
  show('1'),
  radio('2'),
  stories('3');

  final String id;

  const ModuleType(this.id);

  factory ModuleType.fromId(String id) => ModuleType.values.firstWhere(
    (element) => element.id == id,
    orElse: () => ModuleType.show,
  );

  bool get isShow => this == ModuleType.show;

  bool get isRadio => this == ModuleType.radio;

  bool get isStories => this == ModuleType.stories;

  bool get isActive {
    switch (this) {
      case ModuleType.show:
        return true;
      case ModuleType.radio:
        return AppFlavor.flavor.showInProd;
      case ModuleType.stories:
        return false;
    }
  }

  String screen(Category category) {
    switch (this) {
      case ModuleType.show:
        return AppRoutes.categories.routeName;
      case ModuleType.radio:
        return isActive
            ? AppRoutes.radio.routeName
            : AppRoutes.soonRadio.routeName;
      case ModuleType.stories:
        return AppRoutes.soonStories.routeName;
    }
  }
}

class Category {
  Category({
    this.id,
    this.name,
    this.description,
    this.moduleType = ModuleType.show,
    this.image,
    this.backgroundImage,
    this.containsShow = false,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    final image = json['image'] ?? json['foregroundImage'];
    return Category(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      moduleType: json['id'] == null
          ? ModuleType.show
          : ModuleType.fromId(json['id'].toString()),
      image: image == null
          ? null
          : ForgroundImage.fromJson(image as Map<String, dynamic>),
      backgroundImage: json['backgroundImage'] == null
          ? null
          : ForgroundImage.fromJson(
              json['backgroundImage'] as Map<String, dynamic>,
            ),
      containsShow: json['containsShow'] ?? false,
    );
  }
  String? id;
  String? name;
  String? description;
  ModuleType moduleType;
  ForgroundImage? image;
  ForgroundImage? backgroundImage;
  bool containsShow;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'image': image?.toJson(),
    'backgroundImage': backgroundImage?.toJson(),
    'containsShow': containsShow,
  };
}
