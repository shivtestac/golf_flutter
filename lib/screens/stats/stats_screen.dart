import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/screens/stats/stats_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var statsController = Provider.of<StatsController>(context, listen: false);
    statsController.initMethod();
  }

  @override
  void deactivate() {
    super.deactivate();
    var statsController = Provider.of<StatsController>(context, listen: false);
    statsController.isInitCalled = false;
    statsController.inAsyncCall = true;
    statsController.drivingData = [];
    statsController.strokesGained = [];
    statsController.reportDrivingModel = null;
    statsController.reportApproachModel = null;
    statsController.approachData = [];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StatsController>(
      builder: (context, StatsController controller, child) {
        return DefaultTabController(
          length: controller.tabTitleList.length,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              automaticallyImplyLeading: false,
              title: Text(
                'Performance',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.px,
                    ),
              ),
              bottom: TabBar(
                tabAlignment: TabAlignment.start,
                indicatorColor: Theme.of(context).colorScheme.primary,
                dividerColor: Theme.of(context).colorScheme.surface,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelStyle:
                    Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                isScrollable: true,
                padding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                physics: const ScrollPhysics(),
                labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                tabs: List.generate(
                  controller.tabTitleList.length,
                  (index) {
                    return Tab(
                      text: controller.tabTitleList[index],
                    );
                  },
                ),
              ),
            ),
            body: TabBarView(
              children: List.generate(
                controller.tabTitleList.length,
                (index) {
                  return index == 0
                      ? scoresUiView(controller: controller)
                      : index == 1
                          ? drivingUiView(controller: controller)
                          : index == 2
                              ? approachUiView(controller: controller)
                              : index == 3
                                  ? shortGameUiView(controller: controller)
                                  : index == 4
                                      ? puttingUiView(controller: controller)
                                      : index == 5
                                          ? roundPerformanceUiView(
                                              controller: controller)
                                          : Center(
                                              child: Text(
                                                'Content for ${controller.tabTitleList[index]}',
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget commonTitleTextView(
          {required String text, FontWeight? fontWeight, Color? color}) =>
      Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: fontWeight ?? FontWeight.w700, color: color),
      );

  Widget commonSubTitleTextView(
          {required String text, FontWeight? fontWeight}) =>
      Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 12.px,
            ),
      );

  Widget commonTextButtonView({GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'View Shot Details',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          CW.imageView(
            image: 'assets/icons/right_arrow1_ic.png',
            isAssetImage: true,
            height: 20.px,
            width: 20.px,
          ),
        ],
      ),
    );
  }

  Widget commonFilterButtonView({GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.px,
        width: 48.px,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xffFF0023), Color(0xffB50005)],
          ),
        ),
        child: Center(
          child: CW.imageView(
            image: 'assets/icons/filter_ic.png',
            isAssetImage: true,
            height: 20.px,
            width: 20.px,
          ),
        ),
      ),
    );
  }

  Widget commonCardView({
    required String text1,
    required String text2,
    bool isSmallCard = true,
  }) =>
      Container(
        height: isSmallCard ? 50.px : 68.px,
        width: isSmallCard ? 75.px : 104.px,
        decoration: BoxDecoration(
          color: const Color(0xff0D0808),
          borderRadius: BorderRadius.circular(8.px),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
            Text(
              text2,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      );

  Widget commonRowForStrokesView(
          {required String text1, required String text2}) =>
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text1,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.start,
            ),
            Text(
              text2,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      );

  Widget scoresUiView({required StatsController controller}) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 16.px),
      children: [
        Row(
          children: [
            CW.commonBlackCardView(
              context: context,
              height: 48.px,
              width: 48.px,
              borderRadius: 24.px,
              widget: Center(
                child: Text(
                  'R',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
            ),
            SizedBox(width: 16.px),
            Expanded(
              child: Text(
                'Stats are per 18 holes where applicable',
                style: Theme.of(context).textTheme.titleSmall,
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
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        // Icon(
                        //   Icons.arrow_drop_down,
                        //   color: Theme.of(context).colorScheme.onPrimary,
                        // ),
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
            ),
            SizedBox(width: 16.px),
            GestureDetector(
              onTap: () {
                setState(() {
                  controller.isMenuOpenComparison =
                      !controller.isMenuOpenComparison;
                });
              },
              child: CW.commonBlackCardView(
                context: context,
                widget: PopupMenuButton<String>(
                  position: PopupMenuPosition.under,
                  initialValue: controller.selectedOptionComparison,
                  onSelected: (value) {
                    setState(() {
                      controller.selectedOptionComparison = value;
                      controller.isMenuOpenComparison = false;
                    });
                  },
                  onCanceled: () {
                    setState(() {
                      controller.isMenuOpenComparison = false;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  itemBuilder: (BuildContext context) {
                    return controller.optionsComparison.map((String option) {
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
                        color: controller.isMenuOpenComparison
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
                          controller.selectedOptionComparison,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        // Icon(
                        //   Icons.arrow_drop_down,
                        //   color: Theme.of(context).colorScheme.onPrimary,
                        // ),
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
            ),
          ],
        ),
        SizedBox(height: 32.px),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonTitleTextView(text: 'Strokes Gained'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "+${controller.totalStrokes.toStringAsFixed(1)}",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                SizedBox(height: 4.px),
                Text(
                  "Total",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /*SizedBox(
              height: 200.px,
              child: SpiderChart(
                tickColor: controller.colorList,
                axisColor:  Colors.blue,
                ticks: controller.ticks,
                features: controller.features,
                featuresTextStyle:  TextStyle(color: Colors.black,fontSize: 12),
                data: controller.data,
                graphColors: [Colors.red],
                sides: 10,
                ticksTextStyle: TextStyle(color: Colors.green,fontSize: 12),
                reverseAxis: false,
                outlineColor: Colors.red,
              ),
            ),*/
            Center(
                child: Image.asset(
              'assets/img/img_spider_chart.png',
              height: 300.px,
            )),
            /*SizedBox(
              height: 200.px,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  CustomPaint(
                    size: Size(controller.dataPoints.length * 80.px, 200.px),
                    painter: StrokesGainedGraphPainter(
                      dataPoints: controller.dataPoints,
                      highlightedIndex: controller.highlightedIndex,
                      context: context,
                    ),
                  ),
                  Positioned(
                    left: (controller.highlightedIndex /
                            (controller.dataPoints.length + .8)) *
                        (controller.dataPoints.length * 80.0),
                    top: 62,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.px, horizontal: 8.px),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(12.px),
                          ),
                          child: Text(
                            controller.highlightedValue,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        Container(
                          width: 2.px,
                          height: 4.px,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        Container(
                          width: 2.px,
                          height: 6.px,
                          margin: EdgeInsets.only(top: 2.px),
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        Container(
                          width: 2.px,
                          height: 6.px,
                          margin: EdgeInsets.only(top: 2.px),
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),*/
            SizedBox(height: 16.px),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                controller.dataPoints.length,
                (index) => Padding(
                  padding: EdgeInsets.only(right: 45.px),
                  child: Column(
                    children: [
                      Text(
                        "+${controller.dataPoints[index]}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      SizedBox(height: 4.px),
                      Text(
                        controller.labels[index],
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.px),
        commonTitleTextView(text: 'Scoring average'),
        SizedBox(height: 8.px),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            commonCardView(
              text1: '3.00',
              text2: 'Par 3s',
              isSmallCard: false,
            ),
            commonCardView(
              text1: '3.60',
              text2: 'Par 4s',
              isSmallCard: false,
            ),
            commonCardView(
              text1: '4.25',
              text2: 'Par 5s',
              isSmallCard: false,
            ),
          ],
        ),
        SizedBox(height: 8.px),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            commonCardView(
              text1: '8.0',
              text2: 'Birdies+',
            ),
            commonCardView(
              text1: '8.0',
              text2: 'Pars',
            ),
            commonCardView(
              text1: '2.0',
              text2: 'Bogeys',
            ),
            commonCardView(
              text1: '0.0',
              text2: 'Doubles+',
            ),
          ],
        ),
        SizedBox(height: 16.px),
        CW.commonGradiantDividerView(),
        SizedBox(height: 16.px),
        Row(
          children: [
            commonRowForStrokesView(text1: 'Par 3s', text2: '0.0'),
            SizedBox(width: 24.px),
            commonRowForStrokesView(text1: 'Pars', text2: '1.0'),
          ],
        ),
        SizedBox(height: 8.px),
        Row(
          children: [
            commonRowForStrokesView(text1: 'Par 4s', text2: '0.0'),
            SizedBox(width: 24.px),
            commonRowForStrokesView(text1: 'Bogeys', text2: '1.0'),
          ],
        ),
        SizedBox(height: 8.px),
        Row(
          children: [
            commonRowForStrokesView(text1: 'Par 5s', text2: '0.0'),
            SizedBox(width: 24.px),
            commonRowForStrokesView(text1: 'Doubles+', text2: '2.0'),
          ],
        ),
      ],
    );
  }

  Widget commonScoringCardView({required StatsController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonTitleTextView(
          text: 'Scoring',
        ),
        SizedBox(height: 12.px),
        Row(
          children: [
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonSubTitleTextView(text: 'Key Stats'),
                  ListView.builder(
                    itemCount: controller.scoringCardDataList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 12.px),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.px),
                        child: commonTitleTextView(
                          text: controller.scoringCardDataList[index]
                              ['KeyStatsValue'],
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.px),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  commonSubTitleTextView(text: 'You'),
                  Container(
                    decoration: const BoxDecoration(color: Color(0xff0D0808)),
                    child: ListView.builder(
                      itemCount: controller.scoringCardDataList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 12.px),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: index !=
                                      controller.scoringCardDataList.length - 1
                                  ? 12.px
                                  : 0.px),
                          child: Center(
                            child: commonTitleTextView(
                              text: controller.scoringCardDataList[index]
                                  ['YouValue'],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.px),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  commonSubTitleTextView(text: '0 hcp'),
                  ListView.builder(
                    itemCount: controller.scoringCardDataList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 12.px),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.px),
                        child: Center(
                          child: commonTitleTextView(
                            text: controller.scoringCardDataList[index]
                                ['hcpValue'],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget drivingUiView({required StatsController controller}) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 16.px),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  CW.commonSwitchButton(
                    context: context,
                    value: controller.driverSwitchButtonValue,
                    onChanged: (value) =>
                        controller.clickOnDriverSwitchButton(),
                  ),
                  SizedBox(width: 8.px),
                  Text(
                    'Driver',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.px),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'View by',
                    style: Theme.of(context).textTheme.titleSmall,
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
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 16.px),
        CW.commonBlackCardView(
          height: 440.px,
          width: double.infinity,
          borderRadius: 24.px,
          padding: EdgeInsets.zero,
          context: context,
          widget: CW.imageView(
            image: 'assets/dummy_img/driver_maps_img.png',
            isAssetImage: true,
            width: double.infinity,
            height: 440.px,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(28.px),
          ),
        ),
        SizedBox(height: 16.px),
        commonTextButtonView(
          onTap: () =>
              controller.clickOnDriverViewShotDetailsButton(context: context),
        ),
        SizedBox(height: 16.px),
        commonTitleTextView(
          text: 'Scoring',
        ),
        SizedBox(height: 12.px),
        Table(
          columnWidths: {
            0: FlexColumnWidth(6),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2)
          },
          children: [
            TableRow(children: [
              commonSubTitleTextView(text: 'Key Stats'),
              commonSubTitleTextView(text: 'You'),
              commonSubTitleTextView(text: '0 hcp'),
            ]),
            TableRow(children: [
              commonTitleTextView(
                text: "Distance",
                color: Theme.of(context).colorScheme.surface,
              ),
              commonTitleTextView(
                  text: double.tryParse(
                          controller.reportDrivingModel?.totalDistance ?? '0')!
                      .toStringAsFixed(2)),
              commonTitleTextView(text: '0'),
            ]),
            TableRow(children: [
              commonTitleTextView(
                text: "Fairway%",
                color: Theme.of(context).colorScheme.surface,
              ),
              commonTitleTextView(
                  text: double.tryParse(
                          controller.reportDrivingModel?.fairwayPercentage ??
                              '0')!
                      .toStringAsFixed(2)),
              commonTitleTextView(text: '0'),
            ]),
            TableRow(children: [
              commonTitleTextView(
                text: "Standard Deviation",
                color: Theme.of(context).colorScheme.surface,
              ),
              commonTitleTextView(
                  text: double.tryParse(
                          controller.reportDrivingModel?.stdDeviation ?? '0')!
                      .toStringAsFixed(2)),
              commonTitleTextView(text: '0y'),
            ]),
            TableRow(children: [
              commonTitleTextView(
                text: "Miss Bias",
                color: Theme.of(context).colorScheme.surface,
              ),
              commonTitleTextView(
                  text: double.tryParse(
                          controller.reportDrivingModel?.missBias ?? '0')!
                      .toStringAsFixed(2)),
              commonTitleTextView(text: '0y'),
            ]),
            TableRow(children: [
              commonTitleTextView(
                text: "Strokes Gained",
                color: Theme.of(context).colorScheme.surface,
              ),
              commonTitleTextView(text: '0'),
              commonTitleTextView(text: '0y'),
            ]),
          ],
        ),
      ],
    );
  }

  Widget approachUiView({required StatsController controller}) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 16.px),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
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
                ),
                SizedBox(width: 16.px),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'View by',
                        style: Theme.of(context).textTheme.titleSmall,
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
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
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
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
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
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 16.px),
            CW.commonBlackCardView(
              height: 440.px,
              width: double.infinity,
              borderRadius: 24.px,
              padding: EdgeInsets.zero,
              context: context,
              widget: CW.imageView(
                image: 'assets/dummy_img/approach_maps_img.png',
                isAssetImage: true,
                width: double.infinity,
                height: 440.px,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(28.px),
              ),
            ),
            SizedBox(height: 16.px),
            commonTextButtonView(
              onTap: () => controller.clickOnApproachViewShotDetailsButton(
                  context: context),
            ),
            SizedBox(height: 16.px),
            commonTitleTextView(
              text: 'Scoring',
            ),
            SizedBox(height: 12.px),
            Table(
              columnWidths: {
                0: FlexColumnWidth(6),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(2)
              },
              children: [
                TableRow(children: [
                  commonSubTitleTextView(text: 'Key Stats'),
                  commonSubTitleTextView(text: 'You'),
                  commonSubTitleTextView(text: '0 hcp'),
                ]),
                TableRow(children: [
                  commonTitleTextView(
                    text: "Bias R/L",
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  commonTitleTextView(
                    text:
                        "${controller.reportApproachModel?.biasRL?.left ?? '0'}",
                  ),
                  commonTitleTextView(text: '0y'),
                ]),
                TableRow(children: [
                  commonTitleTextView(
                    text: "Bias Long/Short",
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  commonTitleTextView(
                    text:
                        "${controller.reportApproachModel?.biasLongShort?.long ?? '0'}",
                  ),
                  commonTitleTextView(text: '0y'),
                ]),
                TableRow(children: [
                  commonTitleTextView(
                    text: "Greens in Reg",
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  commonTitleTextView(
                      text: controller.reportApproachModel?.greensInReg ?? '0'),
                  commonTitleTextView(text: '0%'),
                ]),
                TableRow(children: [
                  commonTitleTextView(
                    text: "Average % miss",
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  commonTitleTextView(
                      text:
                          "${controller.reportApproachModel?.avgMiss ?? '0'}"),
                  commonTitleTextView(text: '0%'),
                ]),
                TableRow(children: [
                  commonTitleTextView(
                    text: "Strokes Gained",
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  commonTitleTextView(
                      text: double.parse(
                              "${controller.reportApproachModel?.strokesGained ?? '0'}")
                          .toStringAsFixed(2)),
                  commonTitleTextView(text: '0%'),
                ]),
                TableRow(children: [
                  commonTitleTextView(
                    text: "0-50 yard",
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  commonTitleTextView(
                      text: controller
                              .reportApproachModel?.yardagePercentages?.s050 ??
                          '0'),
                  commonTitleTextView(text: '0y'),
                ]),
                TableRow(children: [
                  commonTitleTextView(
                    text: "50-75yard",
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  commonTitleTextView(
                      text: controller
                              .reportApproachModel?.yardagePercentages?.s5075 ??
                          '0'),
                  commonTitleTextView(text: '0y'),
                ]),
                TableRow(children: [
                  commonTitleTextView(
                    text: "75-100 yard",
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  commonTitleTextView(
                      text: controller.reportApproachModel?.yardagePercentages
                              ?.s75100 ??
                          '0'),
                  commonTitleTextView(text: '0%'),
                ]),
                TableRow(children: [
                  commonTitleTextView(
                    text: "Upto 250 yard",
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  commonTitleTextView(
                      text: controller.reportApproachModel?.yardagePercentages
                              ?.s100250 ??
                          '0'),
                  commonTitleTextView(text: '0%'),
                ]),
              ],
            ),
            SizedBox(height: 48.px),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 16.px),
          child: commonFilterButtonView(
            onTap: () =>
                controller.clickOnApproachFilterButton(context: context),
          ),
        )
      ],
    );
  }

  Widget shortGameUiView({required StatsController controller}) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 16.px),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'Ending Lie',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(width: 8.px),
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
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
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
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
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
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.px),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'View by',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(width: 8.px),
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
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
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
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
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
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 16.px),
            CW.commonBlackCardView(
              height: 440.px,
              width: double.infinity,
              borderRadius: 24.px,
              padding: EdgeInsets.zero,
              context: context,
              widget: CW.imageView(
                image: 'assets/dummy_img/short_game_maps_img.png',
                isAssetImage: true,
                width: double.infinity,
                height: 440.px,
                fit: BoxFit.fill,
                borderRadius: BorderRadius.circular(28.px),
              ),
            ),
            SizedBox(height: 16.px),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filters',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                SizedBox(height: 24.px),
                Text(
                  'Lie',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                SizedBox(height: 12.px),
                Wrap(
                  spacing: 8.0,
                  children: ['Fairway', 'Sand', 'Bunker', 'Rough', 'Deep Rough']
                      .map(
                        (situation) => ChoiceChip(
                          label: Text(situation),
                          selected:
                              situation == controller.filterShortGameLieValue,
                          selectedColor: Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.px),
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.onSecondary,
                              width: .5.px,
                            ),
                          ),
                          onSelected: (value) {
                            setState(() {
                              controller.filterShortGameLieValue = situation;
                            });
                            controller.notifyListeners();
                          },
                          showCheckmark: false,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                color: situation ==
                                        controller.filterShortGameLieValue
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.surface,
                              ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 16.px),
                CW.commonGradiantDividerView(),
                SizedBox(height: 16.px),
                Text(
                  'Situation',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                SizedBox(height: 12.px),
                Wrap(
                  spacing: 8.0,
                  children: ['Normal', 'Short Sided', 'Severe Short Side']
                      .map(
                        (situation) => ChoiceChip(
                          label: Text(situation),
                          selected: situation ==
                              controller.filterShortGameSituationValue,
                          selectedColor: Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.px),
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.onSecondary,
                              width: .5.px,
                            ),
                          ),
                          onSelected: (value) {
                            setState(() {
                              controller.filterShortGameSituationValue =
                                  situation;
                            });
                            controller.notifyListeners();
                          },
                          showCheckmark: false,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                color: situation ==
                                        controller.filterShortGameSituationValue
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.surface,
                              ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
            SizedBox(height: 16.px),
            commonTextButtonView(
              onTap: () => controller.clickOnShortGameViewShotDetailsButton(
                  context: context),
            ),
            SizedBox(height: 16.px),
            commonScoringCardView(controller: controller),
            SizedBox(height: 48.px),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 16.px),
          child: commonFilterButtonView(
            onTap: () =>
                controller.clickOnShortGameFilterButton(context: context),
          ),
        )
      ],
    );
  }

  Widget puttingUiView({required StatsController controller}) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 16.px),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'View by',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(width: 8.px),
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
                                color: Theme.of(context).colorScheme.onPrimary,
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
            ),
          ],
        ),
        SizedBox(height: 16.px),
        // Container(
        //   width: double.infinity,
        //   height: 300,
        //   child: LineChart(
        //     LineChartData(
        //       lineBarsData: [
        //         LineChartBarData(
        //           spots: [
        //             FlSpot(0, 1),
        //             FlSpot(1, 1.5),
        //             FlSpot(2, 1.4),
        //             FlSpot(3, 3.4),
        //             FlSpot(4, 2),
        //           ],
        //           isCurved: true,
        //           color: Theme.of(context).primaryColor,
        //           //colors: [Colors.red],
        //           barWidth: 2,
        //           belowBarData: BarAreaData(
        //             gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Theme.of(context).primaryColor.withOpacity(.3),Theme.of(context).scaffoldBackgroundColor]),
        //             show: true,
        //            // colors: [Colors.red.withOpacity(0.3)],
        //           ),
        //         ),
        //       ],
        //     ),
        //   )
        //
        // ),
        CW.imageView(
          image: 'assets/dummy_img/make_graph_img.png',
          isAssetImage: true,
          width: double.infinity,
          height: 305.px,
          fit: BoxFit.fill,
          borderRadius: BorderRadius.circular(24.px),
        ),
        SizedBox(height: 16.px),
        CW.imageView(
          image: 'assets/dummy_img/strokes_graph_img.png',
          isAssetImage: true,
          width: double.infinity,
          height: 305.px,
          fit: BoxFit.fill,
          borderRadius: BorderRadius.circular(24.px),
        ),
        SizedBox(height: 16.px),
        commonTitleTextView(
          text: 'Putting',
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 8.px),
        /*
        commonGridView(list: controller.puttingDataList),
        SizedBox(height: 16.px),*/

        if (controller.puttingStats.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.puttingStats.length,
            itemBuilder: (context, index) {
              final item = controller.puttingStats[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 8.px),
                child: commonProgressBarView(
                  time: item.range ?? '0-3',
                  current: item.successRate ?? '0%',
                  total: item.attempts ?? '2/5',
                ),
              );
            },
          ),
        SizedBox(height: 16.px),
      ],
    );
  }

  Widget roundPerformanceUiView({required StatsController controller}) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 16.px),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Round Performance',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: 20.px),
                  ),
                  SizedBox(height: 6.px),
                  Text(
                    'March 15, 2025\nPine Valley Golf Club',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '72',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: 20.px,color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(height: 6.px),
                  Text(
                    'Final Score',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 16.px),
        CW.imageView(
          image: 'assets/dummy_img/Group 1000013956.png',
          isAssetImage: true,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 450,
          borderRadius: BorderRadius.circular(24.px),
        ),
        SizedBox(height: 16.px),
        CW.commonGradiantDividerView(),
        SizedBox(height: 16.px),
        commonTitleTextView(
          text: 'Strokes Analysis',
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
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
            },
            children: [
              buildTableRow("User's Target", "2.694"),
              buildTableRow("Predicted Score", "2.694"),
              buildTableRow("AI Target Score", "2.694"),
              buildTableRow("Strokes Lost", "0.201", isHeader: false),
            ],
          ),
        ),
        SizedBox(height: 16.px),
        commonTitleTextView(
          text: 'Hole Performance',
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 16.px),
        ListTile(
          leading: Column(children: [
            Text(
              'Hole 1',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Text(
              'Par 4',
              style:
              Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],),
          trailing: Column(children: [
            Text(
              '+0.5',
              style:Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Text(
              'vs AI',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],),
        ),
        ListTile(
          leading: Column(children: [
            Text(
              'Hole 2',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Text(
              'Par 4',
              style:
              Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],),
          trailing: Column(children: [
            Text(
              '-0.2',
              style:Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Text(
              'vs AI',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],),
        ),
        SizedBox(height: 16.px),
      ],
    );
  }

  TableRow buildTableRow(String first, String value, {bool isHeader = true}) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(14.px),
          child: Row(
            children: [
              Text(
                first,
                style: isHeader
                    ? Theme.of(context).textTheme.titleMedium
                    : Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(14.px),
          child: Text(
            value,
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
    required String current,
    required String total,
  }) {
    // Split the string at the '/' character
    List<String> parts = total.split('/');
    // Convert the parts to integers
    int first = int.parse(parts[0]);
    int second = int.parse(parts[1]);
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    print(first);
    print(second);
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    //if (first == 0 || second == 0) return SizedBox();
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
            Text(
              current,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
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
                  value: (first ==0 && second==0)?0.0:((first / second)),
                  backgroundColor: Colors.grey[800]!,
                  color: Theme.of(context).colorScheme.primary,
                  minHeight: 6.px,
                ),
              ),
            ),
            SizedBox(width: 10.px),
            Expanded(
              child: Text(
                total,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
