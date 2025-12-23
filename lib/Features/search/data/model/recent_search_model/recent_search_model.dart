class RecentSearchModel {
  RecentSearchModel({
    this.isSuccess,
    this.statusCode,
    this.data,
    this.pagination,
    this.error,
    this.errorMessage,
  });

  factory RecentSearchModel.fromJson(Map<String, dynamic> json) {
    return RecentSearchModel(
      isSuccess: json['isSuccess'] as bool?,
      statusCode: json['statusCode'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] as dynamic,
      error: json['error'] as dynamic,
      errorMessage: json['errorMessage'] as dynamic,
    );
  }
  bool? isSuccess;
  int? statusCode;
  List<Datum>? data;
  dynamic pagination;
  dynamic error;
  dynamic errorMessage;

  Map<String, dynamic> toJson() => {
    'isSuccess': isSuccess,
    'statusCode': statusCode,
    'data': data?.map((e) => e.toJson()).toList(),
    'pagination': pagination,
    'error': error,
    'errorMessage': errorMessage,
  };
}

class Datum {
  Datum({this.id, this.text});

  factory Datum.fromJson(Map<String, dynamic> json) =>
      Datum(id: json['id'] as String?, text: json['text'] as String?);
  String? id;
  String? text;

  Map<String, dynamic> toJson() => {'id': id, 'text': text};
}
