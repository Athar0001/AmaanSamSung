import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AppCircleProgressHelper extends StatelessWidget {
  const AppCircleProgressHelper({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 40.r,
        width: 40.r,
        child: LoadingIndicator(
          indicatorType: Indicator.ballPulseSync,
          strokeWidth: 2,
          colors: [AppColorsNew.primary, AppColorsNew.amber2],
        ),
      ),
    );
  }
}

class LoadingVideo extends StatelessWidget {
  const LoadingVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 70.r,
        width: 70.r,
        child: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
          strokeWidth: 2,
          colors: [AppColorsNew.primary, AppColorsNew.amber2],
        ),
      ),
    );
  }
}
