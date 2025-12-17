import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/gen/assets.gen.dart';
import 'package:amaan_tv/core/widget/icon_widget.dart';

class LockWidget extends StatelessWidget {
  const LockWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconWidget(
      iconHeight: 30.r,
      iconWidth: 30.r,
      path: Assets.images.lock.path,
      iconColor: Colors.white,
    );
  }
}
