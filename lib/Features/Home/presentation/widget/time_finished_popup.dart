import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import '../../../../core/Themes/app_text_styles_new.dart';
import '../../../../core/utils/app_localiztion.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/widget/circle_progress_helper.dart';
import '../../../../core/widget/buttons/main_button.dart';
import '../../../../gen/assets.gen.dart';
import '../../provider/show_player_provider.dart';

class TimeFinishedPopup extends StatelessWidget {

  const TimeFinishedPopup(
      {required this.onTapOk, required this.showId, required this.provider, super.key,
      this.isLoading = false});
  final VoidCallback onTapOk;
  final String showId;
  final bool isLoading;
  final ShowPlayerProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Consumer<ShowPlayerProvider>(
        builder: (context, provider, child) => SizedBox(
          width: 300.r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Assets.images.sleepChild.path,
                height: 140.r,
              ),
              SizedBox(height: 10.h),
              Text(
                AppLocalization.strings.timeFinished,
                style: AppTextStylesNew.style12RegularAlmarai
                    .copyWith(fontSize: 0.024.sh),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.h),
              if (provider.stateContinueWatching == AppState.loading)
                AppCircleProgressHelper()
              else ...[
                MainButtonWidget(
                  label: AppLocalization.strings.sendWatchRequest,
                  onTap: onTapOk.call,
                ),
                SizedBox(height: 10.r),
                MainButtonWidget(
                  label: AppLocalization.strings.cancel,
                  isBlack: true,
                  onTap: () {
                    Navigator.pop(context, true);
                    Navigator.pop(context, true);
                  },
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
