import 'package:flutter/material.dart';
import 'package:amaan_tv/core/helpers/extentions/context.dart';
import 'package:amaan_tv/core/utils/constant.dart';
import 'package:amaan_tv/core/widget/responsive/models/responsive_sizes.dart';

class ResponsiveSizeBuilder<T> extends StatelessWidget {
  const ResponsiveSizeBuilder({
    required this.sizes, required this.builder, super.key,
  });

  final ResponsiveSizes<T> sizes;
  final Widget Function(BuildContext context, T size) builder;

  @override
  Widget build(BuildContext context) {
    if (context.width > Constant.largeScreenWidth) {
      return builder(context, sizes.large);
    } else if (context.width > Constant.mediumScreenWidth) {
      return builder(context, sizes.medium);
    } else {
      return builder(context, sizes.small);
    }
  }
}
