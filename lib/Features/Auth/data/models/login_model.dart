class LoginModel {
  bool? status;
  String? message;
  UserData? data;
  String? token;

  LoginModel({this.status, this.message, this.data, this.token});
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;
  UserType userType;

  UserData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.token,
    this.userType = const UserType(),
  });

  String get userId => id.toString();
}

class UserType {
  final bool isParent;
  const UserType({this.isParent = true});
  bool get isChild => !isParent;

  static const parent = UserType(isParent: true);
  static const child = UserType(isParent: false);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserType &&
          runtimeType == other.runtimeType &&
          isParent == other.isParent;

  @override
  int get hashCode => isParent.hashCode;
}
