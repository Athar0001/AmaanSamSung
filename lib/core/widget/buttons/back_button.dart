import 'package:flutter/material.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:go_router/go_router.dart';
import 'package:amaan_tv/core/widget/buttons/icon_container.dart';

class BackButtonWidget<T> extends StatelessWidget {
  const BackButtonWidget({
    super.key,
    this.isBlack = false,
    this.result,
    this.onPressed,
  });

  final bool isBlack;
  final T? result;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        width: 40,
        child: IconContainer(
          isBlack: isBlack,
          result: result,
          onTap: onPressed ?? () => context.pop(result),
          child: Icon(
            Icons.arrow_back,
            color: isBlack ? AppColorsNew.white : null,
          ),
        ),
      ),
    );
  }
}
