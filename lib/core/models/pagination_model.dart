class PaginationModel {
  PaginationModel({
    required this.pageNumber,
    required this.totalPages,
    required this.totalCount,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory PaginationModel.fromJson(json) => PaginationModel(
        pageNumber: (json['pageNumber'] as num).toInt(),
        totalPages: (json['totalPages'] as num).toInt(),
        totalCount: (json['totalCount'] as num).toInt(),
        hasPreviousPage: json['hasPreviousPage'],
        hasNextPage: json['hasNextPage'],
      );
  final int pageNumber;
  final int totalPages;
  final int totalCount;
  final bool hasPreviousPage;
  final bool hasNextPage;

  PaginationModel copyWith({
    int? pageNumber,
    int? totalPages,
    int? totalCount,
    bool? hasPreviousPage,
    bool? hasNextPage,
  }) =>
      PaginationModel(
        pageNumber: pageNumber ?? this.pageNumber,
        totalPages: totalPages ?? this.totalPages,
        totalCount: totalCount ?? this.totalCount,
        hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
        hasNextPage: hasNextPage ?? this.hasNextPage,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pageNumber'] = pageNumber;
    map['totalPages'] = totalPages;
    map['totalCount'] = totalCount;
    map['hasPreviousPage'] = hasPreviousPage;
    map['hasNextPage'] = hasNextPage;
    return map;
  }
}
