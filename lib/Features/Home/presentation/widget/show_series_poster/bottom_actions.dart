import 'package:flutter/material.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/seasons_bottom_sheet.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/share_button.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/share_show_widget.dart';
import 'package:amaan_tv/Features/Home/provider/show_provider.dart';
import 'package:amaan_tv/Features/family/provider/family_provider.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/asset_manager.dart';
import 'package:amaan_tv/core/utils/constant.dart';
import 'package:amaan_tv/core/widget/SVG_Image/svg_img.dart';
import 'package:provider/provider.dart';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';

class BottomActions extends StatelessWidget {

  const BottomActions({
    required this.model, super.key,
  });
  final Details? model;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Constant.paddingLeftRight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ShareButton(
            //   text: AppLocalization.strings.seasons,
            //   icon: SVGImage(path: Assets.imagesYoutube),
            //   onTap: () {
            //     if (model?.type.isEpisode == false &&
            //         model?.showUniverse != null) {
            //       showSeasonsBottomSheet(context,
            //           season: context.read<ShowProvider>().seasonsModel!.data!);
            //     }
            //   },
            // ),
            if (context.read<UserNotifier>().userData?.userType.isParent == true &&
                    model?.type.isEpisode == false) Consumer<FamilyProvider>(
                    builder: (context, fmailyProvider, child) => ShareButton(
                      text: AppLocalization.strings.share,
                      icon: SVGImage(path: Assets.imagesShare),
                      onTap: () {
                        shareBottomSheet(context, model!.id);
                      },
                    ),
                  ) else SizedBox(),
          ],
        ),
      ),
    );
  }
}
