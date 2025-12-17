import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/Features/Home/data/models/home/reals_model.dart';
import 'package:amaan_tv/core/utils/constant.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:amaan_tv/core/widget/gradient_container.dart';

class BestMomentsWidget extends StatelessWidget {
  const BestMomentsWidget({
    required this.reelModel, super.key,
  });
  final ReelModel reelModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: Constant.paddingLeftRight,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Stack(
          // fit: StackFit.expand,
          children: [
            AspectRatio(
              aspectRatio: 112 / 198,
              child: CachedNetworkImageHelper(
                height: double.infinity,
                width: double.infinity,
                imageUrl: reelModel.thumbnailImage?.url ?? '',
              ),
            ),
            ColoredBox(
              color: Colors.transparent,
              child: GradientHomePoster(
                  // width: 112.r,
                  ),
            ),
            // Positioned(
            //   bottom: 8,
            //   right: 3,
            //   child: Row(
            //     children: [
            //       Icon(
            //         Icons.play_arrow_rounded,
            //         size: 18.r,
            //       ),
            //       Text(
            //         "14" "k",
            //         style: AppTextStylesNew.style12RegularAlmarai,
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
