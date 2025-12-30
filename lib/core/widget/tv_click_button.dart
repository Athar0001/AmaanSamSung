import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/widget/radio%20button/radio_button_multi_select_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TvClickButton extends StatelessWidget {
  const TvClickButton({super.key, required this.child, required this.onTap});

  final Widget child;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Focus(onKeyEvent: (node, event) {
      if (event is KeyDownEvent &&
          (event.logicalKey == LogicalKeyboardKey.enter ||
              event.logicalKey == LogicalKeyboardKey.select)) {
        onTap();
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    }, child: Builder(
      builder: (context) {
        final focused = Focus.of(context).hasFocus;
        return GestureDetector(
          onTap: () {
            onTap();
          },
          child: DecoratedBox(
            decoration: containerDecoration(context,
                borderColor: focused ? AppColorsNew.white : null),
            child: child,
          ),
        );
      },
    ));
  }
}
