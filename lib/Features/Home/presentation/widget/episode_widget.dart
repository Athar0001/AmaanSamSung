import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/repeat_dialog.dart';
import 'package:amaan_tv/Features/Home/provider/show_provider.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/Features/favorite/presentation/widgets/favorite_icon_button.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/lock_widget.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:amaan_tv/core/widget/custom_dialog.dart';
import 'package:amaan_tv/core/widget/gradient_container.dart';
import 'package:amaan_tv/core/widget/radio%20button/radio_button_multi_select_package.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:amaan_tv/core/utils/app_router.dart';

import '../../provider/time_provider.dart';
import '../../../../core/utils/app_localiztion.dart';
import '../../../../core/widget/app_toast.dart';
import '../../functions.dart';

class EpisodeWidget extends StatefulWidget {
  const EpisodeWidget({
    required this.model,
    required this.episodesModel,
    super.key,
  });

  final Details model;
  final List<Details> episodesModel;

  @override
  State<EpisodeWidget> createState() => _EpisodeWidgetState();
}

class _EpisodeWidgetState extends State<EpisodeWidget> {

  onTapShow(){
    if (!widget.model.isReleased) {
      AppToast.show(AppLocalization.strings.showNotReleasedYet);
      return;
    }
    final isAllowed = checkIfVideoAllowed(
      isFree: widget.model.isFree,
      isGuest: widget.model.isGuest,
      context: context,
    );
    if (isAllowed != null) {
      AppToast.show(isAllowed);
      return;
    }
    if (!context.read<TimeProvider>().isValidToContinue) {
      AppToast.show(AppLocalization.strings.watchingNotAllowed);
      return;
    }
    if (widget.model.presignedUrl != null) {
      final mainVideo = widget.model.episodeVideos?.firstWhere(
            (element) => element.videoTypeId == '1',
        orElse: () => widget.model.episodeVideos!.first,
      );

      if (widget.model.isRepeat) {
        showDialog<int>(
          context: context,
          builder: (context) {
            return const CustomDialog(content: RepeatDialog());
          },
        ).then((value) {
          if (value != null && context.mounted) {
            context.pushNamed(
              AppRoutes.showPlayer.routeName,
              extra: {
                'url': widget.model.presignedUrl ?? '',
                'show': widget.model,
                'episodeId': widget.model.id,
                'episodesModel': widget.episodesModel,
                'videoId': mainVideo?.id ?? '',
                'repeatTimes': value,
                'closingDuration':
                mainVideo?.closingDuration ??
                    widget.model.closingDuration,
              },
            );
          }
        });
      } else {
        context.pushNamed(
          AppRoutes.showPlayer.routeName,
          extra: {
            'url': widget.model.presignedUrl ?? '',
            'show': widget.model,
            'episodeId': widget.model.id,
            'episodesModel': widget.episodesModel,
            'videoId': mainVideo?.id ?? '',
            'closingDuration':
            mainVideo?.closingDuration ??
                widget.model.closingDuration,
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Focus(
          onKeyEvent: (node, event) {
            if (event is KeyDownEvent &&
                (event.logicalKey == LogicalKeyboardKey.enter ||
                    event.logicalKey == LogicalKeyboardKey.select)) {
              onTapShow();
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
           child: Builder(
             builder: (context) {
               final focused = Focus.of(context).hasFocus;
               return GestureDetector(
                onTap: () {
                  onTapShow();
                },
                child: DecoratedBox(
                  decoration: containerDecoration(context,
                  borderColor: focused? AppColorsNew.white : null
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: CachedNetworkImageHelper(
                                width: double.infinity,
                                height: double.infinity,
                                imageUrl: widget.model.thumbnailImage?.url,
                              ),
                            ),
                            GradientHomePoster(
                              height: double.infinity,
                              borderRadius: 0,
                            ),
                            if (widget.model.isReleased == false &&
                                widget.model.releaseDateTime != null)
                              Align(
                                child: CountdownWidget(
                                  releaseDateTime: widget.model.releaseDateTime,
                                ),
                              )
                            else if (checkIfVideoAllowed(
                                  isFree: widget.model.isFree,
                                  isGuest: widget.model.isGuest,
                                ) !=
                                null)
                              Align(child: LockWidget()),
                            PositionedDirectional(
                              start: 0,
                              bottom: 0,
                              width: constraints.maxWidth,
                              child: Padding(
                                padding: EdgeInsets.all(16.r),
                                child: Text(
                                  widget.model.title,
                                  textAlign: TextAlign.start,
                                  style: AppTextStylesNew.style14RegularAlmarai
                                      .copyWith(
                                        color: AppColorsNew.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              end: 0,
                              top: 0,
                              child: FavoriteIconButton(widget.model),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Text(
                          widget.model.description ?? 'no description',
                          style: AppTextStylesNew.style12RegularAlmarai,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                         );
             }
           ),
        );
      },
    );
  }
}

class CountdownWidget extends StatefulWidget {
  const CountdownWidget({required this.releaseDateTime, super.key});

  final DateTime? releaseDateTime;

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  Timer? _timer;
  Duration? _remainingTime;

  @override
  void initState() {
    super.initState();
    _calculateRemainingTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateRemainingTime();
    });
  }

  void _calculateRemainingTime() {
    if (widget.releaseDateTime != null) {
      final now = DateTime.now();
      if (widget.releaseDateTime!.isAfter(now)) {
        if (mounted) {
          setState(() {
            _remainingTime = widget.releaseDateTime!.difference(now);
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _remainingTime = Duration.zero;
          });
          try {
            context.read<ShowProvider>().getShowsEpisodesProvide();
          } catch (e, st) {
            log('$e', stackTrace: st, name: 'Error in getShowsEpisodesProvide');
          }
        }
        _timer?.cancel();
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_remainingTime == null || _remainingTime!.isNegative) {
      // Show a generic "coming soon" message if timer isn't ready
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha((0.7 * 255).round()),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          AppLocalization.strings.comingSoon,
          style: AppTextStylesNew.style14RegularAlmarai.copyWith(
            color: AppColorsNew.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    if (_remainingTime == Duration.zero) {
      // The timer has finished, but the parent widget hasn't rebuilt yet.
      // You could show a refresh indicator or just the lock.
      return LockWidget();
    }

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final days = twoDigits(_remainingTime!.inDays);
    final hours = twoDigits(_remainingTime!.inHours.remainder(24));
    final minutes = twoDigits(_remainingTime!.inMinutes.remainder(60));
    final seconds = twoDigits(_remainingTime!.inSeconds.remainder(60));

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha((0.7 * 255).round()),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalization.strings.releaseIn,
            style: AppTextStylesNew.style12RegularAlmarai.copyWith(
              color: AppColorsNew.white,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_remainingTime!.inDays > 0) ...[
                _buildTimeCard(time: days, label: AppLocalization.strings.days),
                SizedBox(width: 5.w),
                _buildTimeSeparator(),
                SizedBox(width: 5.w),
              ],
              _buildTimeCard(time: hours, label: AppLocalization.strings.hours),
              SizedBox(width: 5.w),
              _buildTimeSeparator(),
              SizedBox(width: 5.w),
              _buildTimeCard(
                time: minutes,
                label: AppLocalization.strings.minutes,
              ),
              SizedBox(width: 5.w),
              _buildTimeSeparator(),
              SizedBox(width: 5.w),
              _buildTimeCard(
                time: seconds,
                label: AppLocalization.strings.seconds,
              ),
            ],
          ),
          if (widget.releaseDateTime != null) ...[
            SizedBox(height: 8.h),
            Text(
              '${AppLocalization.strings.releaseDate}: ${widget.releaseDateTime!.day}/${widget.releaseDateTime!.month}/${widget.releaseDateTime!.year}',
              style: AppTextStylesNew.style10oldAlmarai.copyWith(
                color: AppColorsNew.white.withAlpha((0.8 * 255).round()),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimeSeparator() {
    return Text(
      ':',
      style: AppTextStylesNew.style16BoldAlmarai.copyWith(
        color: AppColorsNew.white,
      ),
    );
  }

  Widget _buildTimeCard({required String time, required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          time,
          style: AppTextStylesNew.style16BoldAlmarai.copyWith(
            color: AppColorsNew.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: AppTextStylesNew.style10oldAlmarai.copyWith(
            color: AppColorsNew.white.withAlpha((0.8 * 255).round()),
          ),
        ),
      ],
    );
  }
}
