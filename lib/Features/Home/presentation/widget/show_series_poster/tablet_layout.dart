import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/banner/banner_image.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/show_series_poster/poster_header.dart';
import 'package:amaan_tv/Features/Home/provider/show_provider.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:amaan_tv/core/widget/gradient_container.dart';
import 'package:provider/provider.dart';

class TabletLayout extends StatelessWidget {

  const TabletLayout({required this.model, super.key});
  final Details model;

  @override
  Widget build(BuildContext context) {
    final posterWidth = 375.r;
    final posterHeight = 540.r;
    final imageUrl = model.bannerThumbnailImage?.url;
    return Stack(
      alignment: Alignment.topCenter,
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: BannerImage(
            imageUrl: imageUrl,
            blurSigma: 10,
          ),
        ),
        // Centered poster and info
        Center(
          child: Container(
            width: posterWidth,
            height: posterHeight,
            child: Stack(
              children: [
                // Poster image
                CachedNetworkImageHelper(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                  imageUrl: imageUrl,
                ),
                GradientHomePoster(
                  borderRadius: 0,
                ),

                // Content
                Column(
                  children: [
                    Spacer(),
                    // Info row (centered)
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStylesNew.style14BoldAlmarai,
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Icon(Icons.star,
                                    color: AppColorsNew.yellow1, size: 15.r),
                              ),
                            ),
                            TextSpan(
                              text:
                                  "${model.rate?.toStringAsFixed(1) ?? ''}  ",
                            ),
                            TextSpan(
                              text: model.genres!
                                  .map((genre) => genre.name)
                                  .join(' . '),
                            ),
                            TextSpan(
                              text: " . ${DateTime.tryParse(model.releaseDate ?? "")!
                                      .year}",
                            ),
                          ],
                        ),
                      ),
                    ),

                    90.verticalSpace,
                  ],
                ),
              ],
            ),
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
          ],
        ),
      ],
    );
  }
}
