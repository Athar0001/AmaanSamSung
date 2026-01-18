import 'dart:async';
import 'dart:developer';
import 'package:amaan_tv/Features/Home/provider/time_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_provider/flutter_state_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../core/Themes/app_colors_new.dart';
import '../../../core/error/failure.dart';
import '../../../core/utils/app_localiztion.dart';
import '../../../core/utils/app_navigation.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/cash_services/cashe_helper.dart';
import '../../../core/utils/enum.dart';
import '../../../core/utils/funcation.dart';
import '../../../core/widget/app_toast.dart';
import '../data/data_source/home_service.dart';
import '../data/models/home/show_details_model/data.dart';
import '../data/models/rate_model.dart';
import '../data/models/video_transaction_model.dart';
import '../presentation/widget/rate_dialog.dart';
import '../presentation/widget/time_finished_popup.dart';
import 'home_provider.dart';

class ShowPlayerProvider extends ChangeNotifier {
  ShowPlayerProvider({required this.homeService});
  final HomeService homeService;

  // Change to standard VideoPlayerController
  VideoPlayerController? videoPlayerController;

  late String showId;
  String? episodeId;
  bool addQuiz = false;
  late String videoId;
  late String showTitle;
  List<Details>? episodes;
  String? userId;
  Duration? startFrom;
  bool isTransactionCompleted = false;
  bool showRate = true;
  bool _isActuallyPlaying = false;
  bool isFinished = false;
  bool _hasTriggeredClosingDuration = false;
  int repeatCounter = 1;
  int? trailerDuration;
  int? closingDuration;
  bool get isPlaying => videoPlayerController?.value.isPlaying ?? false;
  final timeProvider = appNavigatorKey.currentContext!.read<TimeProvider>();
  Timer? _timer;

  @override
  void dispose() {
    _stopTimer();
    videoPlayerController?.removeListener(_videoListener);
    videoPlayerController?.dispose();
    super.dispose();
  }

  Future<void> initializeVideo({
    required String url,
    required BuildContext context,
    required String showId,
    required String videoId,
    required String showTitle,
    required bool addQuiz,
    required bool showRate,
    List<Details>? episodesModel,
    String? fromMinute,
    String? episodeId,
    int? trailerDuration,
    int? closingDuration,
    int? repeatTimes,
  }) async {
    _hasTriggeredClosingDuration = false;
    isFinished = false;

    this.showTitle = showTitle;
    this.showId = showId;
    this.videoId = videoId;
    this.episodeId = episodeId;
    this.addQuiz = addQuiz;
    this.episodes = episodesModel;
    this.showRate = showRate;
    this.trailerDuration = trailerDuration;
    this.closingDuration = closingDuration;
    userId = CacheHelper.currentUser?.userId;

    getReview();

    if (fromMinute != null) {
      startFrom = parseDuration(fromMinute);
    } else {
      if (timeProvider.videoLogData[videoId] != null) {
        startFrom = parseDuration(timeProvider.videoLogData[videoId]!);
      }
    }

    if (repeatTimes != null) {
      setRepeatCounter(repeatTimes.toString());
    }

    await _setupTizenPlayer(url);
  }

  void setRepeatCounter(String value) {
    repeatCounter = int.parse(value);
    notifyListeners();
  }

  Future<void> _setupTizenPlayer(String url) async {
    print(url);
    print("urlurlurl");
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(url),
      httpHeaders: {
        'User-Agent': 'Aman/1.0',
      },
    );

