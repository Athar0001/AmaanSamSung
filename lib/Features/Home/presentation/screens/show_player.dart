import 'dart:developer';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/Themes/app_colors_new.dart';
import '../../../../core/Themes/app_text_styles_new.dart';
import '../../../../core/injection/injection_imports.dart' as di;
import '../../data/models/home/show_details_model/data.dart';
import '../../data/models/video_transaction_model.dart';
import '../../provider/show_player_provider.dart';
import '../../provider/time_provider.dart';

class ShowPlayerScreen extends StatefulWidget {
  const ShowPlayerScreen({
    required this.url,
    required this.show,
    required this.videoId,
    super.key,
    this.fromMinute,
    this.episodeId,
    this.episodesModel,
    this.showRate = true,
    this.repeatTimes,
    this.closingDuration,
  });
  final String? episodeId;
  final String? fromMinute;
  final List<Details>? episodesModel;
  final Details show;
  final String url;
  final String videoId;
  final bool showRate;
  final int? repeatTimes;
  final int? closingDuration;

  @override
  State<ShowPlayerScreen> createState() => _ShowPlayerScreenState();
}

class _ShowPlayerScreenState extends State<ShowPlayerScreen>
    with WidgetsBindingObserver {
  // late final ScreenPrivacy _screenPrivacy;
  late ShowPlayerProvider showPlayerProvider;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive) {
      context.read<TimeProvider>().sendVideoLog();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // _screenPrivacy.enableScreenshot().catchError((Object error) {
    //   log('Error enabling screenshot: $error');
    //   return false; // Return false if enabling screenshot fails
    // });
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Force landscape orientation when video player opens
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    // _screenPrivacy = ScreenPrivacy();
    // _screenPrivacy
    //     .disableScreenshot()
    //     .then((value) {
    //       log('isScreenshotDisabled: $value');
    //     })
    //     .catchError((Object error) {
    //       log('Error disabling screenshot: $error');
    //     });
    log(widget.url);
    final addQuiz = widget.show.hasExam && !widget.show.childTakedExam;
    showPlayerProvider = di.sl<ShowPlayerProvider>()
      ..initializeVideo(
        showTitle: widget.show.title,
        url: widget.url,
        context: context,
        episodesModel: widget.episodesModel,
        showId: widget.show.id,
        videoId: widget.videoId,
        episodeId: widget.episodeId,
        fromMinute: widget.fromMinute,
        addQuiz: addQuiz,
        trailerDuration: widget.show.trailerDuration,
        closingDuration: widget.closingDuration,
        showRate: widget.showRate,
        repeatTimes: widget.repeatTimes,
      );
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: showPlayerProvider,
      child: Consumer<ShowPlayerProvider>(
        builder: (context, provider, child) {
          return PopScope(
            onPopInvokedWithResult: (didPop, result) async {
              if (!provider.isTransactionCompleted) {
                context.read<TimeProvider>().sendVideoLog();
                final endTime = provider.claculateEndTime();
                provider.stopAndDispose();
                if (endTime != null) {
                  context.read<TimeProvider>().continueWatching(
                        widget.videoId,
                        endTime,
                      );
                }
                provider.sendVideoTransaction(VideoTransactionType.closePage);
              }

              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
              ]);
            },
            child: Scaffold(
              backgroundColor: Colors.black,
              body: SafeArea(
                child: Stack(
                  children: [
                    if (provider.videoPlayerController != null)
                      VideoPlayer(provider.videoPlayerController!),
                    Align(
                      alignment: Alignment.topRight,
                      child: VideoTitleWidget(
                        title: provider.showTitle,
                        url: widget.url,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class VideoTitleWidget extends StatefulWidget {
  VideoTitleWidget({required this.title, required this.url, super.key});

  final String title;
  final String url;

  @override
  State<VideoTitleWidget> createState() => _VideoTitleWidgetState();
}

class _VideoTitleWidgetState extends State<VideoTitleWidget> {
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        (MediaQuery.of(context).orientation == Orientation.landscape);
    return Row(
      children: [
        TvClickButton(
          onTap: () {
            if (isLandscape) {
              Navigator.pop(context);
              Navigator.pop(context);
            } else {
              Navigator.pop(context);
            }
          },
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  right: 20,
                  left: 10,
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 30.r,
                  color: isLandscape
                      ? AppColorsNew.white
                      : Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              Text(
                widget.title,
                style: AppTextStylesNew.style16BoldAlmarai.copyWith(
                  fontSize: 20,
                  color: isLandscape
                      ? AppColorsNew.white
                      : Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
      ],
    );
  }
}
