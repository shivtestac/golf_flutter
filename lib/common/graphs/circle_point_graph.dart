import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class IntersectionDiagramPainter extends CustomPainter {
  final ui.Image flagImage;
  final BuildContext context;

  IntersectionDiagramPainter({required this.flagImage,required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    final Paint linePaint = Paint()
      ..color = Theme.of(context).colorScheme.surface
      ..strokeWidth = 1;

    final Paint pointPaint = Paint()
      ..color = Theme.of(context).colorScheme.onPrimary
      ..style = PaintingStyle.fill;

    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Number of flags (nodes)
    const int flagCount = 6; // Number of flags around the circle
    const double angleStep = 2 * pi / flagCount;

    // Calculate positions for flags
    List<Offset> flagPositions = [];
    for (int i = 0; i < flagCount; i++) {
      double angle = i * angleStep - pi / 2; // Start at the top of the circle
      double x = center.dx + radius * cos(angle);
      double y = center.dy + radius * sin(angle);
      flagPositions.add(Offset(x, y));

      // Draw flags as images
      const double imageSize = 24; // Size of the image
      canvas.drawImageRect(
        flagImage,
        Rect.fromLTWH(0, 0, flagImage.width.toDouble(), flagImage.height.toDouble()), // Source rect
        Rect.fromCenter(
          center: Offset(x, y - 20), // Position the flag
          width: imageSize,
          height: imageSize,
        ),
        Paint(),
      );

      // Add flag labels
      textPainter.text = TextSpan(
        text: "${i + 1}",
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
          fontSize: 8.px,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y + 10),
      );
    }

    // Draw crossing lines and calculate intersection points
    List<Offset> intersectionPoints = [];
    List<String> pointNames = []; // Store names for intersection points
    int pointCounter = 1; // Start naming points from 1

    for (int i = 0; i < flagPositions.length; i++) {
      for (int j = i + 2; j < flagPositions.length; j++) {
        // Skip adjacent points for cleaner crossing
        canvas.drawLine(flagPositions[i], flagPositions[j], linePaint);

        // Calculate intersection points
        final Offset p1 = flagPositions[i];
        final Offset p2 = flagPositions[j];

        for (int k = 0; k < flagPositions.length; k++) {
          for (int m = k + 2; m < flagPositions.length; m++) {
            final Offset q1 = flagPositions[k];
            final Offset q2 = flagPositions[m];

            // Find intersection point between lines (p1, p2) and (q1, q2)
            final intersection = getIntersectionPoint(p1, p2, q1, q2);

            // If an intersection exists and is unique, save it
            if (intersection != null &&
                !intersectionPoints.contains(intersection)) {
              intersectionPoints.add(intersection);
              pointNames.add("P$pointCounter"); // Add a name for the point
              pointCounter++;
            }
          }
        }
      }
    }

    // Draw intersection points with labels
    for (int i = 0; i < intersectionPoints.length; i++) {
      final point = intersectionPoints[i];
      final pointName = pointNames[i];

      // Draw the point
      canvas.drawCircle(point, 4, pointPaint);

      // Add the point name
      textPainter.text = TextSpan(
        text: pointName,
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
          fontSize: 8.px,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(point.dx + 5, point.dy - 5), // Adjust position of the label
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  // Function to calculate intersection of two lines (returns null if lines don't intersect)
  Offset? getIntersectionPoint(Offset p1, Offset p2, Offset q1, Offset q2) {
    final double a1 = p2.dy - p1.dy;
    final double b1 = p1.dx - p2.dx;
    final double c1 = a1 * p1.dx + b1 * p1.dy;

    final double a2 = q2.dy - q1.dy;
    final double b2 = q1.dx - q2.dx;
    final double c2 = a2 * q1.dx + b2 * q1.dy;

    final double determinant = a1 * b2 - a2 * b1;

    // If determinant is zero, lines are parallel
    if (determinant == 0) {
      return null;
    } else {
      final double x = (b2 * c1 - b1 * c2) / determinant;
      final double y = (a1 * c2 - a2 * c1) / determinant;
      return Offset(x, y);
    }
  }
}