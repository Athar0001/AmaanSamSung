import 'package:flutter/material.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/Features/favorite/presentation/widgets/favorite_icon_button.dart';
import 'package:amaan_tv/core/widget/buttons/back_button.dart';
import 'package:amaan_tv/core/widget/icon_widget.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/utils/asset_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PosterHeader extends StatelessWidget {

  const PosterHeader({
    required this.model, required this.isSuggested, super.key,
  });
  final Details model;
  final bool isSuggested;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        8.horizontalSpace,
        BackButtonWidget(isBlack: true),
        Spacer(),
        if (model.type.isEpisode != true && isSuggested)
          IconWidget(
            path: Assets.imagesPlus,
            iconColor: AppColorsNew.white,
          ),
        FavoriteIconButton(model),
        6.horizontalSpace,
      ],
    );
  }
}
