import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/generated/assets.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/show_series_poster/show_detials_poster.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/widget/SVG_Image/svg_img.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ShowButtonWidget extends StatelessWidget {
  const ShowButtonWidget({required this.widget, super.key});

  final ShowSeriesPoster widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.r,
      width: 70.r,
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).scaffoldBackgroundColor,
          width: 6.r,
        ),
        gradient: const LinearGradient(
          colors: [AppColorsNew.blue4, AppColorsNew.blue2],
        ),
      ),
      child: widget.isLoading
          ? LoadingPlayIcon()
          : widget.model.isReleased
          ? SVGImage(path: Assets.images.play.path, color: AppColorsNew.white)
          : SVGImage(path: Assets.images.lock.path, color: AppColorsNew.white),
    );
  }
}

class EpsButtonWidget extends StatelessWidget {
  const EpsButtonWidget({required this.widget, super.key});

  final ShowSeriesPoster widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.isLoading ? 40.r : null,
      width: widget.isLoading ? 110.r : null,
      padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: const LinearGradient(
          colors: [AppColorsNew.blue4, AppColorsNew.blue2],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.isLoading)
            SizedBox()
          else
            Text(
              '${AppLocalization.strings.episode} ${widget.model.eposideNumber ?? 1}',
              style: AppTextStylesNew.style14BoldAlmarai,
            ),
          5.horizontalSpace,
          if (widget.isLoading)
            LoadingPlayIcon()
          else
            widget.model.isReleased
                ? SVGImage(path: Assets.images.play.path)
                : SVGImage(
                    path: Assets.images.lock.path,
                    color: AppColorsNew.white,
                  ),
        ],
      ),
    );
  }
}

class LoadingPlayIcon extends StatelessWidget {
  const LoadingPlayIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingIndicator(
        indicatorType: Indicator.triangleSkewSpin,
        strokeWidth: 2.r,
        colors: [AppColorsNew.white, AppColorsNew.amber2],
      ),
    );
  }
}
