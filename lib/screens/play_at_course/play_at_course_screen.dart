import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/common/graphs/line_with_distance_painter.dart';
import 'package:golf_flutter/screens/play_at_course/play_at_course_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PlayAtCourseScreen extends StatefulWidget {
  const PlayAtCourseScreen({super.key});

  @override
  State<PlayAtCourseScreen> createState() => _PlayAtCourseScreenState();
}

class _PlayAtCourseScreenState extends State<PlayAtCourseScreen> {

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    PlayAtCourseController playAtCourseController =
    Provider.of<PlayAtCourseController>(context);
    playAtCourseController.initMethod();
  }


  @override
  void deactivate() {
    PlayAtCourseController playAtCourseController =
        Provider.of<PlayAtCourseController>(context);
    playAtCourseController.currentHoleIndexValue = 1;
    playAtCourseController.formattedDataAll = [];
    playAtCourseController.clearData();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayAtCourseController>(
      builder: (context, PlayAtCourseController controller, child) {
        return Scaffold(
          body: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 2,
                height: MediaQuery.of(context).size.height * 2,
                child: Stack(
                  children: [
                    CW.imageView(
                      image: 'assets/dummy_img/golf_ground_img.png',
                      //image: AppSingleton.instance.teeDetails?.image ?? '',
                      isAssetImage: true,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    GestureDetector(
                      onDoubleTapDown: (details) =>
                          controller.clickAddNewPointYard(
                        context: context,
                        details: details,
                      ),
                      child: Stack(
                        children: [
                          CustomPaint(
                            painter: LineWithDistancePainter(
                              context: context,
                              points: controller.points,
                            ),
                            child: Container(),
                          ),
                          Transform.translate(
                            offset: Offset(150, 120), // Move the widget to (100, 650)
                            child: Icon(
                              Icons.circle_outlined,
                              size: 32,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          ...controller.points.asMap().entries.map((entry) {
                            int index = entry.key;
                            Offset point = entry.value;
                            return Positioned(
                              top: point.dy - 10.px,
                              left: point.dx - 10.px,
                              child: GestureDetector(
                                onPanStart: (_) => controller.onPanStart(),
                                onPanUpdate: (details) =>
                                    controller.onPanUpdate(
                                  context: context,
                                  details: details,
                                  index: index,
                                ),
                                onPanEnd: (_) => controller.onPanEnd(),
                                onLongPress: () => controller.onLongPress(index: index),
                                child: Container(
                                  width: 20.px,
                                  height: 20.px,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    if (controller.points.length ==
                        controller.pairLength.length &&
                        !(controller.pairLength[controller.currentIndexValue]))
                      Positioned(
                        top: 120.px,
                        left: 20.px,
                        child: Column(
                          children: [
                            Text('Set Short Result'),
                            GestureDetector(
                              onTap: () => controller.clickOnSetShortResult(context: context),
                              child: Container(
                                width: 24.px,
                                height: 24.px,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.onError,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Icon(Icons.done),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 24.px,
                    left: 24.px,
                    bottom: 20.px,
                    top: 16.px,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.px, vertical: 8.px),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(.8),
                              borderRadius: BorderRadius.circular(20.px),
                            ),
                            child: Row(
                              children: [
                                CW.imageView(
                                  image: 'assets/icons/connection_ic.png',
                                  isAssetImage: true,
                                  height: 20.px,
                                  width: 20.px,
                                ),
                                SizedBox(width: 6.px),
                                Text(
                                  'Connection is good',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          commonIconButtonView(
                            containerH: 36.px,
                            containerW: 36.px,
                            iconH: 20.px,
                            iconW: 20.px,
                            onTap: () => controller.clickOnCancelButton(
                                context: context),
                            icPath: 'assets/icons/cancel_ic.png',
                          ),
                        ],
                      ),
                      SizedBox(height: 12.px),
                      const SelectableDistancePill(
                        distances: ['70y', '60y', '49y', '39y'],
                      ),
                      SizedBox(height: 12.px),
                      const SelectableDistancePill(
                        distances: [
                          'Tee',
                          'Appr',
                        ],
                      ),
                      const Spacer(),
                      commonIconButtonView(
                        onTap: () =>
                            controller.clickOnGolfBollButton(context: context),
                        icPath: 'assets/icons/ic_golf_boll.png',
                      ),
                      SizedBox(height: 12.px),
                      commonIconButtonView(
                        onTap: () =>
                            controller.clickOnFlagButton(context: context),
                        icPath: 'assets/icons/flag_ic.png',
                      ),
                      SizedBox(height: 12.px),
                      commonIconButtonView(
                        onTap: () =>
                            controller.clickOnSettingButton(context: context),
                        icPath: 'assets/icons/circles_ic.png',
                      ),
                      SizedBox(height: 12.px),
                      commonIconButtonView(
                        onTap: () =>
                            controller.clickOnSettingButton(context: context),
                        icPath: 'assets/icons/score_card_ic.png',
                      ),
                      SizedBox(height: 12.px),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.px),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(.8),
                              borderRadius: BorderRadius.circular(20.px),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_left_outlined,
                                  size: 20.px,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                                SizedBox(width: 6.px),
                                Text(
                                  'Hole ${controller.currentHoleIndexValue} - Par 5',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                SizedBox(width: 6.px),
                                Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  size: 20.px,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.px),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(.8),
                              borderRadius: BorderRadius.circular(20.px),
                            ),
                            child: Text(
                              '368yd',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // Widget photoView({required PlayAtCourseController controller}) => PhotoView(
  //   imageProvider: const NetworkImage(
  //     "https://thumbs.dreamstime.com/b/golf-course-layout-flags-trees-plants-water-hazards-vector-map-isometric-illustration-52873871.jpg",
  //   ),
  //   backgroundDecoration: BoxDecoration(
  //     color: Theme.of(context).scaffoldBackgroundColor,
  //   ),
  //   minScale: PhotoViewComputedScale.covered,
  //   filterQuality: FilterQuality.high,
  //   errorBuilder: (context, error, stackTrace) {
  //     return Image.asset(
  //       "assets/dummy_img/golf_ground_img.png",
  //     );
  //   },
  // );

  Widget commonIconButtonView({
    required String icPath,
    GestureTapCallback? onTap,
    double? containerH,
    double? containerW,
    double? iconH,
    double? iconW,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: containerH ?? 42.px,
        width: containerW ?? 42.px,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.8),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: CW.imageView(
            image: icPath,
            isAssetImage: true,
            height: iconH ?? 24.px,
            width: iconW ?? 24.px,
          ),
        ),
      ),
    );
  }
}

class SelectableDistancePill extends StatefulWidget {
  final List<String> distances;
  final double pillWidth;
  final double pillHeight;

  const SelectableDistancePill({
    super.key,
    required this.distances,
    this.pillWidth = 42.0,
    this.pillHeight = 42.0,
  });

  @override
  _SelectableDistancePillState createState() => _SelectableDistancePillState();
}

class _SelectableDistancePillState extends State<SelectableDistancePill> {
  // int selectedIndex = -1;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).scaffoldBackgroundColor,
          width: 2.px,
        ),
        borderRadius: BorderRadius.circular(widget.pillWidth),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          widget.distances.length,
          (index) {
            bool isSelected = index == selectedIndex;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Column(
                children: [
                  if (index != 0)
                    Container(
                      height: 1.px,
                      width: widget.pillWidth,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  Container(
                    width: widget.pillWidth,
                    height: widget.pillHeight,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(.8),
                      borderRadius: BorderRadius.vertical(
                        top: index == 0
                            ? Radius.circular(widget.pillWidth / 2)
                            : Radius.zero,
                        bottom: index == widget.distances.length - 1
                            ? Radius.circular(widget.pillWidth / 2)
                            : Radius.zero,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.distances[index],
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: isSelected
                                ? Theme.of(context).scaffoldBackgroundColor
                                : Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  if (index != widget.distances.length - 1)
                    Container(
                      height: 1.px,
                      width: widget.pillWidth,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
