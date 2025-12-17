import 'package:flutter/material.dart';

class BottomCurveClipper extends CustomClipper<Path> {
  final double deepCurve;

  const BottomCurveClipper({this.deepCurve = 0.0});

  @override
  Path getClip(Size size) {
    return Path();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
