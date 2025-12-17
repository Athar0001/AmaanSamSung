class EpisodesModel {

  EpisodesModel({
    required this.image,
    required this.title,
    required this.isLocked,
    required this.isLiked,
    this.categories,
  });
  final String image;
  final String title;
  final List<String>? categories;
  final bool isLocked;
  bool isLiked;
}
