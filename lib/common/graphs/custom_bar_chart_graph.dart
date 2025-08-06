import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomBarChartPainter extends CustomPainter {
  final List<double> yValues;
  final List<BarData> data;
  final Color barColor;
  final BuildContext context;

  CustomBarChartPainter({
    required this.data,
    required this.barColor,
    required this.yValues,
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint barPaint = Paint()..color = barColor;
    final double barWidth = size.width / (data.length * 2.2); // Adjust bar spacing
    final double chartHeight = size.height;
    final double chartWidth = size.width;
    const double padding = 0.0;
    // final double axisWidth = chartWidth - 2 * padding;
    final double axisHeight = chartHeight - 2 * padding;

    final Paint axisPaint = Paint()
      ..color = const Color(0xff665252)
      ..strokeWidth = 1.5.px;

    final TextPainter yTextPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Draw X and Y axes
    final Offset bottomLeft = Offset(padding, chartHeight - padding);
    const Offset topLeft = Offset(padding, padding);
    final Offset bottomRight = Offset(chartWidth - padding, chartHeight - padding);

    canvas.drawLine(bottomLeft, bottomRight, axisPaint); // X-axis
    canvas.drawLine(bottomLeft, topLeft, axisPaint); // Y-axis

    // Draw Y-axis dashed lines, labels, and points
    for (int i = 0; i < yValues.length; i++) {
      final double yValue = yValues[i];
      final double yPosition =
          chartHeight - padding - (yValue / yValues.max()) * axisHeight;

      final Paint dashedLinePaint = Paint()
        ..strokeWidth = 1.px
        ..color = const Color(0xff665252)
        ..style = PaintingStyle.stroke;

      final Paint pointPaint = Paint()
        ..color = const Color(0xff665252)
        ..strokeWidth = 1.px;

      // Draw dashed line
      if (i != 0) {
        _drawDashedLine(
          canvas,
          Offset(padding, yPosition),
          Offset(chartWidth - padding, yPosition),
          dashedLinePaint,
        );
      }

      // Draw small horizontal line (point)
      canvas.drawLine(
        Offset(padding - 10, yPosition), // Start slightly left of Y-axis
        Offset(padding, yPosition), // End at the Y-axis
        pointPaint,
      );

      // Draw Y-axis labels
      yTextPainter.text = TextSpan(
        text: yValue.toStringAsFixed(0),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.0,color: const Color(0xff665252)),
      );
      yTextPainter.layout();
      yTextPainter.paint(
        canvas,
        Offset(padding - 24, yPosition - yTextPainter.height / 2),
      );
    }

    // Find max value for scaling
    final int maxValue = data.map((d) => d.value).reduce((a, b) => a > b ? a : b);

    // Draw bars
    for (int i = 0; i < data.length; i++) {
      final double left = padding + i * 2.2 * barWidth + barWidth / 2;
      final double right = left + barWidth;
      final double barHeight = (data[i].value / maxValue) * axisHeight;
      final double top = chartHeight - padding - barHeight;
      if(i!=0) {
        canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTRB(left, top, right, chartHeight - padding-1),
          topLeft: Radius.circular(4.px), // Top-left corner radius
          topRight: Radius.circular(4.px), // Top-right corner radius
          bottomLeft: Radius.zero, // Bottom-left corner no radius
          bottomRight: Radius.zero, // Bottom-right corner no radius
        ),
        barPaint,
      );
      }
      // canvas.drawRRect(
      //   RRect.fromRectAndRadius(
      //     Rect.fromLTRB(left, top, right, chartHeight - padding),
      //     const Radius.circular(4),
      //   ),
      //   barPaint,
      // );
    }

    // Draw bar labels
    final TextPainter labelPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );


    // Draw X-axis labels
    for (int i = 0; i < data.length; i++) {
      final Paint pointPaint = Paint()
        ..color = const Color(0xff665252)
        ..strokeWidth = 1.px;

      final double xPosition = padding + i * 2.2 * barWidth + barWidth;

      // Draw small vertical lines (points)
      if(i != 0) {
        canvas.drawLine(
          Offset(xPosition, chartHeight - padding - 0.px), // Start slightly above the axis
          Offset(xPosition, chartHeight - padding + 10.px), // End slightly below the axis
          pointPaint,
        );
        final String label = data[i].label;
        labelPainter.text = TextSpan(
          text: label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.px,color: const Color(0xff665252)),
        );
        labelPainter.layout();
        final double xCenter = padding + i * 2.2 * barWidth + barWidth;
        final double yPosition = chartHeight - padding + 10;
        labelPainter.paint(
          canvas,
          Offset(xCenter - labelPainter.width / 2, yPosition),
        );
      }
    }
  }

  // Method to draw dashed lines
  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const double dashWidth = 5.0;
    const double dashSpace = 1.0;

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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Extension for finding max in list
extension ListUtils on List<double> {
  double max() => isEmpty ? 1 : reduce((a, b) => a > b ? a : b);
}

class BarData {
  final int value;
  final String label;

  BarData({required this.value, required this.label});
}
