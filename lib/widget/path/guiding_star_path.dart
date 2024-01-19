//爱心剪切
import 'package:flutter/material.dart';

class GuidingStarClipper extends CustomClipper<Path> {
  const GuidingStarClipper();

  @override
  Path getClip(Size size) {
    final leftPath = Path();
    final rightPath = Path();
    Path path = Path();
    double centerX = 0;
    leftPath.moveTo(0, 0);
    centerX = size.width * 0.5;
    leftPath.moveTo(centerX, size.height);
    leftPath.cubicTo(centerX - (size.width * 0.69), size.height * 0.66, centerX - (size.width * 0.35),
        size.height * 0.25, centerX, size.height * 0.48);
    // 右半爱心
    rightPath.moveTo(centerX, size.height);
    rightPath.cubicTo(centerX + (size.width * 0.69), size.height * 0.66, centerX + (size.width * 0.35),
        size.height * 0.25, centerX, size.height * 0.48);
    path = Path.combine(PathOperation.union, leftPath, rightPath);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}