import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/widget/radio%20button/radio_button_multi_select_package.dart';

class MoreWidget extends StatelessWidget {
  const MoreWidget({required this.model, super.key, this.seasons, this.epsNum});
  final Details model;
  final int? seasons;
  final int? epsNum;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 24.r),
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: containerDecoration(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.type.isSeries
                    ? AppLocalization.strings.aboutSeries
                    : AppLocalization.strings.aboutFilm,
                style: AppTextStylesNew.style16BoldAlmarai,
              ),
              24.verticalSpace,
              Wrap(
                spacing: 16.r,
                runSpacing: 8.r,
                children: [
                  if (seasons != null)
                    Dots(
                      text: getSeasonsText(seasons ?? 0),
                    ),
                  if (epsNum != null)
                    Dots(
                      text: getEpisodesText(epsNum ?? 0),
                    ),
                  Dots(
                    text: model.genres!.map((genre) => genre.name).join(' . '),
                  ),
                ],
              ),
              16.verticalSpace,
              Text(model.description ?? '',
                  style: AppTextStylesNew.style12RegularAlmarai.copyWith(
                    color: Theme.of(context).textTheme.labelSmall?.color,
                  )),
              24.verticalSpace,
              Text(
                AppLocalization.strings.characters,
                style: AppTextStylesNew.style14RegularAlmarai.copyWith(
                  color: Theme.of(context).textTheme.labelSmall?.color,
                ),
              ),
              16.verticalSpace,
              Text(model.characters!.map((heroes) => heroes.name).join(' ، '),
                  style: AppTextStylesNew.style14RegularAlmarai),
              24.verticalSpace,
              Text(
                AppLocalization.strings.yearProduction,
                style: AppTextStylesNew.style14RegularAlmarai.copyWith(
                  color: Theme.of(context).textTheme.labelSmall?.color,
                ),
              ),
              16.verticalSpace,
              RichText(
                  text: TextSpan(
                      style: AppTextStylesNew.style14RegularAlmarai,
                      children: [
                    TextSpan(
                      text: AppLocalization.strings.amaan,
                      style: AppTextStylesNew.style14BoldAlmarai.copyWith(
                        color: AppColorsNew.primary,
                      ),
                    ),
                    TextSpan(
                        text: " . ${DateTime.tryParse(model.releaseDate ?? "")!
                                .year}",
                        style: AppTextStylesNew.style14RegularAlmarai.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        )),
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}

class Dots extends StatelessWidget {
  const Dots({
    required this.text, super.key,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Make the row only take necessary space
      children: [
        Container(
          width: 5.r,
          height: 5.r,
          decoration: BoxDecoration(
            color: AppColorsNew.primary,
            shape: BoxShape.circle,
          ),
        ),
        4.horizontalSpace,
        Flexible(
          child: Text(
            text,
            style: AppTextStylesNew.style14RegularAlmarai,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// For episodes
String getEpisodesText(int count) {
  if (count == 1) {
    return AppLocalization.strings.oneEpisode;
  } else if (count == 2) {
    return AppLocalization.strings.twoEpisodes;
  } else if (count >= 3 && count <= 10) {
    return '$count ${AppLocalization.strings.episodess}';
  } else {
    return AppLocalization.strings.oneEpisode;
  }
}

// For seasons
String getSeasonsText(int count) {
  if (count == 1) {
    return AppLocalization.strings.oneSeason;
  } else if (count == 2) {
    return AppLocalization.strings.twoSeasons;
  } else if (count >= 3 && count <= 10) {
    return '$count ${AppLocalization.strings.seasonsShow}';
  } else {
    return AppLocalization.strings.oneSeason;
  }
}
