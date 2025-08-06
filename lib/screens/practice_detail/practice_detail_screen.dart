import 'dart:ui' as ui;

//import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:golf_flutter/common/cp/gradient_circular_progress_bar.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/common/graphs/circle_point_graph.dart';
import 'package:golf_flutter/common/graphs/custom_bar_chart_graph.dart';
import 'package:golf_flutter/common/graphs/line_chart_graph.dart';
import 'package:golf_flutter/common/progress_bar.dart';
import 'package:golf_flutter/screens/practice_detail/practice_detail_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/graphs/short_game_line_graph.dart';

class PracticeDetailScreen extends StatefulWidget {
  var pageData;

  PracticeDetailScreen({super.key, this.pageData});

  @override
  State<PracticeDetailScreen> createState() => _PracticeDetailScreenState();
}

class _PracticeDetailScreenState extends State<PracticeDetailScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var practiceDetailController =
        Provider.of<PracticeDetailController>(context);
    practiceDetailController.initMethod(widget.pageData);
  }

  @override
  void deactivate() {
    super.deactivate();
    var practiceDetailController =
        Provider.of<PracticeDetailController>(context);
    practiceDetailController.isInitCalled = false;
    practiceDetailController.inAsyncCall = false;
    practiceDetailController.practiceModel = null;
    practiceDetailController.practiceStats = null;
    practiceDetailController.practiceData = null;
    practiceDetailController.videoController1 = null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PracticeDetailController>(
      builder: (context, PracticeDetailController controller, child) {
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
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 16.px),
              children: [
                if (widget.pageData['cardType'] == 'Putting')
                  PuttingDetailView(pageData: widget.pageData),
                if (widget.pageData['cardType'] == 'Short Game')
                  ShortGameDetailView(pageData: widget.pageData),
                SizedBox(height: 30.px),
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

  Widget selectLevelListView({required PracticeDetailController controller}) {
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

  Widget winnerCardView({required PracticeDetailController controller}) {
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

  Widget circlePointGraphView({required PracticeDetailController controller}) {
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
        childAspectRatio: 2,
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

class PuttingDetailView extends StatefulWidget {
  var pageData;

  PuttingDetailView({super.key, this.pageData});

  @override
  State<PuttingDetailView> createState() => _PuttingDetailViewState();
}

class _PuttingDetailViewState extends State<PuttingDetailView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PracticeDetailController>(
      builder: (context, controller, child) => Column(
        children: [
          if (widget.pageData["cardName"] == "Lag Putt Tornado")
            forLagPuttTornado(controller),
          if (widget.pageData["cardName"] == "Stroke Test")
            forStrokeTest(controller),
          if (widget.pageData["cardName"] == "Marketable")
            forMarketable(controller),
          if (widget.pageData["cardName"] == "Simulated Putting Round")
            forSimulatedRound(controller),
        ],
      ),
    );
  }

  forLagPuttTornado(PracticeDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.practiceData != null &&
            controller.practiceData!.description != null)
          Html(data: controller.practiceData?.description),
        SizedBox(height: 16.px),
        Container(
          padding: EdgeInsets.all(5.px),
          decoration: const BoxDecoration(
            color: Color(0xff0D0808),
            // color: Colors.yellow,
            shape: BoxShape.circle,
          ),
          child: circlePointGraphView(controller: controller),
        ),
        SizedBox(height: 16.px),
        commonTitleTextView(
          text: 'Enter new score',
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 8.px),
        CW.commonTextFieldForLoginSignUP(
          context: context,
          hintText: 'Your latest score',
          contentPadding:
              EdgeInsets.only(top: 10.px, left: 16.px, right: 16.px),
        ),
        SizedBox(height: 16.px),
        commonTitleTextView(
          text: 'Scoring',
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 8.px),
        //commonGridView(list: controller.scoringDataList),
        // SizedBox(height: 8.px),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff0D0808),
          ),
          child: Table(
            border: TableBorder.all(
                color: const Color(0xff1e1313),
                width: .5,
                borderRadius: BorderRadius.circular(20.px)),
            columnWidths: const {
              0: FlexColumnWidth(4),
              1: FlexColumnWidth(1),
            },
            children: [
              buildTableRow('Hole it', "${controller.practiceStats?.holeIt ?? '0'}"),
              buildTableRow('Within 10% of the distance', "${controller.practiceStats?.within10Percent ?? '0'}"),
              buildTableRow('More than 10% of the distance', "${controller.practiceStats?.beyond10Percent ?? '0'}"),
            ],
          ),
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
                      text: 'Score',
                    ),
                  ),
                  SizedBox(width: 16.px),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.isMenuOpen = !controller.isMenuOpen;
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
                        color: Theme.of(context).scaffoldBackgroundColor,
                        itemBuilder: (BuildContext context) {
                          return controller.options.map((String option) {
                            return PopupMenuItem<String>(
                              height: 32.px,
                              value: option,
                              child: Text(
                                option,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            );
                          }).toList();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.px,
                            vertical: 4.px,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(
                              color: controller.isMenuOpen
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.transparent,
                              width: 2.px,
                            ),
                            borderRadius: BorderRadius.circular(8.px),
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
                                image: 'assets/icons/down_up_ic.png',
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
              CustomPaint(
                size: Size(300.px, 200.px), // Chart size
                painter: SingleLineChartPainter(
                  context: context,
                  yValues: controller.yValuesForSingleLineChartGraph,
                  xLabels: controller.xLabelsForSingleLineChartGraph,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.px),
      ],
    );
  }

  forStrokeTest(PracticeDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.practiceData != null &&
            controller.practiceData!.description != null)
          Html(data: controller.practiceData?.description),
        SizedBox(height: 8.px),
        commonTitleTextView(
          text: 'Enter total score out of twenty',
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 8.px),
        CW.commonTextFieldForLoginSignUP(
          context: context,
          hintText: '#',
          contentPadding:
              EdgeInsets.only(top: 10.px, left: 16.px, right: 16.px),
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
                        controller.isMenuOpen = !controller.isMenuOpen;
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
                        color: Theme.of(context).scaffoldBackgroundColor,
                        itemBuilder: (BuildContext context) {
                          return controller.options.map((String option) {
                            return PopupMenuItem<String>(
                              height: 32.px,
                              value: option,
                              child: Text(
                                option,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            );
                          }).toList();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.px,
                            vertical: 4.px,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(
                              color: controller.isMenuOpen
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.transparent,
                              width: 2.px,
                            ),
                            borderRadius: BorderRadius.circular(8.px),
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
                                image: 'assets/icons/down_up_ic.png',
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
                      data: controller.xLabelsForPerformanceOverTimeGraph,
                      barColor: Theme.of(context).colorScheme.primary,
                      yValues: controller.yValuesForPerformanceOverTimeGraph,
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
          text: 'Putting',
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 8.px),
        commonGridView(list: controller.puttingDataList),
        SizedBox(height: 16.px),
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
        SizedBox(height: 16.px),
      ],
    );
  }

  forMarketable(PracticeDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.practiceData != null &&
            controller.practiceData!.description != null)
          Html(data: controller.practiceData?.description),
        SizedBox(height: 16.px),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            //color: const Color(0xff0D0808),
          ),
          child: Table(
            border: TableBorder.all(
                color: const Color(0xff1e1313),
                width: 0,
                borderRadius: BorderRadius.circular(20.px)),
            /* columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
            },*/
            children: [
              buildTableRowMarketTable(
                  'Degrees of slope', 'Score', 'Pts lost for per squad'),
              buildTableRowMarketTableDate('1-2', '#', '#'),
              buildTableRowMarketTableDate('2-3', '#', '#'),
              buildTableRowMarketTableDate('3-4', '#', '#'),
            ],
          ),
        ),
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
        if (controller.practiceData != null &&
            controller.practiceData!.howToDoIt != null)
          Html(data: controller.practiceData?.howToDoIt),
        SizedBox(height: 16.px),
        if (controller.practiceData != null &&
            controller.practiceData!.scoring != null)
          Html(data: controller.practiceData?.scoring),
        SizedBox(height: 16.px),
        Image.asset('assets/img/img_graph.png'),
        SizedBox(height: 16.px),
        commonTitleTextView(
          text: 'Putting',
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 8.px),
        commonGridView(list: controller.puttingDataList),
        SizedBox(height: 16.px),
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
        SizedBox(height: 16.px),
      ],
    );
  }

  forSimulatedRound(PracticeDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.practiceData != null &&
            controller.practiceData!.description != null)
          Html(data: controller.practiceData?.description),
        SizedBox(height: 16.px),
        Image.asset('assets/dummy_img/hole_18.png'),
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
                      text: 'Strokes Gained',
                    ),
                  ),
                  SizedBox(width: 16.px),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.isMenuOpen = !controller.isMenuOpen;
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
                        color: Theme.of(context).scaffoldBackgroundColor,
                        itemBuilder: (BuildContext context) {
                          return controller.options.map((String option) {
                            return PopupMenuItem<String>(
                              height: 32.px,
                              value: option,
                              child: Text(
                                option,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            );
                          }).toList();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.px,
                            vertical: 4.px,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(
                              color: controller.isMenuOpen
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.transparent,
                              width: 2.px,
                            ),
                            borderRadius: BorderRadius.circular(8.px),
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
                                image: 'assets/icons/down_up_ic.png',
                                isAssetImage: true,
                                height: 14.px,
                                width: 16.px,
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16.px),

      ///Comment by arvind ....
      /*  SizedBox(
          height: 320,
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 8.px, left: 8.px, right: 8.px),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: value == 0
                            ? Colors.white.withOpacity(0.8)
                            : Colors.grey.withOpacity(0.5),
                        strokeWidth: value == 0 ? 1.5 : 0,
                        dashArray: value == 0 ? [8, 4] : null,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 20,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return Padding(
                                padding:
                                    EdgeInsets.only(top: 6.px, left: 30.px),
                                child: Text(
                                  '24 Aug',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        fontSize: 8.px,
                                      ),
                                ),
                              );
                            case 1:
                              return Padding(
                                padding: EdgeInsets.only(top: 6.px),
                                child: Text(
                                  '23 Aug',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        fontSize: 8.px,
                                      ),
                                ),
                              );
                            case 2:
                              return Padding(
                                padding: EdgeInsets.only(top: 6.px),
                                child: Text(
                                  '22 Aug',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        fontSize: 8.px,
                                      ),
                                ),
                              );
                            case 3:
                              return Padding(
                                padding: EdgeInsets.only(top: 6.px),
                                child: Text(
                                  '21 Aug',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        fontSize: 8.px,
                                      ),
                                ),
                              );
                            case 4:
                              return Padding(
                                padding: EdgeInsets.only(top: 6.px),
                                child: Text(
                                  '20 Aug',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        fontSize: 8.px,
                                      ),
                                ),
                              );
                            default:
                              return const SizedBox.shrink();
                          }
                        },
                        interval: 1,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontSize: 8.px,
                                ),
                          );
                        },
                        interval: 1,
                        reservedSize: 14,
                      ),
                    ),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      left: BorderSide(
                          color: Theme.of(context).colorScheme.surface,
                          width: .5.px),
                      bottom: BorderSide(
                          color: Theme.of(context).colorScheme.surface,
                          width: .5.px),
                      top: BorderSide.none,
                      right: BorderSide.none,
                    ),
                  ),
                  minX: 0,
                  maxX: 4,
                  minY: -2,
                  maxY: 2,
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 0.5),
                        FlSpot(1, -1),
                        FlSpot(2, -0.5),
                        FlSpot(3, 1.2),
                        FlSpot(4, 0.8),
                      ],
                      isCurved: true,
                      color: Theme.of(context).colorScheme.primary,
                      barWidth: 3,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0.5),
                          ],
                        ),
                      ),
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),*/

        CW.imageView(
          image: 'assets/dummy_img/dummy_graph.png',
          isAssetImage: true,
          height: 260.px,
          width: MediaQuery.of(context).size.width,
        ),
        SizedBox(height: 16.px),
        commonTitleTextView(
          text: 'Putting',
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 8.px),
        commonGridView(list: controller.puttingDataList),
        SizedBox(height: 16.px),
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
        SizedBox(height: 16.px),
      ],
    );
  }

  Widget commonTitleTextView({required String text, FontWeight? fontWeight}) =>
      Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: fontWeight ?? FontWeight.w700,
            ),
      );

  Widget commonDisTextView({required String text, FontWeight? fontWeight}) =>
      Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: fontWeight ?? FontWeight.w500,
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
            child: commonDisTextView(text: text),
          ),
        ],
      );

  TableRow buildTableRow(String label, String score, {bool isHeader = false}) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(14.px),
          child: Row(
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(14.px),
          child: Text(
            score,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  TableRow buildTableRowMarketTable(String label, String score, String pts,
      {bool isHeader = false}) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(14.px),
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(14.px),
          child: Text(
            score,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(14.px),
          child: Text(
            pts,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }

  TableRow buildTableRowMarketTableDate(String label, String score, String pts,
      {bool isHeader = false}) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(14.px),
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(14.px),
          child: Center(
            child: CW.commonTextFieldForLoginSignUP(
              context: context,
              hintText: '#',
              height: 34.px,
              contentPadding:
                  EdgeInsets.only(top: 10.px, left: 16.px, right: 16.px),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(14.px),
          child: Center(
            child: CW.commonTextFieldForLoginSignUP(
              height: 34.px,
              context: context,
              hintText: '#',
              contentPadding:
                  EdgeInsets.only(top: 10.px, left: 16.px, right: 16.px),
            ),
          ),
        ),
      ],
    );
  }

  Widget selectLevelListView({required PracticeDetailController controller}) {
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

  Widget winnerCardView({required PracticeDetailController controller}) {
    return CW.commonBlackCardView(
      context: context,
      width: double.infinity,
      padding: EdgeInsets.all(8.px),
      borderRadius: 12.px,
      borderWidth: 0.px,
      cardColor: Theme.of(context).scaffoldBackgroundColor,
      isGradient: false,
      widget: Column(
        mainAxisSize: MainAxisSize.max,
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

  Widget circlePointGraphView({required PracticeDetailController controller}) {
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
        childAspectRatio: 2,
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

class ShortGameDetailView extends StatefulWidget {
  var pageData;

  ShortGameDetailView({super.key, this.pageData});

  @override
  State<ShortGameDetailView> createState() => _ShortGameDetailViewState();
}

class _ShortGameDetailViewState extends State<ShortGameDetailView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PracticeDetailController>(
      builder: (context, controller, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.pageData["cardName"] ==
              "Doc's Ultimate Chipping Drill (Fairway)")
            forFairway(controller),
          if (widget.pageData["cardName"] ==
              "Doc's Ultimate Chipping Drill (Rough)")
            forRough(controller),
          if (widget.pageData["cardName"] == "Survivor")
            forSurvivor(controller),
        ],
      ),
    );
  }

  forFairway(PracticeDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          contentPadding:
              EdgeInsets.only(top: 10.px, left: 16.px, right: 16.px),
        ),
        SizedBox(height: 16.px),
        Container(
          padding: EdgeInsets.all(16.px),
          decoration: BoxDecoration(
            color: const Color(0xff0D0808),
            borderRadius: BorderRadius.circular(16.px),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: commonTitleTextView(
                      text: 'Strokes gained Around the green',
                    ),
                  ),
                  SizedBox(width: 16.px),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.isMenuOpen = !controller.isMenuOpen;
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
                        color: Theme.of(context).scaffoldBackgroundColor,
                        itemBuilder: (BuildContext context) {
                          return controller.options.map((String option) {
                            return PopupMenuItem<String>(
                              height: 32.px,
                              value: option,
                              child: Text(
                                option,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            );
                          }).toList();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.px,
                            vertical: 4.px,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(
                              color: controller.isMenuOpen
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.transparent,
                              width: 2.px,
                            ),
                            borderRadius: BorderRadius.circular(8.px),
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
                                image: 'assets/icons/down_up_ic.png',
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
              CustomPaint(
                size: Size(double.infinity, 300.px),
                painter: LineChartPainter(
                  context: context,
                  yValues: controller.yValues,
                  xLabels: controller.xLabels,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.px),
      ],
    );
  }

  forRough(PracticeDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [if (controller.practiceData != null &&
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
          contentPadding:
              EdgeInsets.only(top: 10.px, left: 16.px, right: 16.px),
        ),
        SizedBox(height: 16.px),
        Container(
          padding: EdgeInsets.all(16.px),
          decoration: BoxDecoration(
            color: const Color(0xff0D0808),
            borderRadius: BorderRadius.circular(16.px),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: commonTitleTextView(
                      text: 'Strokes gained Around the green',
                    ),
                  ),
                  SizedBox(width: 16.px),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.isMenuOpen = !controller.isMenuOpen;
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
                        color: Theme.of(context).scaffoldBackgroundColor,
                        itemBuilder: (BuildContext context) {
                          return controller.options.map((String option) {
                            return PopupMenuItem<String>(
                              height: 32.px,
                              value: option,
                              child: Text(
                                option,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            );
                          }).toList();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.px,
                            vertical: 4.px,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(
                              color: controller.isMenuOpen
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.transparent,
                              width: 2.px,
                            ),
                            borderRadius: BorderRadius.circular(8.px),
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
                                image: 'assets/icons/down_up_ic.png',
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
              CustomPaint(
                size: Size(double.infinity, 300.px),
                painter: LineChartPainter(
                  context: context,
                  yValues: controller.yValues,
                  xLabels: controller.xLabels,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.px),
      ],
    );
  }

  forSurvivor(PracticeDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.practiceData != null &&
            controller.practiceData!.description != null)
          Html(data: controller.practiceData?.description),
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
        commonTitleTextView(text: 'Select Level'),
        SizedBox(height: 16.px),
        selectLevelListView(controller: controller),
        SizedBox(height: 16.px),
        winnerCardView(controller: controller),
        SizedBox(height: 16.px),
        Container(
          padding: EdgeInsets.all(16.px),
          decoration: BoxDecoration(
            color: const Color(0xff0D0808),
            borderRadius: BorderRadius.circular(16.px),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: commonTitleTextView(
                      text: 'Score %',
                    ),
                  ),
                  SizedBox(width: 16.px),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.isMenuOpen = !controller.isMenuOpen;
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
                        color: Theme.of(context).scaffoldBackgroundColor,
                        itemBuilder: (BuildContext context) {
                          return controller.options.map((String option) {
                            return PopupMenuItem<String>(
                              height: 32.px,
                              value: option,
                              child: Text(
                                option,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            );
                          }).toList();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.px,
                            vertical: 4.px,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(
                              color: controller.isMenuOpen
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.transparent,
                              width: 2.px,
                            ),
                            borderRadius: BorderRadius.circular(8.px),
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
                                image: 'assets/icons/down_up_ic.png',
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
              CustomPaint(
                size: Size(double.infinity, 300.px),
                painter: LineChartPainter(
                  context: context,
                  yValues: controller.yValues,
                  xLabels: controller.xLabels,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.px),
      ],
    );
  }

  Widget commonTitleTextView({required String text, FontWeight? fontWeight}) =>
      Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: fontWeight ?? FontWeight.w700,
            ),
      );

  Widget commonDisTextView({required String text, FontWeight? fontWeight}) =>
      Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: fontWeight ?? FontWeight.w500,
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
            child: commonDisTextView(text: text),
          ),
        ],
      );

  Widget selectLevelListView({required PracticeDetailController controller}) {
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

  Widget winnerCardView({required PracticeDetailController controller}) {
    return CW.commonBlackCardView(
      context: context,
      width: double.infinity,
      padding: EdgeInsets.all(8.px),
      borderRadius: 12.px,
      borderWidth: 0.px,
      cardColor: Theme.of(context).scaffoldBackgroundColor,
      isGradient: false,
      widget: Column(
        mainAxisSize: MainAxisSize.max,
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

  Widget circlePointGraphView({required PracticeDetailController controller}) {
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
        childAspectRatio: 2,
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
