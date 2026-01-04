import 'dart:developer';

import 'package:amaan_tv/Features/Home/data/models/home_categories_model/categories.dart';
import 'package:amaan_tv/Features/Home/data/models/sub_categories_model/image.dart';
import 'package:amaan_tv/Features/favorite/presentation/widgets/favorite_shows_widget.dart';
import 'package:amaan_tv/Features/favorite/presentation/widgets/favorites_characters_widget.dart';
import 'package:amaan_tv/Features/stories/widgets/listview_header_widget.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/widget/scaffold_gradient_background.dart';
import 'package:amaan_tv/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/Themes/app_text_styles_new.dart';
import '../../../../core/widget/buttons/back_button.dart';
import '../widgets/favorite_episodes_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key, this.childId});

  final String? childId;

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int selectedIndex = 0;

  List<Category> categories = [
    Category(
      image: ForgroundImage(presignedUrl: Assets.images.episodesPng.path),
      backgroundImage: ForgroundImage(presignedUrl: Assets.images.favBg.path),
      name: AppLocalization.strings.episodes,
    ),
    Category(
      image: ForgroundImage(presignedUrl: Assets.images.shows.path),
      backgroundImage: ForgroundImage(presignedUrl: Assets.images.favBg.path),
      name: AppLocalization.strings.seriesAndMovies,
    ),
  ];

  List<Widget> get categoriesPages => [
        FavoriteEpisodesWidget(childId: widget.childId),
        FavoriteShowsWidget(childId: widget.childId),
        FavoritesCharactersWidget(childId: widget.childId),
      ];

  @override
  Widget build(BuildContext context) {
    log(widget.childId.toString(), name: 'FavoriteScreen');

    return ScaffoldGradientBackground(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalization.strings.favorites,
          style: AppTextStylesNew.style24BoldAlmarai.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: BackButtonWidget(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListViewHeader(
              items: categories,
              fromAssets: true,
              selectedIndex: selectedIndex,
              onSelect: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
            const Gap(15),
            Expanded(
              child: categoriesPages[selectedIndex],
            ),
          ],
        ),
      ),
    );
  }
}
