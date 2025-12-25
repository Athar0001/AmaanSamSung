import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../core/utils/app_localiztion.dart';

class EmptySearchWidget extends StatelessWidget {
  const EmptySearchWidget({required this.searchText, super.key});

  final String searchText;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalization.strings.noResultsFor,
          style: AppTextStylesNew.style20BoldAlmarai,
        ),
        Text(
          searchText,
          style: AppTextStylesNew.style20BoldAlmarai.copyWith(
            color: AppColorsNew.primary,
          ),
        ),
        32.verticalSpace,
        Center(child: Image.asset(Assets.images.emptySearch.path)),
        Text(
          AppLocalization.strings.dontBeSadWeCanFindIt,
          style: AppTextStylesNew.style20BoldAlmarai,
        ),
      ],
    );
  }
}
