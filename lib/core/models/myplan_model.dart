import 'dart:convert';

class MyPlanModel {

  MyPlanModel({
    this.isSuccess,
    this.statusCode,
    this.data,
    this.pagination,
    this.error,
    this.errorMessage,
  });

  factory MyPlanModel.fromRawJson(String str) =>
      MyPlanModel.fromJson(json.decode(str));

  factory MyPlanModel.fromJson(Map<String, dynamic> json) => MyPlanModel(
        isSuccess: json['isSuccess'],
        statusCode: json['statusCode'],
        data: json['data'] == null ? null : PlanData.fromJson(json['data']),
        pagination: json['pagination'],
        error: json['error'],
        errorMessage: json['errorMessage'],
      );
  final bool? isSuccess;
  final int? statusCode;
  final PlanData? data;
  final dynamic pagination;
  final dynamic error;
  final dynamic errorMessage;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'isSuccess': isSuccess,
        'statusCode': statusCode,
        'data': data?.toJson(),
        'pagination': pagination,
        'error': error,
        'errorMessage': errorMessage,
      };
}

enum RenewStatus {
  CANCELED('CANCELED'),
  ACTIVE('ACTIVE'),
  EXPIRED('EXPIRED'),
  PENDING('PENDING'),
  FAILED('FAILED'),
  FREE('FREE');

  final String id;

  const RenewStatus(this.id);
  factory RenewStatus.fromId(String id) => RenewStatus.values.firstWhere(
        (element) => element.id == id,
        orElse: () => RenewStatus.ACTIVE,
      );
  bool get isCanceled => this == CANCELED;
  bool get isActive => this == ACTIVE;
  bool get isExpired => this == EXPIRED;
  bool get isPending => this == PENDING;
  bool get isFailed => this == FAILED;
  bool get isFree => this == FREE;
}

class PlanData {

  PlanData({
    this.id,
    this.userId,
    this.planId,
    this.planPriceId,
    this.durationId,
    this.planTitle,
    this.noOfParents,
    this.currentNoOfParents,
    this.noOfChildren,
    this.currentNoOfChildren,
    this.subscriptionStatusId,
    this.startAt,
    this.endAt,
    this.price,
    this.noOfAllowedDevices,
    this.recurringId,
    this.cancelRenewAt,
    this.renewStatus,
    this.renewedAt,
  });

  factory PlanData.fromRawJson(String str) =>
      PlanData.fromJson(json.decode(str));

  factory PlanData.fromJson(Map<String, dynamic> json) => PlanData(
        id: json['id'],
        userId: json['userId'],
        planId: json['planId'],
        planPriceId: json['planPriceId'],
        durationId: json['durationTypeId'],
        planTitle: json['planTitle'].toString(),
        noOfParents: json['noOfParents'].toString(),
        currentNoOfParents: json['currentNoOfParents']?.toString(),
        noOfChildren: json['noOfChildren'].toString(),
        currentNoOfChildren: json['currentNoOfChildren']?.toString(),
        subscriptionStatusId: json['subscriptionStatusId'].toString(),
        startAt:
            json['startAt'] == null ? null : DateTime.parse(json['startAt']),
        endAt: json['endAt'] == null ? null : DateTime.parse(json['endAt']),
        price: json['price'] == null
            ? null
            : (json['price'] is num
                ? (json['price'] as num).toDouble()
                : double.tryParse(json['price'].toString())),
        noOfAllowedDevices: json['noOfAllowedDevices'] == null
            ? null
            : int.tryParse(json['noOfAllowedDevices'].toString()),
        recurringId: json['recurringId'],
        cancelRenewAt: json['cancelRenewAt'] == null
            ? null
            : DateTime.parse(json['cancelRenewAt']),
        renewStatus: json['renewStatus'] == null
            ? RenewStatus.ACTIVE
            : RenewStatus.fromId(json['renewStatus'].toString()),
        renewedAt: json['renewedAt'] == null
            ? null
            : DateTime.parse(json['renewedAt']),
      );
  final String? id;
  final String? userId;
  final String? planId;
  final String? planPriceId;
  final String? durationId;
  final String? planTitle;
  final String? noOfParents;
  final String? currentNoOfParents;
  final String? noOfChildren;
  final String? currentNoOfChildren;
  final String? subscriptionStatusId;
  final DateTime? startAt;
  final DateTime? endAt;
  final double? price;
  final int? noOfAllowedDevices;
  final String? recurringId;
  final DateTime? cancelRenewAt;
  final RenewStatus? renewStatus;
  final DateTime? renewedAt;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'planId': planId,
        'planPriceId': planPriceId,
        'durationTypeId': durationId,
        'planTitle': planTitle,
        'noOfParents': noOfParents,
        'currentNoOfParents': currentNoOfParents,
        'noOfChildren': noOfChildren,
        'currentNoOfChildren': currentNoOfChildren,
        'subscriptionStatusId': subscriptionStatusId,
        'startAt': startAt?.toIso8601String(),
        'endAt': endAt?.toIso8601String(),
        'price': price,
        'noOfAllowedDevices': noOfAllowedDevices,
        'recurringId': recurringId,
        'cancelRenewAt': cancelRenewAt?.toIso8601String(),
        'renewStatus': renewStatus,
        'renewedAt': renewedAt?.toIso8601String(),
      };
}
