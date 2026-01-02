import 'package:amaan_tv/Features/favorite/provider/favorites_provider.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/injection/injection_imports.dart';
import 'package:amaan_tv/core/models/favorite_model.dart';
import 'package:amaan_tv/core/widget/icon_widget.dart';
import 'package:amaan_tv/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton(
    this.model, {
    super.key,
    this.isBlack = false,
    this.builder,
    this.onChanged,
  });

  final FavoriteModel model;
  final bool isBlack;
  final Widget Function(bool isFavorite)? builder;
  final void Function(bool isFavorite)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoritesProvider>(
      create: (context) => sl(),
      child: Consumer<FavoritesProvider>(
        builder: (context, provider, child) {
          return ValueListenableBuilder<bool>(
            valueListenable: model.isFavorite,
            builder: (context, isFavorite, child) {
              Future<void> onTap() async {
                model.isFavorite.value = !isFavorite;
                final isSuccess = await provider.updateFavorite(model: model);
                if (isSuccess) {
                  // Call onChanged only on success
                  onChanged?.call(model.isFavorite.value);
                } else {
                  // If update fails, revert the change
                  model.isFavorite.value = isFavorite;
                }
              }

              if (builder != null) {
                return GestureDetector(
                  onTap: onTap,
                  child: builder!(isFavorite),
                );
              }
              return IconWidget(
                path: isFavorite == true
                    ? Assets.images.trueHeart.path
                    : Assets.images.falseHeart.path,
                iconColor:
                    isFavorite ? AppColorsNew.primary : AppColorsNew.white,
                iconHeight: 24.r,
                iconWidth: 24.r,
                onTap: onTap,
              );
            },
          );
        },
      ),
    );
  }
}
