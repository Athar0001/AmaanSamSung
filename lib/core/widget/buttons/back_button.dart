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
    return IconContainer(
      isBlack: isBlack,
      result: result,
      child: BackButton(
        style: ButtonStyle(padding: WidgetStateProperty.all(EdgeInsets.zero)),
        color: isBlack ? AppColorsNew.white : null,
        onPressed:
            onPressed ??
            () {
              context.pop(result);
            },
      ),
    );
  }
}
