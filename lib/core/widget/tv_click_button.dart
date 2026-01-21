import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/widget/radio%20button/radio_button_multi_select_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TvClickButton extends StatelessWidget {
  const TvClickButton({
    super.key,
    this.child,
    this.builder,
    required this.onTap,
    this.onFocusChange,
    this.behavior,
    this.decoration,
    this.focusScale,
    this.focusBorderColor,
    this.focusBorderWidth = 2.0,
  })  : assert(child != null || builder != null),
        assert(child == null || builder == null);

  final Widget? child;
  final Widget Function(BuildContext context, bool hasFocus)? builder;
  final Function() onTap;
  final HitTestBehavior? behavior;
  final ValueChanged<bool>? onFocusChange;
  final BoxDecoration? decoration;
  final double? focusScale;
  final Color? focusBorderColor;
  final double focusBorderWidth;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: onFocusChange,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent &&
            (event.logicalKey == LogicalKeyboardKey.enter ||
                event.logicalKey == LogicalKeyboardKey.select)) {
          onTap();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Builder(
        builder: (context) {
          final hasFocus = Focus.of(context).hasFocus;

          final scale = hasFocus ? (focusScale ?? 1.0) : 1.0;

          final Widget content = builder?.call(context, hasFocus) ??
              DecoratedBox(
                decoration: decoration ??
                    (hasFocus && focusBorderColor != null
                        ? BoxDecoration(
                            border: Border.all(
                              color: focusBorderColor!,
                              width: focusBorderWidth,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          )
                        : containerDecoration(context,
                            borderColor: hasFocus ? AppColorsNew.white : null)),
                child: child,
              );

          if (focusScale != null) {
            return Transform.scale(
              scale: scale,
              child: GestureDetector(
                behavior: behavior,
                onTap: onTap,
                child: content,
              ),
            );
          }

          return GestureDetector(
            behavior: behavior,
            onTap: () {
              onTap();
            },
            child: content,
          );
        },
      ),
    );
  }
}
