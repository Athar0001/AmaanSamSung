import 'dart:async';
import 'dart:io';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/core/services/signalr_service.dart';
import 'package:device_info_plus_tizen/device_info_plus_tizen.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../core/error/failure.dart';
import '../data/models/login_model.dart';
import '../data/data_source/auth_service.dart';
import '../../../core/widget/app_toast.dart';

enum AuthState {
  inite,
  loading,
  success,
  error,
  emailOrPhoneNotVerified,
  phoneMissed,
}

enum AuthStateTwo { inite, loading, success, error }

class AuthProvider extends ChangeNotifier {
  AuthProvider(this.authService, this.userNotifier);
  final AuthService authService;
  final UserNotifier userNotifier;
  AuthState state = AuthState.inite;
  DeviceInfoPluginTizen deviceInfo = DeviceInfoPluginTizen();
  var uuid = Uuid();

  Future<void> generateQr() async {
    state = AuthState.loading;
    notifyListeners();
    TizenDeviceInfo tizenInfo = await deviceInfo.tizenInfo;
    String modelName = tizenInfo.modelName ?? '';
    (await authService.generateQr(modelName: modelName, uuid: uuid.v4())).fold(
      (failure) {
        state = AuthState.error;
        AppToast.show(failure.message);
        notifyListeners();
      },
      (data) {
        // userNotifier.login(data);
        state = AuthState.success;
        notifyListeners();
      },
    );
  }
}
