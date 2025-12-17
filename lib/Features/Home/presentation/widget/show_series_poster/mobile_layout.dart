import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/banner/banner_image.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/show_series_poster/poster_header.dart';
import 'package:amaan_tv/Features/Home/provider/show_provider.dart';
import 'package:provider/provider.dart';

class MobileLayout extends StatelessWidget {

  const MobileLayout({required this.model, super.key});
  final Details model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: BannerImage(
            imageUrl: model.bannerThumbnailImage?.url,
            fit: BoxFit.fill,
          ),
        ),
        Column(
          children: [
            SafeArea(
              child: PosterHeader(
                model: model,
                isSuggested: Provider.of<ShowProvider>(context, listen: false)
                    .isSuggested,
              ),
            ),
            Spacer(),
            RichText(
              text: TextSpan(
                style: AppTextStylesNew.style14BoldAlmarai,
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Icon(Icons.star,
                          color: AppColorsNew.yellow1, size: 15.r),
                    ),
                  ),
                  TextSpan(
                    text: "${model.rate?.toStringAsFixed(1) ?? ''}  ",
                  ),
                  TextSpan(
                    text: model.genres!.map((genre) => genre.name).join(' . '),
                  ),
                  TextSpan(
                    text: " . ${DateTime.tryParse(model.releaseDate ?? "")!
                            .year}",
                  ),
                ],
              ),
            ),
            90.verticalSpace,
          ],
        ),
      ],
    );
  }
}
