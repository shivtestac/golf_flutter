import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:golf_flutter/common/cp/gradient_circular_progress_bar.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/common/graphs/circle_point_graph.dart';
import 'package:golf_flutter/common/graphs/custom_bar_chart_graph.dart';
import 'package:golf_flutter/common/progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'full_swing_practice_detail_controller.dart';

class FullSwingPracticeDetailScreen extends StatefulWidget {
  var pageData;

  FullSwingPracticeDetailScreen({super.key, this.pageData});

  @override
  State<FullSwingPracticeDetailScreen> createState() =>
      _FullSwingPracticeDetailScreenState();
}

class _FullSwingPracticeDetailScreenState
    extends State<FullSwingPracticeDetailScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var fullSwingPracticeDetailController =
        Provider.of<FullSwingPracticeDetailController>(context);
    fullSwingPracticeDetailController.initMethod(widget.pageData);
  }

  @override
  void deactivate() {
    super.deactivate();
    var fullSwingPracticeDetailController =
        Provider.of<FullSwingPracticeDetailController>(context);
    fullSwingPracticeDetailController.isInitCalled = false;
    fullSwingPracticeDetailController.inAsyncCall = false;
    fullSwingPracticeDetailController.practiceModel = null;
    fullSwingPracticeDetailController.practiceStats = null;
    fullSwingPracticeDetailController.practiceData = null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FullSwingPracticeDetailController>(
      builder: (context, FullSwingPracticeDetailController controller, child) {
        return ProgressBar(
          inAsyncCall: controller.inAsyncCall,
          child: Scaffold(
            appBar: AppBar(
              leadingWidth: 76.px,
              leading: GestureDetector(
                onTap: () => controller.clickOnBackButton(context: context),
                child: Center(
                  child: CW.imageView(
                    image: 'assets/icons/left_arrow_ic.png',
                    isAssetImage: true,
                    height: 24.px,
                    width: 24.px,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              title: Text(
                widget.pageData['cardName'],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              centerTitle: false,
              titleSpacing: -8.px,
            ),
            body: widget.pageData['cardName'] == 'Driver Test'
                ? ListView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.px, vertical: 16.px),
                    children: [
                      if (controller.practiceData != null &&
                          controller.practiceData!.description != null)
                        Html(data: controller.practiceData?.description),
                      SizedBox(height: 16.px),
                      if (controller.videoController1 != null)
                        Column(
                          children: [
                            Container(
                              height: 200.px,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.px)
                              ),
                              clipBehavior:Clip.hardEdge,
                              child: controller
                                  .buildVideoPlayer(controller.videoController1!),
                            ),
                            controller.videoController()
                          ],
                        ),
                      SizedBox(height: 16.px), if (controller.practiceData != null &&
                          controller.practiceData!.scoring != null)
                        Html(data: controller.practiceData?.scoring),
                      SizedBox(height: 16.px),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonTitleTextView(
                                  text: 'Enter total score #/20',
                                  fontWeight: FontWeight.w400,
                                ),
                                SizedBox(height: 8.px),
                                CW.commonTextFieldForLoginSignUP(
                                  context: context,
                                  hintText: '#',
                                  contentPadding: EdgeInsets.only(
                                      top: 10.px, left: 16.px, right: 16.px),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.px),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonTitleTextView(
                                  text: 'Enter average distance',
                                  fontWeight: FontWeight.w400,
                                ),
                                SizedBox(height: 8.px),
                                CW.commonTextFieldForLoginSignUP(
                                  context: context,
                                  hintText: '#',
                                  contentPadding: EdgeInsets.only(
                                      top: 10.px, left: 16.px, right: 16.px),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.px),
                      Container(
                        padding: EdgeInsets.all(16.px),
                        decoration: const BoxDecoration(
                          color: Color(0xff0D0808),
                          // color: Colors.yellow,
                          // shape: BoxShape.circle,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: commonTitleTextView(
                                    text: 'Performance Over Time',
                                  ),
                                ),
                                SizedBox(width: 16.px),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      controller.isMenuOpen =
                                          !controller.isMenuOpen;
                                    });
                                  },
                                  child: CW.commonBlackCardView(
                                    context: context,
                                    widget: PopupMenuButton<String>(
                                      position: PopupMenuPosition.under,
                                      initialValue: controller.selectedOption,
                                      onSelected: (value) {
                                        setState(() {
                                          controller.selectedOption = value;
                                          controller.isMenuOpen = false;
                                        });
                                      },
                                      onCanceled: () {
                                        setState(() {
                                          controller.isMenuOpen = false;
                                        });
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      itemBuilder: (BuildContext context) {
                                        return controller.options
                                            .map((String option) {
                                          return PopupMenuItem<String>(
                                            height: 32.px,
                                            value: option,
                                            child: Text(
                                              option,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            ),
                                          );
                                        }).toList();
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.px,
                                          vertical: 4.px,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          border: Border.all(
                                            color: controller.isMenuOpen
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : Colors.transparent,
                                            width: 2.px,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.px),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              controller.selectedOption,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                  ),
                                            ),
                                            SizedBox(width: 6.px),
                                            CW.imageView(
                                              image:
                                                  'assets/icons/down_up_ic.png',
                                              isAssetImage: true,
                                              height: 14.px,
                                              width: 16.px,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 300,
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(16.px),
                                child: CustomPaint(
                                  painter: CustomBarChartPainter(
                                    data: controller
                                        .xLabelsForPerformanceOverTimeGraph,
                                    barColor:
                                        Theme.of(context).colorScheme.primary,
                                    yValues: controller
                                        .yValuesForPerformanceOverTimeGraph,
                                    context: context,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.px),
                      commonTitleTextView(
                        text: 'Driving',
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 8.px),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.progressBarListData.length,
                        itemBuilder: (context, index) {
                          final item = controller.progressBarListData[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 8.px),
                            child: commonProgressBarView(
                              time: item['title'],
                              current: item['current'],
                              total: item['total'],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 30.px),
                    ],
                  )
                : widget.pageData['cardName'] == 'Approach'
                    ? ListView(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.px, vertical: 16.px),
                        children: [
                          if (controller.practiceData != null &&
                              controller.practiceData!.description != null)
                            Html(data: controller.practiceData?.description),
                          SizedBox(height: 16.px),
                          if (controller.practiceData != null &&
                              controller.practiceData!.scoring != null)
                            Html(data: controller.practiceData?.scoring),
                          SizedBox(height: 16.px),
                          if (controller.videoController1 != null)
                            Column(
                              children: [
                                Container(
                                  height: 200.px,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.px)
                                  ),
                                  clipBehavior:Clip.hardEdge,
                                  child: controller
                                      .buildVideoPlayer(controller.videoController1!),
                                ),
                                controller.videoController()
                              ],
                            ),
                          SizedBox(height: 16.px),
                          commonTitleTextView(
                            text: 'Enter total score out of twenty',
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 8.px),
                          CW.commonTextFieldForLoginSignUP(
                            context: context,
                            hintText: '#',
                            contentPadding: EdgeInsets.only(
                                top: 10.px, left: 16.px, right: 16.px),
                          ),
                          SizedBox(height: 16.px),
                          Container(
                            padding: EdgeInsets.all(16.px),
                            decoration: const BoxDecoration(
                              color: Color(0xff0D0808),
                              // color: Colors.yellow,
                              // shape: BoxShape.circle,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: commonTitleTextView(
                                        text: 'Performance Over Time',
                                      ),
                                    ),
                                    SizedBox(width: 16.px),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.isMenuOpen =
                                              !controller.isMenuOpen;
                                        });
                                      },
                                      child: CW.commonBlackCardView(
                                        context: context,
                                        widget: PopupMenuButton<String>(
                                          position: PopupMenuPosition.under,
                                          initialValue: controller.selectedOption,
                                          onSelected: (value) {
                                            setState(() {
                                              controller.selectedOption = value;
                                              controller.isMenuOpen = false;
                                            });
                                          },
                                          onCanceled: () {
                                            setState(() {
                                              controller.isMenuOpen = false;
                                            });
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          itemBuilder: (BuildContext context) {
                                            return controller.options
                                                .map((String option) {
                                              return PopupMenuItem<String>(
                                                height: 32.px,
                                                value: option,
                                                child: Text(
                                                  option,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium,
                                                ),
                                              );
                                            }).toList();
                                          },
                                          child: AnimatedContainer(
                                            duration:
                                                const Duration(milliseconds: 200),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.px,
                                              vertical: 4.px,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              border: Border.all(
                                                color: controller.isMenuOpen
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                    : Colors.transparent,
                                                width: 2.px,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.px),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  controller.selectedOption,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge
                                                      ?.copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary,
                                                      ),
                                                ),
                                                SizedBox(width: 6.px),
                                                CW.imageView(
                                                  image:
                                                      'assets/icons/down_up_ic.png',
                                                  isAssetImage: true,
                                                  height: 14.px,
                                                  width: 16.px,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 300,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.all(16.px),
                                    child: CustomPaint(
                                      painter: CustomBarChartPainter(
                                        data: controller
                                            .xLabelsForPerformanceOverTimeGraph,
                                        barColor:
                                            Theme.of(context).colorScheme.primary,
                                        yValues: controller
                                            .yValuesForPerformanceOverTimeGraph,
                                        context: context,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.px),
                          commonTitleTextView(
                            text: 'Approach',
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 8.px),
                          commonProgressBarView(
                            time: 'Strokes Gained Approach',
                            current: 13,
                            total: 18,
                          ),
                          SizedBox(height: 16.px),
                        ],
                      )
                    : ListView(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.px, vertical: 16.px),
                        children: [
                          if (controller.practiceData != null &&
                              controller.practiceData!.description != null)
                            Html(data: controller.practiceData?.description),
                          SizedBox(height: 16.px),
                          if (controller.practiceData != null &&
                              controller.practiceData!.scoring != null)
                            Html(data: controller.practiceData?.scoring),
                          SizedBox(height: 16.px),
                          if (controller.videoController1 != null)
                            Column(
                              children: [
                                Container(
                                  height: 200.px,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.px)
                                  ),
                                  clipBehavior:Clip.hardEdge,
                                  child: controller
                                      .buildVideoPlayer(controller.videoController1!),
                                ),
                                controller.videoController()
                              ],
                            ),
                          SizedBox(height: 16.px),
                          commonTitleTextView(
                            text: 'Enter total score out of twenty',
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 8.px),
                          CW.commonTextFieldForLoginSignUP(
                            context: context,
                            hintText: '#',
                            contentPadding: EdgeInsets.only(
                                top: 10.px, left: 16.px, right: 16.px),
                          ),
                          SizedBox(height: 16.px),
                          Container(
                            padding: EdgeInsets.all(16.px),
                            decoration: const BoxDecoration(
                              color: Color(0xff0D0808),
                              // color: Colors.yellow,
                              // shape: BoxShape.circle,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: commonTitleTextView(
                                        text: 'Performance Over Time',
                                      ),
                                    ),
                                    SizedBox(width: 16.px),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.isMenuOpen =
                                              !controller.isMenuOpen;
                                        });
                                      },
                                      child: CW.commonBlackCardView(
                                        context: context,
                                        widget: PopupMenuButton<String>(
                                          position: PopupMenuPosition.under,
                                          initialValue: controller.selectedOption,
                                          onSelected: (value) {
                                            setState(() {
                                              controller.selectedOption = value;
                                              controller.isMenuOpen = false;
                                            });
                                          },
                                          onCanceled: () {
                                            setState(() {
                                              controller.isMenuOpen = false;
                                            });
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          itemBuilder: (BuildContext context) {
                                            return controller.options
                                                .map((String option) {
                                              return PopupMenuItem<String>(
                                                height: 32.px,
                                                value: option,
                                                child: Text(
                                                  option,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium,
                                                ),
                                              );
                                            }).toList();
                                          },
                                          child: AnimatedContainer(
                                            duration:
                                                const Duration(milliseconds: 200),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.px,
                                              vertical: 4.px,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              border: Border.all(
                                                color: controller.isMenuOpen
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                    : Colors.transparent,
                                                width: 2.px,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.px),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  controller.selectedOption,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge
                                                      ?.copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary,
                                                      ),
                                                ),
                                                SizedBox(width: 6.px),
                                                CW.imageView(
                                                  image:
                                                      'assets/icons/down_up_ic.png',
                                                  isAssetImage: true,
                                                  height: 14.px,
                                                  width: 16.px,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 300,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.all(16.px),
                                    child: CustomPaint(
                                      painter: CustomBarChartPainter(
                                        data: controller
                                            .xLabelsForPerformanceOverTimeGraph,
                                        barColor:
                                            Theme.of(context).colorScheme.primary,
                                        yValues: controller
                                            .yValuesForPerformanceOverTimeGraph,
                                        context: context,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.px),
                          commonTitleTextView(
                            text: 'Approach',
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 8.px),
                          commonProgressBarView(
                            time: 'Strokes Gained Approach',
                            current: 13,
                            total: 18,
                          ),
                          SizedBox(height: 16.px),
                        ],
                      ),
          ),
        );
      },
    );
  }

  Widget commonTitleTextView({required String text, FontWeight? fontWeight}) =>
      Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: fontWeight ?? FontWeight.w700,
            ),
      );

  Widget commonRowView({required String text}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 5.px,
            width: 5.px,
            margin: EdgeInsets.only(right: 6.px, top: 7.px),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              shape: BoxShape.circle,
            ),
          ),
          Flexible(
            child: commonTitleTextView(text: text),
          ),
        ],
      );

  Widget selectLevelListView(
      {required FullSwingPracticeDetailController controller}) {
    return SizedBox(
      height: 32.px,
      child: ListView.builder(
        itemCount: controller.levelTitleList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        // padding: EdgeInsets.symmetric(horizontal: 24.px),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right:
                  index != controller.levelTitleList.length - 1 ? 6.px : 0.px,
            ),
            child: CW.commonBlackCardView(
              context: context,
              onTap: () => controller.clickOnLevelCardView(index: index),
              padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 16.px),
              borderRadius: 16.px,
              isBlackBg: !controller.selectedLevelValue
                  .contains(controller.levelTitleList[index]),
              widget: Center(
                child: Text(
                  controller.levelTitleList[index],
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: controller.selectedLevelValue
                                .contains(controller.levelTitleList[index])
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.surface,
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget winnerCardView(
      {required FullSwingPracticeDetailController controller}) {
    return CW.commonBlackCardView(
      context: context,
      padding: EdgeInsets.all(8.px),
      borderRadius: 12.px,
      borderWidth: 0.px,
      cardColor: Theme.of(context).scaffoldBackgroundColor,
      isGradient: false,
      widget: Column(
        children: [
          Text(
            'Result',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(height: 16.px),
          Text(
            'You Win!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          SizedBox(height: 16.px),
        ],
      ),
    );
  }

  Future<ui.Image> _loadImage(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Uint8List bytes = data.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }

  Widget circlePointGraphView(
      {required FullSwingPracticeDetailController controller}) {
    return FutureBuilder<ui.Image>(
      future: _loadImage('assets/img/graph_flag_img.png'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 20.px,
            width: 20.px,
            child: const GradientCircularProgressIndicator(),
          ); // Show a loader while waiting
        } else if (snapshot.hasError || !snapshot.hasData) {
          return const Text(
            'Failed to load assets flag image',
            style: TextStyle(color: Colors.white),
          ); // Show an error if the image fails to load
        } else {
          return Container(
            height: 350.px,
            width: 350.px,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CustomPaint(
                size: Size(250.px, 250.px),
                painter: IntersectionDiagramPainter(
                  context: context,
                  flagImage: snapshot.data!,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget commonGridView({required List list}) {
    return GridView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.px,
        crossAxisSpacing: 8.px,
        childAspectRatio: 2.5,
      ),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(16.px),
          decoration: BoxDecoration(
            color: const Color(0xff0D0808),
            borderRadius: BorderRadius.circular(8.px),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  list[index]['title'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  list[index]['subTitle'],
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget commonProgressBarView({
    required String time,
    required int current,
    required int total,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '$time ',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            /*Text(
              '${((current/total)*100)}%',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),*/
          ],
        ),
        SizedBox(height: 4.px),
        Row(
          children: [
            Expanded(
              flex: 8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3.px),
                child: LinearProgressIndicator(
                  value: ((current / total) * 100),
                  backgroundColor: Colors.grey[800]!,
                  color: Theme.of(context).colorScheme.primary,
                  minHeight: 6.px,
                ),
              ),
            ),
            SizedBox(width: 10.px),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '$current',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    '/$total',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
