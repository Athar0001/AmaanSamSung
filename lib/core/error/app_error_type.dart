import 'package:amaan_tv/core/error/failure.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';

enum AppErrorType {
  NO_INTERNET_CONNECTION(ResponseCode.NO_INTERNET_CONNECTION),
  DEFAULT(ResponseCode.DEFAULT),
  ;

  final int code;

  String get message {
    switch (this) {
      case AppErrorType.NO_INTERNET_CONNECTION:
        return ResponseMessage.NO_INTERNET_CONNECTION;
      case AppErrorType.DEFAULT:
        return ResponseMessage.DEFAULT;
    }
  }

  Failure getFailure() => Failure(message: message, code: code);

  const AppErrorType(this.code);
}

class ResponseCode {
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static String get NO_INTERNET_CONNECTION =>
      AppLocalization.strings.checkInternetConnection;

  static String get DEFAULT => AppLocalization.strings.errorHappenedTryAgain;
}
