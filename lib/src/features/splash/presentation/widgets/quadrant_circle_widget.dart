import 'dart:math';
import 'package:flutter/material.dart';
import 'package:onix_app/src/core/utils/app_colors.dart';

class QuadrantCircleWidget extends StatelessWidget {
  const QuadrantCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(400, 400),
      painter: QuadrantCirclePainter(),
    );
  }
}

class QuadrantCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = min(size.width, size.height) / 2;

    Paint paint = Paint()
      ..color = AppColors.redColor
      ..style = PaintingStyle.fill;

    canvas.save();
    canvas.translate(radius, size.height - radius);
    canvas.rotate(pi / 2);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(-200, 20), radius: radius),
      0,
      pi / 2,
      true,
      paint,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
