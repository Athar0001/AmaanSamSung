class Exam {
  Exam({
    this.id,
    this.name,
    this.showId,
    this.episodeId,
    this.noQuestions,
    this.examType,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
        id: json['id'] as String?,
        name: json['name'] as String?,
        showId: json['showId'] as String?,
        episodeId: json['episodeId'] as dynamic,
        noQuestions: json['noQuestions'] as int?,
        examType: json['examType'] as int?,
      );
  String? id;
  String? name;
  String? showId;
  dynamic episodeId;
  int? noQuestions;
  int? examType;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'showId': showId,
        'episodeId': episodeId,
        'noQuestions': noQuestions,
        'examType': examType,
      };
}
