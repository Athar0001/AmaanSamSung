import 'package:amaan_tv/Features/favorite/presentation/widgets/empty_favorite_widget.dart';
import 'package:amaan_tv/Features/favorite/provider/favorites_characters_provider.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/injection/injection_imports.dart' as di;
import 'package:amaan_tv/core/utils/asset_manager.dart';
import 'package:amaan_tv/core/utils/grid_config.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:amaan_tv/core/widget/circle_progress_helper.dart';
import 'package:amaan_tv/core/widget/icon_widget.dart';
import 'package:amaan_tv/gen/assets.gen.dart' as assets;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/Themes/app_text_styles_new.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/enum.dart';

class FavoritesCharactersWidget extends StatefulWidget {
  const FavoritesCharactersWidget({super.key, this.childId});

  final String? childId;
  @override
  State<FavoritesCharactersWidget> createState() =>
      _FavoritesCharactersWidgetState();
}

class _FavoritesCharactersWidgetState extends State<FavoritesCharactersWidget> {
  // Helper to safely get a displayable name
  String _characterDisplayName(character) {
    final raw = character.name;
    if (raw == null) return '';
    // Collapse whitespace & remove accidental "null" strings
    final sanitized = raw.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (sanitized.isEmpty || sanitized.toLowerCase() == 'null') return '';
    return sanitized;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoritesCharactersProvider>(
      create: (_) => di.sl()..getFavoritesCharacters(childId: widget.childId),
      child: Consumer<FavoritesCharactersProvider>(
        builder: (context, favoriteProvider, child) {
          return favoriteProvider.favoriteState == AppState.loading
              ? AppCircleProgressHelper()
              : (favoriteProvider.favoriteState == AppState.success &&
                      favoriteProvider.charactersModel?.data.isEmpty == true)
                  ? EmptyFavoriteWidget()
                  : favoriteProvider.favoriteState == AppState.success
                      ? GridView.builder(
                            shrinkWrap: true,
                            padding: GridConfig.getDefaultPadding(),
                            gridDelegate: GridConfig.getDefaultGridDelegate(),
                            itemBuilder: (context, index) {
                              final character =
                                  favoriteProvider.charactersModel!.data[index];
                              return GestureDetector(
                                onTap: () async {
                                  final isFav = await context.pushNamed<bool>(
                                    'character',
                                    extra: character,
                                  );
                                  if (isFav == false) {
                                    favoriteProvider.removeCharacter(character);
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF164B80),
                                            Color(0xFF2C4D6D),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(18.r),
                                      ),
                                    ),
                                    if (character.image?.url == null)
                                      Padding(
                                        padding: EdgeInsets.only(top: 30.r),
                                        child: assets.Assets.images.character
                                            .image(),
                                      )
                                    else
                                      Container(
                                        margin: EdgeInsets.only(top: 40.r),
                                        decoration: BoxDecoration(
                                          image: decorationImageHelper(
                                            character.image?.url,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(18.r),
                                        ),
                                      ),
                                    // Updated name widget with overflow handling
                                    PositionedDirectional(
                                      top: 8.r,
                                      start: 0.r,
                                      end: 24.r,
                                      child: Text(
                                        _characterDisplayName(character),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStylesNew
                                            .style18BoldAlmarai
                                            .copyWith(
                                          color: AppColorsNew.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                    PositionedDirectional(
                                      top: 1,
                                      end: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          favoriteProvider
                                              .removeCharacter(character);
                                        },
                                        child: IconWidget(
                                          isBlack: false,
                                          iconHeight: 18.h,
                                          iconWidth: 18.w,
                                          iconColor: AppColorsNew.primary,
                                          path: character.isFavorite.value
                                              ? Assets.imagesTrueHeart
                                              : Assets.imagesTrueHeart,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount:
                                favoriteProvider.charactersModel?.data.length,
                          )
                      : const SizedBox.shrink();
        },
      ),
    );
  }
}
