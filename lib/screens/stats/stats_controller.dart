import 'package:flutter/material.dart';
import 'package:golf_flutter/api/api_methods/api_methods.dart';
import 'package:golf_flutter/api/api_models/report_approach_model.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/common/nm.dart';
import 'package:golf_flutter/screens/stats_data_list/stats_data_list_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../api/api_constants/api_key_constants.dart';
import '../../api/api_models/report_driving_model.dart';
import '../../api/api_models/report_putting_model.dart';

class StatsController extends ChangeNotifier {
  List<List<num>> data = [
    [
      5.0,
      5.0,
      5.0,
      5.0,
      5.0,
      5.0,
      5.0,
    ]
  ];
  final ticks = [0, 2, 4, 6, 8, 10, 12];
  final colorList = [
    const Color(0xff62ACD6),
    const Color(0xffE69138),
    const Color(0xff4EA8A8),
    const Color(0xff38761D),
    const Color(0xff504EA8),
    const Color(0xff674EA8),
    const Color(0xff6499E8),
  ];
  final features = [
    "General",
    "Work",
    "Play",
    "Religious",
    "Office",
    "University",
    "Pub",
  ];

  List tabTitleList = [
    'Scores',
    'Driving',
    'Approach',
    'Short Game',
    'Putting',
    'Course Management',
  ];

  final List progressBarListData = [
    {"title": "0-3'", "current": 10, "total": 10},
    {"title": "3-6'", "current": 2, "total": 2},
    {"title": "6-9'", "current": 2, "total": 5},
    {"title": "9-15'", "current": 0, "total": 2},
    {"title": "15-24'", "current": 2, "total": 2},
    {"title": "24-39'", "current": 0, "total": 2},
    {"title": "40+'", "current": 0, "total": 2},
  ];

  final List<double> dataPoints = [
    1.4,
    1.3,
    2.0,
    0.9,
  ];
  final List<String> labels = [
    "Driving",
    "Approach",
    "Short",
    "Putting",
  ];
  final double totalStrokes = 16.8;
  final int highlightedIndex = 2;
  final String highlightedValue = "80/63";

  final List<String> options = ["Last 5", "Last 20", "Last 100"];
  String selectedOption = "Last 100";
  bool isMenuOpen = false;

  final List<String> optionsComparison = [
    "tour pro,",
    "D1",
    "scratch",
    "5",
    '10',
    '15',
    '20',
    '25',
    '30'
  ];
  String selectedOptionComparison = "tour pro";
  bool isMenuOpenComparison = false;

  List scoringCardDataList = [
    {"KeyStatsValue": "Distance", "YouValue": "274y", "hcpValue": "0"},
    {"KeyStatsValue": "Fairway%", "YouValue": "54", "hcpValue": "0"},
    {
      "KeyStatsValue": "Standard Deviation",
      "YouValue": "22y",
      "hcpValue": "0y"
    },
    {"KeyStatsValue": "Miss Bias", "YouValue": "5y", "hcpValue": "0y"},
    {"KeyStatsValue": "Strokes Gained", "YouValue": "+1.54", "hcpValue": "-"},
  ];

  bool driverSwitchButtonValue = false;

  String filterApproachSituationValue = '';
  bool inBetweenSwitchButtonValue = false;

  String filterShortGameLieValue = '';
  String filterShortGameSituationValue = '';

  void onChanged({required BuildContext context, required String value}) {}

  void clickOnDriverSwitchButton() {
    driverSwitchButtonValue = !driverSwitchButtonValue;
    notifyListeners();
  }

  bool isInitCalled = false;
  bool inAsyncCall = true;
  List<DrivingData> drivingData = [];
  List<int> strokesGained = [];
  ReportDrivingModel? reportDrivingModel;

  List<ApproachData> approachData = [];
  ReportApproachModel? reportApproachModel;
  ReportPuttingModel? reportPuttingModel;
  List<PuttingStats> puttingStats = [];

