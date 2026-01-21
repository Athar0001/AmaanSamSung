import 'package:amaan_tv/Features/Home/presentation/widget/show_series_poster/animated_show_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clip_shadow/flutter_clip_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/Clippers/layour_clipper.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/release_countdown.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/show_series_poster/mobile_layout.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/show_series_poster/tablet_layout.dart';

class ShowSeriesPoster extends StatefulWidget {
  const ShowSeriesPoster({
    required this.model,
    required this.onTapShow,
    required this.refresh,
    super.key,
    this.isLoading = false,
  });

  final Details model;
  final bool isLoading;
  final VoidCallback onTapShow;
  final VoidCallback refresh;

  @override
  State<ShowSeriesPoster> createState() => _ShowSeriesPosterState();
}

class _ShowSeriesPosterState extends State<ShowSeriesPoster> {
  @override
  Widget build(BuildContext context) {
    final isTablet = 1.sw > 600;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 540.r,
          child: Stack(
            children: [
              ClipShadow(
                clipper: BottomCurveClipper(deepCurve: 70.r),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(3, 3),
                    blurRadius: 15.r,
                    spreadRadius: 1.r,
                    color: AppColorsNew.grey7.withValues(alpha: 0.2),
                  ),
                ],
                child: isTablet
                    ? TabletLayout(
                        model: widget.model,
                      )
                    : MobileLayout(model: widget.model),
              ),
              Positioned(
                bottom: 0.r,
                right: 0,
                left: 0,
                child: AnimatedShowButton(
                  model: widget.model,
                  isLoading: widget.isLoading,
                  onTapShow: widget.onTapShow,
                ),
              ),
            ],
          ),
        ),
        // BottomActions(model: widget.model),
        // 10.verticalSpace,
        if (widget.model.isReleased == false)
          ReleaseCountdown(releaseDate: widget.model.releaseDateTime!)
      ],
    );
  }
}
