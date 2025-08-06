import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golf_flutter/common/cp/gradient_circular_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:screenshot/screenshot.dart';
import 'package:scribble/scribble.dart';
import 'my_video_player_controller.dart';

class MyVideoPlayerScreen extends StatefulWidget {
  const MyVideoPlayerScreen({super.key});

  @override
  State<MyVideoPlayerScreen> createState() => _MyVideoPlayerScreenState();
}

class _MyVideoPlayerScreenState extends State<MyVideoPlayerScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var myVideoPlayerController = Provider.of<MyVideoPlayerController>(context);
    myVideoPlayerController.initMethod();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void deactivate() {
    super.deactivate();
    var myVideoPlayerController = Provider.of<MyVideoPlayerController>(context);
    myVideoPlayerController.isInitCalled = false;
    myVideoPlayerController.inAsyncCall = false;
    myVideoPlayerController.notifier = ScribbleNotifier();
    myVideoPlayerController.screenshotController = ScreenshotController();
    myVideoPlayerController.videoController1;
    myVideoPlayerController.videoController2;
    myVideoPlayerController.count = 0;
    myVideoPlayerController.showVs = false;
    myVideoPlayerController.isEditAble = false;
    myVideoPlayerController.selectedIconIndex = -1;
    myVideoPlayerController.iconList = [
      Icons.arrow_back_rounded,
      Icons.circle_outlined,
      Icons.square_outlined,
    ];
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyVideoPlayerController>(
      
      builder: (context, MyVideoPlayerController controller, child) {

        return Scaffold(
          body: OrientationBuilder(builder: (context,orientation){
            return SafeArea(
              child: Screenshot(
                controller: controller.screenshotController,
                child: Stack(
                  children: [
                    if(MediaQuery.of(context).orientation == Orientation.landscape)
                      if (controller.videoController1 != null)
                        Row(
                          children: [
                            controller
                                .buildVideoPlayer(controller.videoController1!),
                            if (controller.showVs &&
                                controller.videoController2 != null)
                              controller
                                  .buildVideoPlayer(controller.videoController2!),
                          ],
                        ) ,
                    if (controller.isEditAble)
                      Scribble(
                        notifier: controller.notifier,
                        drawPen: true,
                      ),
                    if(MediaQuery.of(context).orientation != Orientation.landscape)
                      if (controller.videoController1 != null)
                        Column(
                          children: [
                            controller
                                .buildVideoPlayer(controller.videoController1!),
                            if (controller.showVs &&
                                controller.videoController2 != null)
                              controller
                                  .buildVideoPlayer(controller.videoController2!),
                          ],
                        ) ,
                    if (controller.isEditAble)
                      Scribble(
                        notifier: controller.notifier,
                        drawPen: true,
                      ),
                    Positioned(
                        right: 0.px,
                        left: 0.px,
                        top: 0.px,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10.px,
                                  right: 10.px,
                                  top: 10.px,
                                  bottom: 10.px),
                              decoration:
                              const BoxDecoration(color: Colors.black26),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () => controller.clickOnCrossButton(
                                        context: context),
                                    child: Icon(
                                      Icons.close,
                                      size: 25.px,
                                      color: Colors.white,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        controller.clickScreenShotButton(),
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 25.px,
                                      color: Colors.white,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => controller.clickOnRecording(),
                                    child: Icon(
                                      controller.recording
                                          ? Icons.stop_circle_outlined
                                          : Icons.emergency_recording_outlined,
                                      size: 25.px,
                                      color: Colors.white,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => controller.clickOnSpitVideo(),
                                    child: Icon(
                                      Icons.splitscreen,
                                      size: 25.px,
                                      color: controller.showVs
                                          ? Colors.teal
                                          : Colors.white,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                     controller.clickOnScreenRotation();
                                    },
                                    child: Icon(
                                      Icons.screen_rotation,
                                      size: 25.px,
                                      color:
                                      (MediaQuery.of(context).orientation ==
                                          Orientation.landscape)
                                          ? Colors.teal
                                          : Colors.white,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.showAngle=!controller.showAngle;
                                      setState(() {

                                      });
                                    },
                                    child: Icon(
                                      Icons.text_rotation_angledown,
                                      size: 30.px,
                                      color:controller.showAngle
                                          ? Colors.teal
                                          : Colors.white,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => controller.clickOnEditAble(),
                                    child: Icon(
                                      Icons.draw,
                                      size: 25.px,
                                      color: controller.isEditAble
                                          ? Colors.teal
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (MediaQuery.of(context).orientation ==
                                Orientation.landscape)
                              if (controller.isEditAble)
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.px),
                                      color: Colors.black87),
                                  child: Row(
                                    children: markerActions(context, controller),
                                  ),
                                ),
                          ],
                        )),
                    Positioned(
                      bottom: 0.px,
                      left: 0.px,
                      right: 0.px,
                      child: controller.videoController(),
                    ),
                    if (MediaQuery.of(context).orientation !=
                        Orientation.landscape)
                      if (controller.isEditAble)
                        Positioned(
                          right: 10.px,
                          top: 40.px,
                          child: Container(
                            width: 40.px,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.px),
                                color: Colors.black87),
                            child: Column(
                              children: markerActions(context, controller),
                            ),
                          ),
                        ),

                    if(controller.showAngle)
                      Positioned(
                        left: controller.widgetPosition.dx,
                        top: controller.widgetPosition.dy,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            if (details.localPosition.dy > 50) {
                              // If dragging lower part → move whole widget
                              controller.updateWidgetPosition(details);
                            } else {
                              // If dragging upper part → rotate angle
                              controller.updateAngle(details);
                            }
                          },
                          // onPanUpdate: controller.updateAngle, // Adjust angle
                          child: Transform.rotate(
                            angle: controller.widgetRotationalAngle* pi / 180,
                            child: CustomPaint(
                              painter: AnglePainter(controller.angleDegrees, controller.lineLength),
                              size: Size(controller.lineLength * 2, controller.lineLength * 2),
                            ),
                          ),
                        ),
                      ),
                    if(controller.showAngle)
                      Positioned(
                        left: controller.widgetPosition.dx+75,
                        top: controller.widgetPosition.dy+75,
                        child: GestureDetector(
                          onTap: (){
                           controller.widgetRotateRight();
                          },
                          child: const Icon(Icons.rotate_left,
                          size: 50,color: Colors.white,),
                        ),
                      )
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }



  List<Widget> markerActions(context, controller) {
    return [
      ValueListenableBuilder(
        valueListenable: controller.notifier,
        builder: (context, value, child) => IconButton(
          icon: child as Icon,
          tooltip: "Undo",
          onPressed:
              controller.notifier.canUndo ? controller.notifier.undo : null,
        ),
        child: Icon(
          Icons.undo,
          size: 20.px,
        ),
      ),
      ValueListenableBuilder(
        valueListenable: controller.notifier,
        builder: (context, value, child) => IconButton(
          icon: child as Icon,
          tooltip: "Redo",
          onPressed:
              controller.notifier.canRedo ? controller.notifier.redo : null,
        ),
        child: Icon(
          Icons.redo,
          size: 20.px,
        ),
      ),
      IconButton(
        icon: const Icon(Icons.clear),
        tooltip: "Clear",
        onPressed: controller.notifier.clear,
      ),
      buildEraserButton(context, controller),
      buildPointerModeSwitcher(context, controller),
      buildColorButton(context, controller, color: Colors.black),
      buildColorButton(context, controller, color: Colors.red),
      buildColorButton(context, controller, color: Colors.green),
      buildColorButton(context, controller, color: Colors.blue),
      buildColorButton(context, controller, color: Colors.yellow),
      _buildStrokeToolbar(context, controller),
    ];
  }

  Widget _buildStrokeToolbar(BuildContext context, controller) {
    return ValueListenableBuilder<ScribbleState>(
      valueListenable: controller.notifier,
      builder: (context, state, _) {
        final isLandscape =
            MediaQuery.of(context).orientation == Orientation.landscape;

        final children = [
          for (final w in controller.notifier.widths) // <-- Use `state` instead of `controller.notifier`
            _buildStrokeButton(
              context,
              strokeWidth: w,
              state: state,
              controller: controller,
            ),
        ];

        return isLandscape
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: children,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: children,
              );
      },
    );
  }

  Widget _buildStrokeButton(
    BuildContext context, {
    required double strokeWidth,
    required ScribbleState state,
    required dynamic controller, // Add `required`
  }) {
    final selected = state.selectedWidth == strokeWidth;
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Material(
        elevation: selected ? 4 : 0,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: () => controller.notifier.setStrokeWidth(strokeWidth*.4),
          customBorder: const CircleBorder(),
          child: AnimatedContainer(
            duration: kThemeAnimationDuration,
            width: strokeWidth * 2,
            height: strokeWidth * 2,
            decoration: BoxDecoration(
              color: state.map(
                drawing: (s) => Color(s.selectedColor),
                erasing: (_) => Colors.transparent,
              ),
              border: state.map(
                drawing: (_) => null,
                erasing: (_) => Border.all(width: 1),
              ),
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEraserButton(BuildContext context, controller) {
    return ValueListenableBuilder(
      valueListenable: controller.notifier,
      builder: (context, value, child) {
        final isActive = value is Erasing;
        return ColorButton(
          color: Colors.transparent,
          outlineColor: Colors.black,
          isActive: isActive,
          onPressed: () => controller.notifier.setEraser(),
          child: const Icon(Icons.cleaning_services),
        );
      },
    );
  }

  Widget buildPointerModeSwitcher(BuildContext context, controller) {
    return ValueListenableBuilder(
      valueListenable: controller.notifier,
      builder: (context, value, child) {
        final allowedPointerMode = value;
        if (MediaQuery.of(context).orientation != Orientation.landscape) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.touch_app,
                    color: allowedPointerMode == ScribblePointerMode.all
                        ? Colors.blue
                        : Colors.grey),
                onPressed: () => controller.notifier
                    .setAllowedPointersMode(ScribblePointerMode.all),
              ),
              IconButton(
                icon: Icon(Icons.draw,
                    color: allowedPointerMode == ScribblePointerMode.penOnly
                        ? Colors.blue
                        : Colors.grey),
                onPressed: () => controller.notifier
                    .setAllowedPointersMode(ScribblePointerMode.penOnly),
              ),
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.touch_app,
                    color: allowedPointerMode == ScribblePointerMode.all
                        ? Colors.blue
                        : Colors.grey),
                onPressed: () => controller.notifier
                    .setAllowedPointersMode(ScribblePointerMode.all),
              ),
              IconButton(
                icon: Icon(Icons.draw,
                    color: allowedPointerMode == ScribblePointerMode.penOnly
                        ? Colors.blue
                        : Colors.grey),
                onPressed: () => controller.notifier
                    .setAllowedPointersMode(ScribblePointerMode.penOnly),
              ),
            ],
          );
        }
      },
    );
  }

  Widget buildColorButton(
    BuildContext context,
    controller, {
    required Color color,
  }) {
    return ValueListenableBuilder(
      valueListenable: controller.notifier,
      builder: (context, value, child) {
        final isActive = value is Drawing && value.selectedColor == color.value;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ColorButton(
            color: color,
            isActive: isActive,
            onPressed: () => controller.notifier.setColor(color),
          ),
        );
      },
    );
  }
}

