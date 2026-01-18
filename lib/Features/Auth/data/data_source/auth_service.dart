import 'package:dartz/dartz.dart';
import 'package:amaan_tv/core/error/error_handler.dart';
import 'package:amaan_tv/core/error/failure.dart';
import 'package:amaan_tv/core/utils/api/api_service.dart';
import 'package:amaan_tv/core/utils/api/end_point.dart';

class AuthService {
  AuthService(this.serverConstants);
  ApiService serverConstants;

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
