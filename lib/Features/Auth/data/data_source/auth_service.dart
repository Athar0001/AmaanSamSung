import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:amaan_tv/core/error/error_handler.dart';
import 'package:amaan_tv/core/error/failure.dart';
import 'package:amaan_tv/core/utils/api/api_service.dart';
import 'package:amaan_tv/core/utils/api/end_point.dart';

import '../../../../core/widget/app_toast.dart';
import '../models/login_model.dart';
import '../models/qr_model.dart';

class AuthService {
  AuthService(this.serverConstants);
  ApiService serverConstants;

  Future<Either<Failure, QrModel>> generateQr({
    required String modelName,
    required String uuid,
  }) async {
    try {
      final response = await serverConstants.makePostRequest(
        EndPoint.generateTvLoginQr,
        postValues: {
          'deviceName': modelName,
          'uuid': uuid,
        },
        withToken: false,
      );
      return Right(QrModel.fromJson(response.data['data']));
    } catch (error, st) {
      return Left(ErrorHandler.handle(error, st).failure);
    }
  }

  Future<UserData> refreshToken(String tokenRefresh) async {
    final response = await serverConstants.makePostRequest(
      '${EndPoint.baseUrl}/${EndPoint.refreshTokenURL}',
      postValues: {
        'token': tokenRefresh,
      },
    );
    if (serverConstants.isValidResponse(response.statusCode!)) {
      return UserData.fromJson(response.data['data']);
    } else {
      // AppToast.show("${response.data['errorMessage']}");
      AppToast.show(
        "${response.data['errorMessage']}",
        position: ToastPosition.center,
      );
      log('result.data: ${response.data['errorMessage']}');
      throw response.data['errorMessage'];
    }
  }
  Future<Either<Failure, bool>> logout() async {
    try {
      await serverConstants.makePostRequest(EndPoint.logout);
      return Right(true);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      if (error.failure.code == 401) {
        return Right(true);
      }
      return Left(error.failure);
    }
  }
}
