import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/core/services/signalr_service.dart';
import 'package:device_info_plus_tizen/device_info_plus_tizen.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../core/error/failure.dart';
import '../../../core/injection/injection_imports.dart' as di;
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
  String qrData = '';
  Duration expiryDuration = const Duration(minutes: 4);

  Future<void> generateQr(Function(AuthModel user) onAuthCompleted) async {
    state = AuthState.loading;
    notifyListeners();
    TizenDeviceInfo tizenInfo = Platform.isAndroid
        ? TizenDeviceInfo.fromMap({
            'modelName': 'Gamal Android Tv',
            'screenWidth': 1920,
            'screenHeight': 1080,
            'tizenId': '1234567890',
            'tizenVersion': '1.0.0'
          })
        : await deviceInfo.tizenInfo;
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
        expiryDuration = data.expiryDuration;
        di.sl<SignalRService>().init(data.sessionId!, (user) {
          userNotifier.login(user.authModel);
          onAuthCompleted(user);
        });
        qrData = jsonEncode(data.toJson());
        notifyListeners();
      },
    );
  }
}
