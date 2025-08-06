import 'dart:math';

import 'package:flutter/material.dart';

class GradientCircularProgressIndicator extends StatefulWidget {
  const GradientCircularProgressIndicator({super.key});

  @override
  _GradientCircularProgressIndicatorState createState() => _GradientCircularProgressIndicatorState();
}

class _GradientCircularProgressIndicatorState extends State<GradientCircularProgressIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: Size(20, 20),
            painter: CircularProgressPainter(_controller.value,context),
          );
        },
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final BuildContext context;

  CircularProgressPainter(this.progress,this.context);

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 4.0;
    Rect rect = Offset.zero & size;

    // Define gradient colors and start/end points for the progress arc
    Paint progressPaint = Paint()
      ..shader = SweepGradient(
        colors: [Theme.of(context).scaffoldBackgroundColor.withOpacity(0), Theme.of(context).colorScheme.error],
        stops: const [0.0, 1.0],
        startAngle: 0.0,
        endAngle: 2 * pi,
        transform: GradientRotation(2 * pi * progress), // Rotate gradient
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    // Draw the rotating gradient arc
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -pi / 2, // start angle
      2 * pi, // full circle for infinite animation
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}