import 'package:equatable/equatable.dart';

enum ErrorCode {
  emailOrPhoneNotVerified('EmailOrPhoneNotVerified'),
  unKnown('Unknown'),
  ;

  bool get isEmailOrPhoneNotVerified =>
      this == ErrorCode.emailOrPhoneNotVerified;

  bool get isUnknown => this == ErrorCode.unKnown;

  final String code;

  const ErrorCode(this.code);

  factory ErrorCode.fromData(data) {
    if (data is Map && data['error'] is Map && data['error']['code'] != null) {
      return ErrorCode.values.firstWhere(
        (element) => element.code == data['error']['code'],
        orElse: () => ErrorCode.unKnown,
      );
    }
    return ErrorCode.unKnown;
  }
}

/// Failure is a class that has a code and a message.
class Failure extends Equatable {

  const Failure({
    required this.code,
    required this.message,
    this.errorCode,
  });
  final int? code;
  final String message;
  final ErrorCode? errorCode;

  @override
  List<Object?> get props => [code, message, errorCode];
}
