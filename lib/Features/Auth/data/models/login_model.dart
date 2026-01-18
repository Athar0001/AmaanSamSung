import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/utils/cash_services/cashe_helper.dart';

enum UserType {
  parent('1'),
  child('2');

  final String id;

  const UserType(this.id);

  factory UserType.fromId(String id) => UserType.values.firstWhere(
        (element) => element.id == id,
    orElse: () => UserType.parent,
  );

  bool get isParent => this == UserType.parent;

  bool get isChild => this == UserType.child;
}

enum Gender {
  male('1'),
  female('2');

  final String id;

  const Gender(this.id);

  factory Gender.fromId(String id) => Gender.values.firstWhere(
        (element) => element.id == id,
    orElse: () => Gender.male,
  );

  bool get isMale => this == Gender.male;

  bool get isFemale => this == Gender.female;
}

class UserData extends Equatable {
  UserData({
    this.userId,
    this.username,
    this.name,
    this.token,
    this.userType = UserType.parent,
    this.gender,
    this.expiresOn,
    this.refreshToken,
    this.roles,
    this.countryCode,
    this.phoneNumber = '',
  });

  factory UserData.fromString(String str) =>
      UserData.fromJson(json.decode(str));

  factory UserData.fromJson(Map<String, dynamic> json) {
    if (json['token'] != null) {
      CacheHelper.saveData(key: 'token', value: json['token']);
    }
    if (json['userId'] != null) {
      CacheHelper.saveData(key: 'userId', value: json['userId']);
    }
    if (json['userTypeId'] != null) {
      CacheHelper.saveData(key: 'userTypeId', value: json['userTypeId']);
    }
    if (json['genderId'] != null) {
      CacheHelper.saveData(key: 'genderId', value: json['genderId']);
    }
    if (json['countryCode'] != null) {
      CacheHelper.saveData(key: 'countryCode', value: json['countryCode']);
    }
    return UserData(
      userId: json['userId'],
      username: json['username'],
      name: json['name'],
      userType: json['userTypeId'] == null
          ? UserType.parent
          : UserType.fromId(json['userTypeId'].toString()),
      gender: json['genderId'] == null
          ? null
          : Gender.fromId(json['genderId'].toString()),
      token: json['token'],
      expiresOn: json['expiresOn'] == null
          ? null
          : DateTime.parse(json['expiresOn']),
      refreshToken: json['refreshToken'],
      phoneNumber: json['phoneNumber'] ?? '',
      roles: json['roles'] == null
          ? []
          : List<Roles>.from(json['roles']!.map((x) => Roles.fromJson(x))),
    );
  }

  final String? userId;
  final String? username;
  final String? name;
  final UserType userType;
  final Gender? gender;
  final String? token;
  final String? countryCode;
  final DateTime? expiresOn;
  final String? refreshToken;
  final String phoneNumber;
  final List<Roles>? roles;

  bool get hasPhone => phoneNumber.trim().isNotEmpty;

  @override
  String toString() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'username': username,
    'userTypeId': userType.id,
    'genderId': gender?.id,
    'name': name,
    'token': token,
    'expiresOn': expiresOn?.toIso8601String(),
    'refreshToken': refreshToken,
    'roles': roles?.map((role) => role.toJson()).toList(),
    'countryCode': countryCode,
    'phoneNumber': phoneNumber,
  };

  @override
  List<Object?> get props => [
    userId,
    username,
    name,
    userType,
    gender,
    token,
    expiresOn,
    refreshToken,
    roles,
    countryCode,
    phoneNumber,
  ];

  UserData copyWith({
    String? userId,
    String? username,
    String? name,
    UserType? userType,
    Gender? gender,
    String? token,
    String? countryCode,
    DateTime? expiresOn,
    String? refreshToken,
    String? phoneNumber,
    List<Roles>? roles,
  }) {
    return UserData(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      name: name ?? this.name,
      userType: userType ?? this.userType,
      gender: gender ?? this.gender,
      token: token ?? this.token,
      countryCode: countryCode ?? this.countryCode,
      expiresOn: expiresOn ?? this.expiresOn,
      refreshToken: refreshToken ?? this.refreshToken,
      roles: roles ?? this.roles,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

class Roles extends Equatable {
  const Roles({this.id, this.name});

  factory Roles.fromJson(Map<String, dynamic> json) {
    return Roles(id: json['id'], name: json['name']);
  }

  final String? id;
  final String? name;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  List<Object?> get props => [id, name];
}
