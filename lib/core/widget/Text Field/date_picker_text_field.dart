import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/asset_manager.dart';
import 'package:amaan_tv/core/widget/Text%20Field/text_field_widget.dart';

import '../SVG_Image/svg_img.dart';

class LimitedWidthPopup extends StatelessWidget {
  const LimitedWidthPopup({
    required this.child,
    super.key,
    this.width = 0.9,
    this.height,
    this.borderRadius,
  });

  final Widget child;
  final double width;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 400.r, maxHeight: 400.r),
        width: width.sw,
        height: height?.r,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: borderRadius ?? BorderRadius.circular(16.r),
        ),
        child: child,
      ),
    );
  }
}