    await videoPlayerController!.initialize();
    print("urlurlurl111");
    // MUST play first on Tizen
    videoPlayerController!.play();
    print("urlurlurl222");
    // Seek AFTER playback starts
    if (startFrom != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        videoPlayerController?.seekTo(startFrom!);
      });
    }
    print("urlurlurl333");
    videoPlayerController!.addListener(_videoListener);
    notifyListeners();
  }

  void _videoListener() {
    final value = videoPlayerController!.value;

    // Handle Playback Status for Timer
    if (value.isPlaying) {
      print("urlurlurl444");
      _handlePlayEvent();
    } else {
      print("urlurlurl5555");
      _stopTimer();
    }

    // Handle Completion and Closing Duration logic
    _handleLogicWithState(value);

    // Handle Errors
    if (value.hasError) {
      _stopTimer();
      timeProvider.sendVideoLog();
      log("Video Error: ${value.errorDescription}");
    }
  }

  void _handleLogicWithState(VideoPlayerValue value) {
    // 1. Check for Video Finished
    final isFinishedNow =
        value.position >= value.duration && value.duration != Duration.zero;

    // 2. Check for Closing Duration (Credit roll logic)
    bool isClosingRegion = false;
    if (repeatCounter == 1 &&
        !_hasTriggeredClosingDuration &&
        closingDuration != null) {
      final remaining = value.duration - value.position;
      if (remaining.inSeconds <= closingDuration! &&
          value.position > Duration.zero) {
        isClosingRegion = true;
      }
    }

    if ((isFinishedNow || isClosingRegion) && !isFinished) {
      _triggerCompletion();
    }
  }

  void _triggerCompletion() {
    isFinished = true;
    _hasTriggeredClosingDuration = true;

    if (repeatCounter == 1) {
      timeProvider.sendVideoLog();
      sendVideoTransaction(VideoTransactionType.completeVideo);
      _handlePostCompletionActions(appNavigatorKey.currentContext!);
    } else {
      repeat();
    }
  }

  // --- Playback/Timer Logic (Modified to fit video_player) ---

  void _handlePlayEvent() {
    if (!_isActuallyPlaying && !(_timer?.isActive ?? false)) {
      _isActuallyPlaying = true;
      _startTimer();
    }
  }

  void _startTimer() {
    _stopTimer();
    var hasSentLog = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (videoPlayerController == null ||
          !videoPlayerController!.value.isPlaying) {
        _stopTimer();
        return;
      }

      if (timeProvider.time >= 60 && !hasSentLog) {
        hasSentLog = true;
        timeProvider.sendVideoLog().then((_) => hasSentLog = false);
      }

      timeProvider.increment();
      _checkTimeLimit();
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    _isActuallyPlaying = false;
  }

  Future<void> _checkTimeLimit() async {
    if (timeProvider.time >=
            (timeProvider.allowedDuration?.inSeconds ?? 86400) ||
        !timeProvider.isValidToContinue) {
      _stopTimer();
      videoPlayerController?.pause();
      await showTimeFinishedPopup();
    }
  }

  void repeat() {
    _hasTriggeredClosingDuration = false;
    isFinished = false;
    // videoPlayerController?.seekTo(Duration.zero);
    videoPlayerController?.play();
    if (repeatCounter > 1) repeatCounter--;
    notifyListeners();
  }

  void play() {
    videoPlayerController?.play();
    notifyListeners();
  }

  void pause() {
    videoPlayerController?.pause();
    notifyListeners();
  }

  void togglePlay() {
    if (videoPlayerController?.value.isPlaying ?? false) {
      pause();
    } else {
      play();
    }
  }

  void seekForward({int seconds = 10}) {
    final controller = videoPlayerController;
    if (controller == null) return;

    final currentPosition = controller.value.position;
    final duration = controller.value.duration;

    // If duration is unknown, we can't safely seek near the end, but we can try blindly
    // Typically better to check, but let's just add and clamp if duration is known.

    var newPosition = currentPosition + Duration(seconds: seconds);
    if (newPosition > duration) {
      newPosition = duration;
    }

    controller.seekTo(newPosition);
  }

  void seekBackward({int seconds = 10}) {
    final controller = videoPlayerController;
    if (controller == null) return;

    final currentPosition = controller.value.position;
    var newPosition = currentPosition - Duration(seconds: seconds);

    if (newPosition < Duration.zero) {
      newPosition = Duration.zero;
    }

    controller.seekTo(newPosition);
  }

  bool _isPopupShowing = false;

  Future<void> showTimeFinishedPopup() async {
    // Prevent showing popup if it's already visible
    if (_isPopupShowing) return;

    try {
      _isPopupShowing = true;
      final context = appNavigatorKey.currentContext!;

      try {
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          Navigator.pop(context);
        }
      } catch (e) {
        log('Error handling orientation in time finished popup: $e');
      }

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: TimeFinishedPopup(
              onTapOk: () async {
                await continueWatching();
                if (context.mounted) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
              showId: showId,
              provider: this,
            ),
          );
        },
      );
    } finally {
      _isPopupShowing = false;
    }
  }

  StateProvider stateVideoTrans = const StateProvider.loading();

  Future<VideoTransactionModel> getForTransaction(
    VideoTransactionType type,
  ) async {
    final videoController = videoPlayerController;
    final fromMinute = videoController?.value.position.toString();

    return VideoTransactionModel(
      videoTransactionType: type,
      userId: userId!,
      showId: showId,
      videoId: videoId,
      episodeId: episodeId,
      fromMinute: fromMinute?.replaceAll(' ', ''),
    );
  }

  Future sendVideoTransaction(VideoTransactionType type) async {
    isTransactionCompleted = type == VideoTransactionType.completeVideo;
    stateVideoTrans = const StateProvider.loading();
    notifyListeners();
    if (userId != null) {
      final model = await getForTransaction(type);
      print(model.toJson());
      print('model.toJson()');
      (await homeService.videoTransaction(model: model)).fold(
        (failure) {
          stateVideoTrans = StateProvider.error(failure.message);
          // AppToast.show(failure.message);
        },
        (data) {
          stateVideoTrans = const StateProvider.success();
          if (type == VideoTransactionType.closePage ||
              type == VideoTransactionType.completeVideo) {
            appNavigatorKey.currentContext!
                .read<HomeProvider>()
                .getContinueWatchingProvide();
          }
        },
      );
    }
  }

  AppState stateContinueWatching = AppState.init;
  Future continueWatching() async {
    stateContinueWatching = AppState.loading;
    notifyListeners();

    final videoController = videoPlayerController;
    if (videoController == null || videoController.value.duration == null) {
      stateContinueWatching = AppState.error;
      notifyListeners();
      return;
    }

    final current = videoController.value.position;
    final duration = videoController.value.duration!;
    final difference = duration - current;
    final differenceMinutes =
        difference.inMinutes < 2 ? 2 : difference.inMinutes;

    (await homeService.continueWatching(time: differenceMinutes)).fold(
      (failure) {
        stateContinueWatching = AppState.error;
        AppToast.show(failure.message);
        notifyListeners();
      },
      (data) {
        stateContinueWatching = AppState.success;
        notifyListeners();
        AppToast.show(
          AppLocalization.strings.requestSent,
          backgroundColor: AppColorsNew.green2,
        );
      },
    );
  }

  Future<void> _handlePostCompletionActions(BuildContext context) async {
    if (repeatCounter == 1) {
      final currentUser = CacheHelper.currentUser;
      if (currentUser == null) return;
      try {
        if (showRate) {
          await _addRate(context);
        }
        if (currentUser.userType.isChild) {
          await _addQuiz(context);
        }
      } catch (e) {
        log('Post-completion error: $e');
      }
    }
  }

  String? claculateEndTime() {
    final videoController = videoPlayerController;
    if (videoController == null || videoController.value.duration == null) {
      return null;
    }

    String? endTime = videoController.value.position.toString();
    final duration = videoController.value.duration;
    final position = videoController.value.position;

    if ((duration - Duration(seconds: position.inSeconds)) <=
        Duration(seconds: 10)) {
      endTime = '00:00:00';
    }
    return endTime;
  }

  void stopAndDispose() {
    _stopTimer();

    if (videoPlayerController != null) {
      try {
        videoPlayerController!.pause();
        videoPlayerController!.removeListener(_videoListener);
        videoPlayerController!.dispose();
      } catch (_) {}
      videoPlayerController = null;
    }
  }

  Future<void> _addQuiz(BuildContext context) async {
    // if (!addQuiz) return;
    // addQuiz = false;
    // final quizProvider = sl<QuizProvider>();
    // final childExamModel = await quizProvider.addChildExams(
    //   showId: showId,
    //   episodeId: episodeId,
    // );
    // quizProvider.dispose();
    // if (childExamModel != null && childExamModel.fristTake && context.mounted) {
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(content: ToQuizPopup(childExamModel));
    //     },
    //   );
    // }
  }

  Future<RateModel?> getReview() async {
    //rate show only
    if (episodeId != null) return null;
    final response = await homeService.getReview(id: showId);
    oldRateModel = response.fold((failure) => null, (data) => data);
    return oldRateModel;
  }

  bool addRate = true;
  RateModel? oldRateModel;

  Future<void> _addRate(BuildContext context) async {
    //rate show only
    if (episodeId != null) return;
    if (!addRate) return;
    addRate = false;
    final rateModel = oldRateModel ?? RateModel(showId: showId, userId: userId);
    try {
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        Navigator.pop(context);
      }
    } catch (e) {
      log('Error handling orientation in rate dialog: $e');
    }
    await showDialog(
      context: context,
      builder: (context) {
        return RateDialog(
          rateModel: rateModel,
          showTitle: showTitle,
          onTap: (rateModel) async {
            final Either<Failure, RateModel> result;
            if (oldRateModel == null) {
              result = await homeService.addReview(rateModel);
            } else {
              result = await homeService.updateReview(rateModel);
            }
            result.fold(
              (failure) {
                AppToast.show(failure.message);
              },
              (data) {
                oldRateModel = data;
              },
            );
          },
        );
      },
    );
    addRate = true;
  }
}
