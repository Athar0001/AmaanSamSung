import 'package:flutter/material.dart';

import '../../../core/utils/cash_services/cashe_helper.dart';
import '../../../core/utils/funcation.dart';
import '../../../core/widget/app_toast.dart';
import '../data/data_source/home_service.dart';

class TimeProvider with ChangeNotifier {

  TimeProvider({required this.homeService});
  final HomeService homeService;
  int _time = 0;
  int get time => _time;

  bool _isValidToContinue = true;
  bool get isValidToContinue {
    return CacheHelper.currentUser?.userType.isChild != true ||
        _isValidToContinue;
  }

  Map<String, String> _videoLogData = {}; // Stores videoId -> endTime
  Map<String, String> get videoLogData => _videoLogData;

  void continueWatching(String videoId, String? endTime) {
    _videoLogData[videoId] = endTime ?? '00:00:00';
  }

  Duration? allowedDuration;

  set isValidToContinue(bool value) {
    _isValidToContinue = value;
  }

  set time(int value) {
    _time = value;
  }

  void increment() {
    _time++;
  }

  void reset() {
    _time = 0;
  }

  void resetVideoLogDataAndTime() {
    _videoLogData = {};
    isValidToContinue = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> sendVideoLog() async {
    // if (CacheHelper.currentUser != null && time > 0) {
    //   // if (CacheHelper.currentUser!.userType.isChild) {
    //   final result = await homeService.videoLog(
    //     userId: CacheHelper.currentUser!.userId!,
    //     time: Duration(seconds: time).toString(),
    //   );
    //
    //   result.fold(
    //         (failure) => AppToast.show(failure.message),
    //         (data) {
    //       _isValidToContinue = data['logStatus'] == 1;
    //       allowedDuration = parseDuration(data['remainingTime']);
    //       reset();
    //     },
    //   );
    //   // }
    // }
  }

  Future<void> validateVideoTime() async {
    final currentUser = CacheHelper.currentUser;
    if (currentUser != null && currentUser.userType.isChild) {
      (await homeService.validateVideoTime(id: currentUser.userId!))
          .fold((failure) {}, (data) {
        isValidToContinue = data['data']['logStatus'] == 1;
        allowedDuration = parseDuration(data['data']['remainingTime']);
      });
    }
  }
}
