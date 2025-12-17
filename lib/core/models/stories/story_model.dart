import 'package:amaan_tv/core/models/stories/story_category_model.dart';

class StoryModel {

  StoryModel({
    required this.img,
    required this.title,
    this.description,
    this.age,
    this.categories,
    this.duration,
    this.isLiked,
    this.chapters,
    this.heroes,
  });
  final String img;
  final String title;
  String? description;
  String? age;
  List<String>? categories;
  int? duration;
  bool? isLiked;
  List<StoryCategoryModel>? heroes;
  List<StoryCategoryModel>? chapters;
}
