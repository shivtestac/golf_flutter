import 'package:flutter/material.dart';

class StrokesGainedGraphPainter extends CustomPainter {
  final List<double> dataPoints;
  final int highlightedIndex;
  final BuildContext context;

  StrokesGainedGraphPainter({
    required this.dataPoints,
    required this.highlightedIndex,
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = const Color(0xffFF0023)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final Paint fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.primary,
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final Path linePath = Path();
    final Path fillPath = Path();

    final double step = size.width / (dataPoints.length - 1);

    // Create the line and fill paths
    for (int i = 0; i < dataPoints.length; i++) {
      final double x = i * step;
      final double y = size.height - (dataPoints[i] * size.height * 0.2);

      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, size.height); // Start from bottom
        fillPath.lineTo(x, y); // Move to the curve
      } else {
        linePath.lineTo(x, y);
        fillPath.lineTo(x, y); // Add curve points to fill path
      }
    }

    // Close the fill path at the bottom
    fillPath.lineTo(size.width, size.height); // End at bottom-right
    fillPath.lineTo(0, size.height); // Go back to bottom-left
    fillPath.close();

    // Draw the filled gradient area
    canvas.drawPath(fillPath, fillPaint);

    // Draw the curve line
    canvas.drawPath(linePath, linePaint);

    // Draw the highlighted circle
    // final double highlightX = highlightedIndex * step;
    // final double highlightY = size.height - (dataPoints[highlightedIndex] * size.height * 0.2);
    // canvas.drawCircle(
    //   Offset(highlightX, highlightY),
    //   8,
    //   Paint()..color = const Color(0xffFF6E04),
    // );

    // Highlight circle with border
    final double highlightX = highlightedIndex * step;
    final double highlightY =
        size.height - (dataPoints[highlightedIndex] * size.height * 0.2);
// Outer circle for the border
    canvas.drawCircle(
      Offset(highlightX, highlightY),
      10, // Slightly larger radius for the border
      Paint()
        ..color = Theme.of(context).scaffoldBackgroundColor // Border color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3, // Border thickness
    );

// Inner circle for the fill
    canvas.drawCircle(
      Offset(highlightX, highlightY),
      8, // Slightly smaller radius for the fill
      Paint()..color = const Color(0xffFF6E04), // Fill color
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}