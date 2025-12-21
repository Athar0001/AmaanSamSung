import 'package:flutter/material.dart';

// Custom clipper for bottom curve
class BottomCurveClipper extends CustomClipper<Path> {

  BottomCurveClipper({required this.deepCurve, super.reclip});
  final double deepCurve;

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - deepCurve); // Start from bottom left

    // Draw curve
    path.quadraticBezierTo(
      size.width / 2, size.height, // Control point
      size.width, size.height - deepCurve, // End point
    );

    path.lineTo(size.width, 0); // Move to top right
    path.close(); // Complete the path
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