  Future<void> initMethod() async {
    if (!isInitCalled) {
      isInitCalled = true;
      inAsyncCall = true;
      reportDrivingModel = await ApiMethods.reportDriving(queryParameters: {
        ApiKeyConstants.club: 'All',
      });
      notifyListeners();
      if (reportDrivingModel != null) {
        if (reportDrivingModel!.drivingData != null &&
            reportDrivingModel!.drivingData!.isNotEmpty) {
          drivingData = reportDrivingModel!.drivingData!;
          notifyListeners();
        }
        if (reportDrivingModel!.strokesGained != null &&
            reportDrivingModel!.strokesGained!.isNotEmpty) {
          strokesGained = reportDrivingModel!.strokesGained!;
          notifyListeners();
        }
      }

      reportApproachModel = await ApiMethods.reportApproach(queryParameters: {
        ApiKeyConstants.club: 'All',
      });
      notifyListeners();
      if (reportApproachModel != null) {
        if (reportApproachModel!.approachData != null &&
            reportApproachModel!.approachData!.isNotEmpty) {
          approachData = reportApproachModel!.approachData!;
          notifyListeners();
        }
      }
      reportPuttingModel = await ApiMethods.reportPutting(queryParameters: {
        ApiKeyConstants.club: 'All',
      });
        if (reportPuttingModel != null&&reportPuttingModel!.puttingStats != null &&
            reportPuttingModel!.puttingStats!.isNotEmpty) {
          puttingStats = reportPuttingModel!.puttingStats!;
          print('Putter length : ---> ${puttingStats.length}');
          notifyListeners();
        }
      notifyListeners();
    }
    inAsyncCall = false;
    notifyListeners();
  }

  void clickOnDriverViewShotDetailsButton({required BuildContext context}) {
    NM.pushMethod(
      context: context,
      screen: StatsDataListScreen(
        shortListData: const [
          {
            'ClubShotDistanceValue': 'Dr - 297 yards',
            'ClubShotDistanceDetail': 'to Rough -26y right',
            'StrokesGainedValue': '-0.04'
          },
          {
            'ClubShotDistanceValue': 'Dr - 300 yards',
            'ClubShotDistanceDetail': 'to Rough -26y right',
            'StrokesGainedValue': '+0.01'
          },
          {
            'ClubShotDistanceValue': 'Dr - 290 yards',
            'ClubShotDistanceDetail': 'to Rough -26y right',
            'StrokesGainedValue': '+0.01'
          },
          {
            'ClubShotDistanceValue': 'Dr - 297 yards',
            'ClubShotDistanceDetail': 'to Rough -26y right',
            'StrokesGainedValue': '+0.01'
          },
          {
            'ClubShotDistanceValue': 'Dr - 290 yards',
            'ClubShotDistanceDetail': 'to Rough -26y right',
            'StrokesGainedValue': '+0.01'
          },
          {
            'ClubShotDistanceValue': 'Dr - 303 yards',
            'ClubShotDistanceDetail': 'to Rough -26y right',
            'StrokesGainedValue': '+0.01'
          },
          {
            'ClubShotDistanceValue': '3W - 279 yards',
            'ClubShotDistanceDetail': 'to Rough -26y right',
            'StrokesGainedValue': '+0.01'
          },
          {
            'ClubShotDistanceValue': 'Dr - 297 yards',
            'ClubShotDistanceDetail': 'to Rough -26y right',
            'StrokesGainedValue': '+0.01'
          },
          {
            'ClubShotDistanceValue': 'Dr - 297 yards',
            'ClubShotDistanceDetail': 'to Rough -26y right',
            'StrokesGainedValue': '-0.04'
          },
          {
            'ClubShotDistanceValue': 'Dr - 297 yards',
            'ClubShotDistanceDetail': 'to Rough -26y right',
            'StrokesGainedValue': '-0.04'
          },
        ],
      ),
    );
  }

