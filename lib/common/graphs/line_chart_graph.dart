import 'package:flutter/material.dart';

class SingleLineChartPainter extends CustomPainter {
  final List<double> yValues;
  final List<String> xLabels;
  final BuildContext context;

  SingleLineChartPainter({required this.context, required this.yValues, required this.xLabels});

  @override
  void paint(Canvas canvas, Size size) {
    final double chartHeight = size.height;
    final double chartWidth = size.width;
    const double padding = 24.0; // Padding for labels and margins
    final double axisWidth = chartWidth - 2 * padding;
    final double axisHeight = chartHeight - 2 * padding;

    final Paint axisPaint = Paint()
      ..color = const Color(0xff665252)
      ..strokeWidth = 0.5;

    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Calculate the position of the X-axis at the 0-point on the Y-axis
    final double maxY = yValues.max();
    final double minY = yValues.min();
    final double rangeY = maxY - minY;
    final double zeroPosition = chartHeight - padding - (0 - minY) / rangeY * axisHeight; // Y=0 position

    // Draw the X and Y axes
    final Offset bottomLeft = Offset(padding, chartHeight - padding);
    const Offset topLeft = Offset(padding, padding);
    final Offset bottomRight = Offset(chartWidth - padding, chartHeight - padding);

    // Draw Y-axis
    canvas.drawLine(bottomLeft, topLeft, axisPaint);

    // Draw X-axis at 0 point
    canvas.drawLine(Offset(padding, zeroPosition), Offset(chartWidth - padding, zeroPosition), axisPaint); // X-axis at Y=0

    // Draw dynamic Y-axis lines
    const int numberOfLines = 10; // Number of lines on Y-axis
    for (int i = 0; i <= numberOfLines; i++) {
      final double value = minY + (rangeY / numberOfLines) * i;
      final double yPosition = chartHeight - padding - (value - minY) / rangeY * axisHeight;

      // Y-axis line (extend in both directions)
      final Paint yLinePaint = Paint()
        ..color = const Color(0xff665252)
        ..strokeWidth = 0.5;

      // Draw dashed Y-axis lines
      if (i != 0) {
        _drawDashedLine(
          canvas,
          Offset(padding, yPosition),
          Offset(chartWidth - padding, yPosition),
          yLinePaint,
        );
      }

      // Draw Y-axis labels
      textPainter.text = TextSpan(
        text: value.toStringAsFixed(0),
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontSize: 8,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(padding - 24, yPosition - 6));
    }

    // Draw X-axis labels
    final double spacing = axisWidth / (xLabels.length - 1);
    for (int i = 0; i < xLabels.length; i++) {
      final Paint pointPaint = Paint()
        ..color = const Color(0xff665252)
        ..strokeWidth = 1;

      final double xPosition = padding + i * spacing;

      // Draw small vertical lines (points)
      if (i != 0) {
        canvas.drawLine(
          Offset(xPosition, zeroPosition - 5),
          Offset(xPosition, zeroPosition + 5),
          pointPaint,
        );
      }

      textPainter.text = TextSpan(
        text: xLabels[i],
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontSize: 8,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(xPosition - textPainter.width / 2, zeroPosition + 12));
    }
  }

  // Method to draw dashed lines
  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    double dashWidth = 3.0;
    double dashSpace = 3.0;

    final double totalLength = (end - start).distance;
    final int dashCount = (totalLength / (dashWidth + dashSpace)).floor();
    final double dx = (end.dx - start.dx) / dashCount;
    final double dy = (end.dy - start.dy) / dashCount;

    for (int i = 0; i < dashCount; i++) {
      if (i % 2 == 0) {
        final Offset dashStart = Offset(start.dx + i * dx, start.dy + i * dy);
        final Offset dashEnd = Offset(start.dx + (i + 1) * dx, start.dy + (i + 1) * dy);
        // canvas.drawLine(dashStart, dashEnd, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

extension ListUtils on List<double> {
  double max() => isEmpty ? 1 : reduce((a, b) => a > b ? a : b);

  double min() => isEmpty ? 0 : reduce((a, b) => a < b ? a : b);
}