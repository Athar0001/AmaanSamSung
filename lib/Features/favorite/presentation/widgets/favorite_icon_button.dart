import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';

class FavoriteIconButton extends StatelessWidget {
  final dynamic model;
  final Widget Function(bool isFavorite)? builder;
  final VoidCallback? onPressed;
  final bool isFavorite;

  const FavoriteIconButton(
    this.model, {
    super.key,
    this.builder,
    this.onPressed,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    if (builder != null) {
      return TvClickButton(
          onTap: onPressed ?? () {}, child: builder!(isFavorite));
    }
    return TvClickButton(
      onTap: onPressed ?? () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ),
      ),
    );
  }
}
