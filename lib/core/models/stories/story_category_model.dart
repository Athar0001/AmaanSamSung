class StoryCategoryModel {

  StoryCategoryModel({
    required this.img,
    required this.title, this.unselectedImg,
    this.background,
    this.isLiked,
  });
  final String img;
  final String? background;
  final String? unselectedImg;
  final String title;
  bool? isLiked;
}