class ColorButton extends StatelessWidget {
  const ColorButton({
    required this.color,
    required this.isActive,
    required this.onPressed,
    this.outlineColor,
    this.child,
    super.key,
  });

  final Color color;

  final Color? outlineColor;

  final bool isActive;

  final VoidCallback onPressed;

  final Icon? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      decoration: ShapeDecoration(
        shape: CircleBorder(
          side: BorderSide(
            color: switch (isActive) {
              true => outlineColor ?? color,
              false => Colors.transparent,
            },
            width: 2,
          ),
        ),
      ),
      child: IconButton(
        style: FilledButton.styleFrom(
          backgroundColor: color,
          shape: const CircleBorder(),
          side: isActive
              ? const BorderSide(color: Colors.white, width: 2)
              : const BorderSide(color: Colors.transparent),
        ),
        onPressed: onPressed,
        icon: child ?? const SizedBox(),
      ),
    );
  }
}


  class AnglePainter extends CustomPainter {
    final double angleDegrees;
    final double length;

    AnglePainter(this.angleDegrees, this.length);

    @override
    void paint(Canvas canvas, Size size) {
      final center = Offset(size.width / 2, size.height / 2);
      final angleRadians = angleDegrees * pi / 180;

      final pointA = Offset(
        center.dx + length * cos(-angleRadians / 2),
        center.dy + length * sin(-angleRadians / 2),
      );
      final pointB = Offset(
        center.dx + length * cos(angleRadians / 2),
        center.dy + length * sin(angleRadians / 2),
      );

      final paint = Paint()
        ..color = Colors.blue
        ..strokeWidth = 4;

      canvas.drawLine(center, pointA, paint);
      canvas.drawLine(center, pointB, paint);

      final pointPaint = Paint()..color = Colors.red;
      canvas.drawCircle(center, 5, pointPaint);
      canvas.drawCircle(pointA, 5, pointPaint);
      canvas.drawCircle(pointB, 5, pointPaint);

      final textPainter = TextPainter(
        text: TextSpan(
          text: '${angleDegrees.toStringAsFixed(1)}°',
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(canvas, center + const Offset(10, -30));
    }

    @override
    bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
  }


