import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/asset_manager.dart';
import 'package:amaan_tv/core/widget/buttons/main_button.dart';

class NoVideoDialog extends StatelessWidget {
  const NoVideoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280.r,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 280.r,
            padding: EdgeInsets.only(
              left: 24.r,
              right: 24.r,
              top: 12.r,
              bottom: 24.r,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                24.verticalSpace,
                Text(
                  AppLocalization.strings.welcomeMyFriend,
                  textAlign: TextAlign.center,
                  style: AppTextStylesNew.style16BoldAlmarai.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // Message Text
                Text(
                  AppLocalization.strings.playAndRecite,
                  textAlign: TextAlign.center,
                  style: AppTextStylesNew.style16BoldAlmarai.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                // Close Button
                MainButtonWidget(
                  label: AppLocalization.strings.ok,
                  isCenter: false,
                  width: 120.r,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                // 24.verticalSpace,
              ],
            ),
          ),
          // Character positioned outside dialog in bottom left with 3D effect
          Positioned(
            bottom: -20.r,
            right: 70.r,
            child: Transform.scale(
              scale: 1.2,
              child: Image.asset(
                Assets.imagesAmaarChar,
                height: 200.r,
                // width: 150.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
