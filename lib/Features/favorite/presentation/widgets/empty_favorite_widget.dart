import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:flutter/cupertino.dart';

class EmptyFavoriteWidget extends StatelessWidget {
  const EmptyFavoriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(child: Image.asset('assets/images/emptyFavorite.png')),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Text(AppLocalization.strings.notFoundFavorites,
                style: AppTextStylesNew.style20BoldAlmarai),
          ),
        ),
        Text(
          AppLocalization.strings.addYourFavorite,
          style: AppTextStylesNew.style16RegularAlmarai,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
