import 'dart:math';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LineWithDistancePainter extends CustomPainter {
  final List<Offset> points;
  final BuildContext context;

  LineWithDistancePainter({required this.points, required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..color = Theme.of(context).colorScheme.onPrimary
      ..strokeWidth = 2.px;

    Paint backgroundPaint = Paint()
      ..color = Theme.of(context).colorScheme.onPrimary
      ..style = PaintingStyle.fill;

    TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < points.length - 1; i++) {
      // Draw line
      canvas.drawLine(points[i], points[i + 1], linePaint);

      // Calculate distance
      double distance = calculateDistance(points[i], points[i + 1]);

      // Find midpoint
      Offset midPoint = Offset(
        (points[i].dx + points[i + 1].dx) / 2.px,
        (points[i].dy + points[i + 1].dy) / 2.px,
      );

      // Format distance text
      String distanceText = "${distance.toStringAsFixed(1)} yd";

      // Set up text painter
      textPainter.text = TextSpan(
        text: distanceText,
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
      );
      textPainter.layout();

      // Calculate background rect
      double padding = 8.px;
      Rect backgroundRect = Rect.fromLTWH(
        midPoint.dx - textPainter.width / 2.px - padding,
        midPoint.dy - textPainter.height / 2.px - padding / 2.px,
        textPainter.width + 2.px * padding,
        textPainter.height + padding,
      );

      // Draw pill-shaped background
      RRect pillBackground = RRect.fromRectAndRadius(
        backgroundRect,
        Radius.circular(16.px), // Adjust radius for the pill shape
      );
      canvas.drawRRect(pillBackground, backgroundPaint);

      // Draw text
      textPainter.paint(
        canvas,
        Offset(
          midPoint.dx - textPainter.width / 2.px,
          midPoint.dy - textPainter.height / 2.px,
        ),
      );
    }
  }

  double calculateDistance(Offset p1, Offset p2) {
    return sqrt(pow(p2.dx - p1.dx, 2.px) + pow(p2.dy - p1.dy, 2.px));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