  void clickOnApproachViewShotDetailsButton({required BuildContext context}) {
    NM.pushMethod(
      context: context,
      screen: StatsDataListScreen(
        shortListData: const [
          {
            'ClubShotDistanceValue': '214 yards - Rough',
            'ClubShotDistanceDetail':
                '''3W to Fairway - 67' to hole\n0' short right of target''',
            'StrokesGainedValue': '+0.01'
          },
          {
            'ClubShotDistanceValue': '97 yards - Rough',
            'ClubShotDistanceDetail':
                '''Unknown Club to Green - 2' to hole\n22' long left of target''',
            'StrokesGainedValue': '+0.01'
          },
          {
            'ClubShotDistanceValue': '231 yards - Tee',
            'ClubShotDistanceDetail':
                '''5i to Green - 43' to hole\n0' short right of target''',
            'StrokesGainedValue': '+0.01'
          },
          {
            'ClubShotDistanceValue': '274 yards - Fairway',
            'ClubShotDistanceDetail':
                '''5i to Rough - 80y to hole\n62' short left of target''',
            'StrokesGainedValue': '-0.04'
          },
          {
            'ClubShotDistanceValue': '214 yards - Rough',
            'ClubShotDistanceDetail':
                '''3W to Fairway - 67' to hole\n0' short right of target''',
            'StrokesGainedValue': '+0.01'
          },
          {
            'ClubShotDistanceValue': '97 yards - Rough',
            'ClubShotDistanceDetail':
                '''Unknown Club to Green - 2' to hole\n22' long left of target''',
            'StrokesGainedValue': '+0.01'
          },
          {
            'ClubShotDistanceValue': '231 yards - Tee',
            'ClubShotDistanceDetail':
                '''5i to Green - 43' to hole\n0' short right of target''',
            'StrokesGainedValue': '+0.01'
          },
          {
            'ClubShotDistanceValue': '274 yards - Fairway',
            'ClubShotDistanceDetail':
                '''5i to Rough - 80y to hole\n62' short left of target''',
            'StrokesGainedValue': '-0.04'
          },
        ],
      ),
    );
  }

