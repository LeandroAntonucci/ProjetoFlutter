import 'package:flutter/material.dart';

class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    final curveHeight = size.height * 0.25; // 🔥 relativo

    path.lineTo(0, size.height - curveHeight);

    path.quadraticBezierTo(
      size.width * 0.5,
      size.height,
      size.width,
      size.height - curveHeight,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}