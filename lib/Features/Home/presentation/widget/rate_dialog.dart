import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:amaan_tv/gen/assets.gen.dart';
import 'package:amaan_tv/Features/Home/data/models/rate_model.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';

import 'package:amaan_tv/core/widget/circle_progress_helper.dart';
import '../../../../core/Themes/app_text_styles_new.dart';
import '../../../../core/widget/buttons/main_button.dart';
import 'package:amaan_tv/core/languages/app_localizations.dart';

enum VideoRate {
  one(1),
  two(2),
  three(3),
  four(4),
  five(5);

  final int rate;

  const VideoRate(this.rate);

  static VideoRate? fromRate(int rate) => VideoRate.values
      .cast<VideoRate?>()
      .firstWhere((value) => value?.rate == rate, orElse: () => null);

  Image get image {
    switch (this) {
      case VideoRate.one:
        return Assets.images.rate1.image();
      case VideoRate.two:
        return Assets.images.rate2.image();
      case VideoRate.three:
        return Assets.images.rate3.image();
      case VideoRate.four:
        return Assets.images.rate4.image();
      case VideoRate.five:
        return Assets.images.rate5.image();
    }
  }
}

class RateDialog extends StatefulWidget {
  const RateDialog({
    required this.rateModel,
    required this.showTitle,
    required this.onTap,
    super.key,
  });

  final RateModel rateModel;
  final String showTitle;
  final FutureOr<void> Function(RateModel rateModel) onTap;

  @override
  State<RateDialog> createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  late final initRate = widget.rateModel.rate;
  late VideoRate? videoRate = initRate == null
      ? null
      : VideoRate.fromRate(initRate!);

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context)!.rateVideo('name');
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalization.strings.rateVideo(widget.showTitle),
                      style: AppTextStylesNew.style16ExtraBoldAlmarai,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 124.r,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (final rate in VideoRate.values.reversed)
                            _RateEmojiWidget(
                              onTap: () {
                                setState(() {
                                  videoRate = rate;
                                });
                              },
                              rate: rate,
                              selectedRate: videoRate,
                            ),
                        ],
                      ),
                    ),
                    MainButtonWidget(
                      label: AppLocalization.strings.review,
                      fontSize: 16,
                      onTap: () async {
                        if (widget.rateModel.rate == videoRate?.rate ||
                            isLoading ||
                            videoRate == null) {
                          return;
                        }
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await widget.onTap.call(
                            widget.rateModel.copyWith(rate: videoRate?.rate),
                          );
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                    ),
                    Gap(10.r),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        AppLocalization.strings.noThanks,
                        style: AppTextStylesNew.style14BoldAlmarai,
                      ),
                    ),
                  ],
                ),
                if (isLoading)
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: AppCircleProgressHelper(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RateEmojiWidget extends StatelessWidget {
  const _RateEmojiWidget({
    required this.onTap,
    required this.rate,
    this.selectedRate,
  });

  final VoidCallback onTap;
  final VideoRate rate;
  final VideoRate? selectedRate;

  @override
  Widget build(BuildContext context) {
    final isSelected = rate == selectedRate;
    return AnimatedContainer(
      width: isSelected ? 84.r : 60.r,
      height: isSelected ? 84.r : 60.r,
      duration: Durations.medium1,
      child: GestureDetector(
        onTap: onTap,
        child: ColorFiltered(
          colorFilter: isSelected
              ? ColorFilter.mode(Colors.transparent, BlendMode.multiply)
              : ColorFilter.matrix([
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0,
                  0,
                  0,
                  1,
                  0,
                ]),
          child: rate.image,
        ),
      ),
    );
  }
}
