import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LineChartPainter extends CustomPainter {
  final List<double> yValues;
  final List<String> xLabels;
  final BuildContext context;

  LineChartPainter({required this.context, required this.yValues, required this.xLabels});

  @override
  void paint(Canvas canvas, Size size) {
    final double chartHeight = size.height;
    final double chartWidth = size.width;
    final double padding = 24.px; // Padding for labels and margins
    final double axisWidth = chartWidth - 2.px * padding;
    final double axisHeight = chartHeight - 2.px * padding;

    final Paint axisPaint = Paint()
      // ..color = Theme.of(context).colorScheme.surface
      ..color = const Color(0xff665252)
      ..strokeWidth = .5.px;

    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Draw the X and Y axes
    final Offset bottomLeft = Offset(padding, chartHeight - padding);
    final Offset topLeft = Offset(padding, padding);
    final Offset bottomRight = Offset(chartWidth - padding, chartHeight - padding);

    canvas.drawLine(bottomLeft, bottomRight, axisPaint); // X-axis
    canvas.drawLine(bottomLeft, topLeft, axisPaint); // Y-axis

    // Dynamic Colors for Y-axis lines and points
    final List<Color> colorPalette = [Colors.red, Colors.green, Colors.blue, Colors.orange, Colors.purple];
    final List<Color> yLineColors = List.generate(
      yValues.length, (index) => colorPalette[index % colorPalette.length], // Cycle through colors
    );

    // Draw Y-axis dashed lines and points
    for (int i = 0; i < yValues.length; i++) {
      final double yValue = yValues[i];
      final double yPosition = chartHeight - padding - (yValue / yValues.max()) * axisHeight;

      final Paint dashedLinePaint = Paint()
        ..strokeWidth = 2.px
        ..color = yLineColors[i]
        ..style = PaintingStyle.stroke;

      final Paint pointPaint = Paint()
      // ..color = yLineColors[i]
        ..color = const Color(0xff665252)
        ..strokeWidth = 1.px;

      // Draw dashed line
      if(i != 0) {
        _drawDashedLine(canvas, Offset(padding, yPosition), Offset(chartWidth - padding, yPosition), dashedLinePaint);
      }

      // Draw small horizontal line (point)
      canvas.drawLine(
        Offset(padding - 12.px, yPosition), // Start slightly to the left of the axis
        Offset(padding, yPosition), // End slightly to the right of the axis
        pointPaint,
      );

      // Draw Y-axis labels
      textPainter.text = TextSpan(
        text: yValue.toStringAsFixed(0),
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontSize: 8.px,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(padding - 24.px, yPosition - 6.px));
    }

    // Draw X-axis labels
    final double spacing = axisWidth / (xLabels.length - 1.px);
    for (int i = 0; i < xLabels.length; i++) {
      final Paint pointPaint = Paint()
      // ..color = yLineColors[i]
        ..color = const Color(0xff665252)
        ..strokeWidth = 1.px;

      final double xPosition = padding + i * spacing;

      // Draw small vertical lines (points)
      if(i != 0) {
        canvas.drawLine(
          Offset(xPosition, chartHeight - padding - 0.px), // Start slightly above the axis
          Offset(xPosition, chartHeight - padding + 10.px), // End slightly below the axis
          pointPaint,
        );
      }

      textPainter.text = TextSpan(
        text: xLabels[i],
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontSize: 8.px,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(xPosition - textPainter.width / 2.px, chartHeight - padding + 18.px));
    }
  }

  // Method to draw dashed lines
  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    double dashWidth = 3.px;
    double dashSpace = 3.px;

    final double totalLength = (end - start).distance;
    final int dashCount = (totalLength / (dashWidth + dashSpace)).floor();
    final double dx = (end.dx - start.dx) / dashCount;
    final double dy = (end.dy - start.dy) / dashCount;

    for (int i = 0; i < dashCount; i++) {
      if (i % 2 == 0) {
        final Offset dashStart = Offset(start.dx + i * dx, start.dy + i * dy);
        final Offset dashEnd = Offset(start.dx + (i + 1) * dx, start.dy + (i + 1) * dy);
        canvas.drawLine(dashStart, dashEnd, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

extension ListUtils on List<double> {
  double max() => isEmpty ? 1 : reduce((a, b) => a > b ? a : b);
}
