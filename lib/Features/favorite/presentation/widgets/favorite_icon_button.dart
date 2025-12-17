import 'package:flutter/material.dart';

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
      return GestureDetector(onTap: onPressed, child: builder!(isFavorite));
    }
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: onPressed,
    );
  }
}
