import 'package:flutter/widgets.dart';

extension BuildContextExt on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;

  double get width => MediaQuery.sizeOf(this).width;
}
