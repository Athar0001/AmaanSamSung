class ShowVideo {

  ShowVideo(
      {this.id, this.title, this.description, this.videoId, this.videoTypeId ,
        this.closingDuration});

  factory ShowVideo.fromJson(Map<String, dynamic> json) => ShowVideo(
        id: json['id'] as String?,
        videoId: json['videoId'] as String?,
        title: json['title'] as dynamic,
        description: json['description'] as dynamic,
        videoTypeId: json['videoTypeId'] as String?,
    closingDuration: int.tryParse(json['closingDuration'].toString()),
      );
  String? id;
  String? videoId;
  dynamic title;
  dynamic description;
  String? videoTypeId;
  int? closingDuration;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'videoTypeId': videoTypeId,
    'closingDuration': closingDuration,
      };
}
