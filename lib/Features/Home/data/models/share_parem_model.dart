class ShareParamModel {

  ShareParamModel({required this.childId, required this.showId});
  final String childId;
  final String showId;

  Map<String, dynamic> toJson() => {
        'childId': childId,
        'showId': showId,
      };
}
