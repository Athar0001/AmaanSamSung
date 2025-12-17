import 'package:flutter/material.dart';

class BlackAndWhiteWidget extends StatelessWidget {
  const BlackAndWhiteWidget({
    required this.child, required this.isNoColors, super.key,
  });

  final Widget child;
  final bool isNoColors;

  @override
  Widget build(BuildContext context) {
    final blackAndWhite = const ColorFilter.matrix(<double>[
      0.3, 0.59, 0.11, 0, 0, // Red channel
      0.3, 0.59, 0.11, 0, 0, // Green channel
      0.3, 0.59, 0.11, 0, 0, // Blue channel
      0, 0, 0, 1, 0, // Alpha channel
    ]);
    return ColorFiltered(
      colorFilter: isNoColors
          ? blackAndWhite
          : const ColorFilter.mode(Colors.transparent, BlendMode.dst),
      child: child,
    );
  }
}
