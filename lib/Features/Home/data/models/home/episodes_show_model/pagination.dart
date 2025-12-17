class Pagination {

  Pagination({
    this.pageNumber,
    this.totalPages,
    this.totalCount,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        pageNumber: json['pageNumber'] as int?,
        totalPages: json['totalPages'] as int?,
        totalCount: json['totalCount'] as int?,
        hasPreviousPage: json['hasPreviousPage'] as bool?,
        hasNextPage: json['hasNextPage'] as bool?,
      );
  int? pageNumber;
  int? totalPages;
  int? totalCount;
  bool? hasPreviousPage;
  bool? hasNextPage;

  Map<String, dynamic> toJson() => {
        'pageNumber': pageNumber,
        'totalPages': totalPages,
        'totalCount': totalCount,
        'hasPreviousPage': hasPreviousPage,
        'hasNextPage': hasNextPage,
      };
}
