import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PathPainter extends CustomPainter {
  Path path;
  PathPainter({required this.path});
  @override
  void paint(Canvas canvas, Size size) {
    // paint the line
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
