import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:provider/provider.dart';

//TODO: need to be refactor !!!
class FamilyCardWidget extends StatelessWidget {
  const FamilyCardWidget({
    required this.imageString,
    required this.label,
    required this.isPrimaryColor,
    super.key,
    this.onTap,
    this.enableOnTap = true,
  });
  final String imageString;
  final String label;
  final bool isPrimaryColor;
  final bool enableOnTap;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final selectedValue = context.watch<UserNotifier>().genderOfChild;
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return TvClickButton(
      onTap: () {
        if (enableOnTap) {
          context.read<UserNotifier>().selectChild(label);
        }
        onTap?.call();
      },
      child: Column(
        children: [
          SizedBox(
            height: isTablet ? 160.r : 110.r,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // The card behind the avatar
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: isTablet ? 150.r : 100.r,
                    width: isTablet ? 230.r : 163.r,
                    decoration: BoxDecoration(
                      gradient: selectedValue == label
                          ? LinearGradient(
                              colors: isPrimaryColor
                                  ? [AppColorsNew.blue2, AppColorsNew.blue4]
                                  : [
                                      AppColorsNew.orange4,
                                      AppColorsNew.orange3,
                                    ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            )
                          : null,
                      color: selectedValue == label
                          ? null
                          : AppColorsNew.white1.withOpacity(
                              Theme.of(context).brightness == Brightness.dark
                                  ? 0.03
                                  : 0.8,
                            ),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColorsNew.black1.withOpacity(0.1),
                      ),
                    ),
                  ),
                ),
                // The avatar image on top of the card
                Positioned(
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: selectedValue == label
                        ? (isTablet ? 160.r : 110.r)
                        : (isTablet ? 140.r : 90.r),
                    height: selectedValue == label
                        ? (isTablet ? 160.r : 110.r)
                        : (isTablet ? 140.r : 90.r),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imageString),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          (isTablet ? 12 : 8).verticalSpace,
          Text(label, style: AppTextStylesNew.style18BoldAlmarai),
        ],
      ),
    );
  }
}
