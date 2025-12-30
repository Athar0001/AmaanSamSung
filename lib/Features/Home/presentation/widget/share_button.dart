import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/widget/radio%20button/radio_button_multi_select_package.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    required this.text,
    required this.icon,
    super.key,
    this.onTap,
  });

  final String text;
  final Widget icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TvClickButton(
      onTap: onTap ?? () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
        decoration: containerDecoration(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,
                style: AppTextStylesNew.style12BoldAlmarai
                    .copyWith(fontWeight: FontWeight.w400)),
            8.horizontalSpace,
            icon
          ],
        ),
      ),
    );
  }
}

BoxDecoration showDecoration({double? radius, Color? borderColor}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius ?? 20.r),
    color: AppColorsNew.white1.withOpacity(0.05),
    border:
        Border.all(color: borderColor ?? AppColorsNew.white1.withOpacity(0.1)),
  );
}
