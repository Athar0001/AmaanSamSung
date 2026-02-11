import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/core/utils/constant.dart';
import 'package:flutter/material.dart';

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
        ],
        ),
      ),
    );
  }
}
