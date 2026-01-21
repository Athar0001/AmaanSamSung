import 'dart:async';
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
import '../../../../core/utils/app_localiztion.dart';
import '../../../../core/utils/asset_manager.dart';
import '../../../../core/widget/SVG_Image/svg_img.dart';
import '../../../../core/widget/buttons/main_button.dart';
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
  final FocusScopeNode _controlsFocusScope = FocusScopeNode();
  late ShowPlayerProvider showPlayerProvider;

  bool _controlsVisible = false;
  Timer? _hideControlsTimer;

  void _showControls() {
    if (!_controlsVisible) {
      setState(() => _controlsVisible = true);

      // ✅ MOVE FOCUS TO CONTROLS
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controlsFocusScope.requestFocus();
        }
      });
    }

    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() => _controlsVisible = false);
        FocusManager.instance.primaryFocus?.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _controlsFocusScope.dispose();
    _hideControlsTimer?.cancel();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    // Force landscape orientation when video player opens
    //SystemChrome.setPreferredOrientations([
    //  DeviceOrientation.landscapeLeft,
    //  DeviceOrientation.landscapeRight,
    //]);

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
    log(widget.url, name: 'url');
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

              // SystemChrome.setPreferredOrientations([
              //   DeviceOrientation.portraitUp,
              // ]);
            },
            child: Focus(
              autofocus: true,
              onKeyEvent: (node, event) {
                if (event is KeyDownEvent) {
                  _showControls();
                }
                return KeyEventResult.ignored;
              },
              child: Scaffold(
                backgroundColor: Colors.black,
                body: SafeArea(
                  child: Stack(
                    children: [
                      if (provider.videoPlayerController != null)
                        VideoPlayer(provider.videoPlayerController!),

                      if (provider.isLoading)
                        const Center(
                          child: CircularProgressIndicator(
                            color: AppColorsNew.primary,
                          ),
                        ),
                      Align(
                        alignment: Alignment.topRight,
                        child: VideoTitleWidget(
                          title: provider.showTitle,
                          url: widget.url,
                        ),
                      ),
                      if (provider.videoPlayerController != null && !provider.isLoading)
                        Align(
                            alignment: Alignment.center,
                            child: AnimatedOpacity(
                              opacity: _controlsVisible ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 250),
                              child: FocusScope(
                              node: _controlsFocusScope,
                              child: _PlayerControls(),
                            ),
                            )),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PlayerControls extends StatelessWidget {
  const _PlayerControls();

  Details? _findNextEpisode(ShowPlayerProvider provider) {
    if (provider.episodes == null || provider.episodes!.isEmpty) return null;
    final currentId = provider.episodeId;
    if (currentId == null) return null;

    final index = provider.episodes!.indexWhere((e) => e.id == currentId);
    if (index != -1 && index < provider.episodes!.length - 1) {
      return provider.episodes![index + 1];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShowPlayerProvider>(
      builder: (context, provider, child) {
        final controller = provider.videoPlayerController;
        if (controller == null || !controller.value.isInitialized) {
          return const SizedBox.shrink();
        }

        return Stack(
          children: [
            // Center Controls
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.ltr,
                children: [
                  // Backward,
                  TvClickButton(
                    onTap: () => provider.seekBackward(),
                    builder: (context, hasFocus){
                      return Icon(Icons.replay_10_outlined, size: 40.r,
                          color: hasFocus?
                          AppColorsNew.primary:
                          AppColorsNew.white);
                    },
                  ),
                  SizedBox(width: 20.w),
                  // Play/Pause
                  TvClickButton(
                    onTap: () => provider.togglePlay(),
                    builder: (context, hasFocus){
                      return provider.isFinished
                          ? Icon(Icons.replay, size: 42,
                          color: hasFocus?
                          AppColorsNew.primary:
                          AppColorsNew.white)
                          : Container(
                        height: 0.15.sh,
                        width: 0.15.sh,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                            color: hasFocus?
                                !provider.isPlaying?
                            AppColorsNew.white:
                                AppColorsNew.primary:
                            Colors.transparent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Builder(
                            builder: (context) {
                              try {
                                return SVGImage(
                                  noTheme: true,
                                  path: provider.isPlaying
                                      ? Assets.imagesPauseVideo
                                      : Assets.imagesCirclePause,
                                );
                              } catch (e) {
                                // Fallback to Material Icons if SVG fails
                                return Icon(
                                  provider.isPlaying ? Icons.pause : Icons.play_arrow,
                                  color:
                                  hasFocus?
                                  AppColorsNew.primary:
                                  AppColorsNew.white,
                                  size: 30,
                                );
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 20.w),
                  // Forward
                  TvClickButton(
                    onTap: () => provider.seekForward(),
                    builder: (context, hasFocus){
                      return Icon(Icons.forward_10_outlined, size: 40.r,
                          color: hasFocus?
                          AppColorsNew.primary:
                          AppColorsNew.white);
                    },
                  ),
                ],
              ),
            ),

            // Reactive Overlays (Skip Intro & Next Episode)
            Positioned(
              bottom: 0,
              right: 0,
              child: ValueListenableBuilder<VideoPlayerValue>(
                valueListenable: controller,
                builder: (context, value, child) {
                  final position = value.position;
                  final duration = value.duration;
                  final trailerDuration = provider.trailerDuration;

                  // Skip Intro Logic
                  final showSkipIntro = trailerDuration != null &&
                      position.inSeconds < trailerDuration &&
                      trailerDuration > 0;

                  // Next Episode Logic
                  final isNearEnd = duration.inSeconds > 0 &&
                      (duration.inSeconds - position.inSeconds) < 20;

                  final nextEpisode =
                      isNearEnd ? _findNextEpisode(provider) : null;
                  final showNextEpisode = nextEpisode != null;

                  if (!showSkipIntro && !showNextEpisode) {
                    return const SizedBox.shrink();
                  }

                  if (showSkipIntro) {
                    return Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 80.h, right: 40.w),
                        child: _SkipIntroButton(
                          onSkip: () {
                            controller.seekTo(Duration(seconds: trailerDuration));
                          },
                        ),
                      ),
                    );
                  }
                  if (showNextEpisode) {
                    return Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 80.h, right: 40.w),
                        child: _NextEpisodeOverlay(
                          nextEpisode: nextEpisode,
                          onPlayNext: () {
                            provider.initializeVideo(
                              url: nextEpisode.presignedUrl ?? '',
                              context: context,
                              showId: provider.showId,
                              videoId: nextEpisode.episodeVideos
                                      ?.firstWhere(
                                          (element) => element.videoTypeId == '1')
                                      .id ??
                                  '',
                              showTitle: nextEpisode.title,
                              addQuiz: nextEpisode.hasExam &&
                                  !nextEpisode.childTakedExam,
                              showRate: false,
                              episodesModel: provider.episodes,
                              episodeId: nextEpisode.id,
                              trailerDuration: nextEpisode.trailerDuration,
                              closingDuration: nextEpisode.closingDuration,
                            );
                          },
                          onCancel: () {
                            // No-op for now
                          },
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),

            // Bottom Progress
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
                child: _FocusableVideoProgressBar(
                    controller: controller, provider: provider),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SkipIntroButton extends StatelessWidget {
  final VoidCallback onSkip;
  const _SkipIntroButton({required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return MainButtonWidget(
      onTap: onSkip,
      width: 250,
      borderWidth: 1,
      label: AppLocalization.strings.skipIntro,
    );
  }
}

class _NextEpisodeOverlay extends StatelessWidget {
  final Details nextEpisode;
  final VoidCallback onPlayNext;
  final VoidCallback onCancel;

  const _NextEpisodeOverlay(
      {required this.nextEpisode,
      required this.onPlayNext,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Next Episode: ${nextEpisode.title}",
          style: AppTextStylesNew.style16BoldAlmarai
              .copyWith(color: Colors.white, shadows: [
            const Shadow(blurRadius: 10, color: Colors.black),
          ]),
        ),
        SizedBox(height: 10.h),
        MainButtonWidget(
          onTap: onPlayNext,
          width: 250,
          borderWidth: 1,
          label: AppLocalization.strings.nextEpisode,
        )
      ],
    );
  }
}

class _FocusableVideoProgressBar extends StatefulWidget {
  const _FocusableVideoProgressBar({
    required this.controller,
    required this.provider,
  });

  final VideoPlayerController controller;
  final ShowPlayerProvider provider;

  @override
  State<_FocusableVideoProgressBar> createState() =>
      _FocusableVideoProgressBarState();
}

class _FocusableVideoProgressBarState
    extends State<_FocusableVideoProgressBar> {
  final FocusNode _focusNode = FocusNode();
  Timer? _seekTimer;
  bool _seekingForward = false;

  void _startSeeking(bool forward) {
    _seekingForward = forward;

    _seekTimer?.cancel();
    _seekTimer = Timer.periodic(
      const Duration(milliseconds: 200),
          (_) {
        if (_seekingForward) {
          widget.provider.seekForward(seconds: 1);
        } else {
          widget.provider.seekBackward(seconds: 1);
        }
      },
    );
  }

  void _stopSeeking() {
    _seekTimer?.cancel();
    _seekTimer = null;
  }

  @override
  void didChangeDependencies() {
    if (!FocusScope.of(context).hasFocus) {
      _focusNode.requestFocus();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _seekTimer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            _startSeeking(true);
            return KeyEventResult.handled;
          }

          if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            _startSeeking(false);
            return KeyEventResult.handled;
          }

          if (event.logicalKey == LogicalKeyboardKey.enter ||
              event.logicalKey == LogicalKeyboardKey.select) {
            widget.provider.togglePlay();
            return KeyEventResult.handled;
          }
        }

        if (event is KeyUpEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
              event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            _stopSeeking();
            return KeyEventResult.handled;
          }
        }

        return KeyEventResult.ignored;
      },
      child: Builder(
        builder: (context) {
          final hasFocus = Focus.of(context).hasFocus;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: EdgeInsets.symmetric(vertical: 6.h),
            decoration: BoxDecoration(
              border: Border.all(
                color:
                hasFocus ? AppColorsNew.primary : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: VideoProgressIndicator(
                widget.controller,
                allowScrubbing: false,
                colors: VideoProgressColors(
                  playedColor: AppColorsNew.primary,
                  bufferedColor: Colors.white24,
                  backgroundColor:
                  Colors.white10.withOpacity(0.3),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TvClickButton(

          onTap: () {
            if (isLandscape) {
              Navigator.pop(context);
              //  Navigator.pop(context);
            } else {
              Navigator.pop(context);
            }
          },
          builder: (context, hasFocus){
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    right: 20,
                    left: 10,
                  ),
                  // child: Icon(
                  //   Icons.arrow_back_ios,
                  //   size: 30.r,
                  //   color: isLandscape
                  //       ? AppColorsNew.white
                  //       : Theme.of(context).textTheme.bodyMedium?.color,
                  // ),
                ),
                Container(
                  width: 0.9.sw,
                  child: Text(
                    widget.title,
                    style: AppTextStylesNew.style16BoldAlmarai.copyWith(
                      fontSize: 20,
                      color: hasFocus? AppColorsNew.primary : AppColorsNew.white ),
                  ),
                ),
              ],
            );
          },
        ),
        Spacer(),
      ],
    );
  }
}