  void clickOnApproachFilterButton({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.px),
        ),
      ),
      builder: (context) => buildApproachFilterBottomSheet(context),
    );
  }

  Widget buildApproachFilterBottomSheet(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px),
              child: Column(
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
                    'Situation',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                  SizedBox(height: 12.px),
                  Wrap(
                    spacing: 8.0,
                    children: [
                      'Tee',
                      'Sand',
                      'Rough',
                      'Deep Rough',
                      'Flyer',
                      'Recovery',
                    ]
                        .map(
                          (situation) => ChoiceChip(
                            label: Text(situation),
                            selected: situation == filterApproachSituationValue,
                            selectedColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.px),
                              side: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                width: .5.px,
                              ),
                            ),
                            onSelected: (value) {
                              setState(() {
                                filterApproachSituationValue = situation;
                              });
                              notifyListeners();
                            },
                            showCheckmark: false,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: situation ==
                                          filterApproachSituationValue
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
                    'Wind',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                  SizedBox(height: 12.px),
                  SizedBox(
                    height: 40.px,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CW.commonTextFieldForLoginSignUP(
                              context: context,
                              hintText: '# MPH',
                              contentPadding: EdgeInsets.only(
                                  top: 10.px, left: 16.px, right: 16.px)),
                        ),
                        SizedBox(width: 6.px),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              buildArrowButton(
                                  context: context,
                                  icon: Icons.arrow_back_rounded,
                                  isSelected: false),
                              buildArrowButton(
                                  context: context,
                                  icon: Icons.arrow_forward_rounded,
                                  isSelected: true),
                              buildArrowButton(
                                  context: context,
                                  icon: Icons.arrow_upward,
                                  isSelected: false),
                              buildArrowButton(
                                  context: context,
                                  icon: Icons.arrow_downward,
                                  isSelected: false),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.px),
                  CW.commonGradiantDividerView(),
                  SizedBox(height: 16.px),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'In Between',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      CW.commonSwitchButton(
                        context: context,
                        value: inBetweenSwitchButtonValue,
                        onChanged: (value) {
                          setState(() {
                            inBetweenSwitchButtonValue = value;
                          });
                        },
                      ),
                      Text(
                        'Stock Number',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.px),
                ],
              ),
            ),
            CW.commonGradiantDividerView(),
            SafeArea(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.px, vertical: 12.px),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CW.commonElevatedButtonView(
                      context: context,
                      isBlackBg: true,
                      width: 110.px,
                      onTap: () => NM.popMethod(context: context),
                      buttonText: 'Reset',
                    ),
                    SizedBox(width: 16.px),
                    Expanded(
                      child: CW.commonElevatedButtonView(
                        context: context,
                        onTap: () => NM.popMethod(context: context),
                        buttonText: 'Apply Filters',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildArrowButton({
    required BuildContext context,
    required IconData icon,
    required bool isSelected,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.px),
      child: CW.commonBlackCardView(
        context: context,
        isBlackBg: !isSelected,
        height: 30.px,
        width: 30.px,
        borderRadius: 15.px,
        widget: Icon(
          icon,
          color: Theme.of(context).colorScheme.onPrimary,
          size: 16,
        ),
      ),
    );
  }

  void clickOnShortGameViewShotDetailsButton({required BuildContext context}) {
    NM.pushMethod(
      context: context,
      screen: StatsDataListScreen(
        shortListData: const [
          {
            'ClubShotDistanceValue': '274 yards - Fairway',
            'ClubShotDistanceDetail':
                '''5i to Rough - 80y to hole\n62' short left of target''',
            'StrokesGainedValue': '-0.04'
          },
          {
            'ClubShotDistanceValue': '231 yards - Tee',
            'ClubShotDistanceDetail':
                '''5i to Green - 43' to hole\n0' short right of target''',
            'StrokesGainedValue': '+0.01'
          },
          {
            'ClubShotDistanceValue': '97 yards - Rough',
            'ClubShotDistanceDetail':
                '''Unknown Club to Green - 2' to hole\n22' long left of target''',
            'StrokesGainedValue': '+0.01'
          },
          {
            'ClubShotDistanceValue': '214 yards - Rough',
            'ClubShotDistanceDetail':
                '''3W to Fairway - 67' to hole\n0' short right of target''',
            'StrokesGainedValue': '+0.01'
          },
          {
            'ClubShotDistanceValue': '214 yards - Rough',
            'ClubShotDistanceDetail':
                '''3W to Fairway - 67' to hole\n0' short right of target''',
            'StrokesGainedValue': '+0.01'
          },
          {
            'ClubShotDistanceValue': '97 yards - Rough',
            'ClubShotDistanceDetail':
                '''Unknown Club to Green - 2' to hole\n22' long left of target''',
            'StrokesGainedValue': '+0.01'
          },
          {
            'ClubShotDistanceValue': '231 yards - Tee',
            'ClubShotDistanceDetail':
                '''5i to Green - 43' to hole\n0' short right of target''',
            'StrokesGainedValue': '+0.01'
          },
          {
            'ClubShotDistanceValue': '274 yards - Fairway',
            'ClubShotDistanceDetail':
                '''5i to Rough - 80y to hole\n62' short left of target''',
            'StrokesGainedValue': '-0.04'
          },
        ],
      ),
    );
  }

  void clickOnShortGameFilterButton({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.px),
        ),
      ),
      builder: (context) => buildShortGameFilterBottomSheet(context),
    );
  }

  Widget buildShortGameFilterBottomSheet(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px),
              child: Column(
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
                    children: [
                      'Fairway',
                      'Sand',
                      'Bunker',
                      'Rough',
                      'Deep Rough'
                    ]
                        .map(
                          (situation) => ChoiceChip(
                            label: Text(situation),
                            selected: situation == filterShortGameLieValue,
                            selectedColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.px),
                              side: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                width: .5.px,
                              ),
                            ),
                            onSelected: (value) {
                              setState(() {
                                filterShortGameLieValue = situation;
                              });
                              notifyListeners();
                            },
                            showCheckmark: false,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: situation == filterShortGameLieValue
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
                            selected:
                                situation == filterShortGameSituationValue,
                            selectedColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.px),
                              side: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                width: .5.px,
                              ),
                            ),
                            onSelected: (value) {
                              setState(() {
                                filterShortGameSituationValue = situation;
                              });
                              notifyListeners();
                            },
                            showCheckmark: false,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: situation ==
                                          filterShortGameSituationValue
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.surface,
                                ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 24.px),
                ],
              ),
            ),
            CW.commonGradiantDividerView(),
            SafeArea(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.px, vertical: 12.px),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CW.commonElevatedButtonView(
                      context: context,
                      isBlackBg: true,
                      width: 110.px,
                      onTap: () => NM.popMethod(context: context),
                      buttonText: 'Reset',
                    ),
                    SizedBox(width: 16.px),
                    Expanded(
                      child: CW.commonElevatedButtonView(
                        context: context,
                        onTap: () => NM.popMethod(context: context),
                        buttonText: 'Apply Filters',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
