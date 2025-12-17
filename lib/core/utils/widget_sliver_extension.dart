import 'package:flutter/material.dart';

extension WidgetSliverExtension on Widget {
  Widget isSliver(bool isSliver) {
    if (isSliver) {
      return SliverToBoxAdapter(child: this);
    }
    return this;
  }

  Widget get sliver => SliverToBoxAdapter(child: this);
}
