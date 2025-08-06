import 'dart:math';
import 'package:flutter/material.dart';
import 'package:golf_flutter/common/nm.dart';
import 'package:golf_flutter/screens/score_card/score_card_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../api/api_methods/api_methods.dart';
import '../../api/api_models/get_clubs_model.dart';
import '../../api/api_models/save_game_model.dart';
import '../../common/app_singleton.dart';
import '../../common/cm.dart';
import '../../common/cp/gradient_circular_progress_bar.dart';
import '../../common/cw.dart';

class PlayAtCourseController extends ChangeNotifier {
  bool inAsyncValue = false;
  bool isDragging = false;
  List<bool> pairLength = [false];
  int currentIndexValue = 0;
  int currentHoleIndexValue = 1;
  List<Offset> points = [
    const Offset(100, 650),
  ];
  List<Map<String, String>> data = [];
  List<Map<String, dynamic>> formattedDataAll = [];
  double distance = 0.0;
  List<GetClubsData> listOfClubs = [];
  List<String> options = ["Tee", "Fairway", "Green", "Sent", "Rough"];
  String selectedOption = "Fairway";
  String startingPosition = 'Tee';
  bool isMenuOpen = false;
  List<String> stockWindList = ['0', '5', '10', '15', '20', '25', '30+'];
  String selectedStockWind = "5";
  bool isStockWindOpen = false;
  bool includeInDispersionSwitchButtonValue = true;
  bool inBetweenAndStockNumberSwitchButtonValue = true;
  int selectedLevelValue = 0;
  int selectedStockWindValue = 0;
  int selectedClubsValue = 0;
  int countValue = 0;
  List levelTitleList = [
    'Rough',
    'Deep Rough',
    'Flyer',
    'Recovery',
  ];

  bool isInitCalled = false; // A flag to track if initMethod is called

  double calculateDistance(Offset point1, Offset point2) {
    return sqrt(pow(point1.dx - point2.dx, 2) + pow(point1.dy - point2.dy, 2));
  }

  Future<void> clickAddNewPointYard(
      {required BuildContext context, required TapDownDetails details}) async {
    if (!isDragging) {
      if (pairLength[currentIndexValue]) {
        currentIndexValue++;
        pairLength.add(false);
        points.add(details.localPosition);
        notifyListeners();
        if (calculateDistance(details.localPosition, Offset(150, 120)) < 30) {
         await  clickOnGolfBollButton(context: context);
          clickOnSaveShotButton(context: context);
        }
      } else {
        CM.showMyToastMessage('Please set short result!');
      }
    }
  }

  void onPanStart() {
    isDragging = true;
    notifyListeners();
  }

  void onPanUpdate(
      {required BuildContext context,
      required DragUpdateDetails details,
      required int index}) {
    points[index] = Offset(
      points[index].dx + details.delta.dx,
      points[index].dy + details.delta.dy,
    );
    notifyListeners();
    if (calculateDistance(points[index], Offset(150, 120)) < 30) {
      clickOnSaveShotButton(context: context);
    }
  }

  void onPanEnd() {
    isDragging = false;
    notifyListeners();
  }

  void onLongPress({required int index}) {
    points.removeAt(index);
    currentIndexValue--;
    pairLength.removeAt(index);
    notifyListeners();
  }

  void clickOnCancelButton({required BuildContext context}) {
    NM.popMethod(context: context);
  }

  void clickOnFlagButton({required BuildContext context}) {}

  void clickOnSettingButton({required BuildContext context}) {}

  Future<void> initMethod() async {
    if (!isInitCalled) {
      isInitCalled = true;
      GetClubsModel? getClubsModel = await ApiMethods.getClubs();
      if (getClubsModel != null &&
          getClubsModel.data != null &&
          getClubsModel.data!.isNotEmpty) {
        listOfClubs = getClubsModel.data!;
        notifyListeners();
      }
    }
  }

  Future<void> clickOnGolfBollButton({required BuildContext context}) {
   return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.px),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.px),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 14.px),
                    questionTextView(
                        text: '''Select a Club''', context: context),
                    SizedBox(height: 32.px),
                    Expanded(
                      child: ListView(
                        children: [
                          Wrap(
                            children: List.generate(
                              listOfClubs.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  selectedClubsValue = index;
                                  setState(() {});
                                },
                                child: Container(
                                  height: 54.px,
                                  width:
                                      MediaQuery.of(context).size.width * .14,
                                  padding: EdgeInsets.all(10.px),
                                  margin: EdgeInsets.only(
                                      left: 10.px, bottom: 10.px),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.px),
                                      border: Border.all(
                                          color: selectedClubsValue == index
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .error
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .surface)),
                                  child: Text(
                                    listOfClubs[index].code ?? '',
                                    //maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.px),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: commonTitleTextView(
                                    text: 'Ending Lie', context: context),
                              ),
                              SizedBox(width: 16.px),
                              GestureDetector(
                                onTap: () {
                                  isMenuOpen = !isMenuOpen;
                                  notifyListeners();
                                  setState((){});
                                },
                                child: CW.commonBlackCardView(
                                  context: context,
                                  widget: PopupMenuButton<String>(
                                    position: PopupMenuPosition.under,
                                    initialValue: selectedOption,
                                    onSelected: (value) {
                                      selectedOption = value;
                                      isMenuOpen = false;
                                      notifyListeners();
                                      setState((){});
                                    },
                                    onCanceled: () {
                                      isMenuOpen = false;
                                      notifyListeners();
                                      setState((){});
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    itemBuilder: (BuildContext context) {
                                      return options.map((String option) {
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
                                          color: isMenuOpen
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
                                            selectedOption,
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
                          SizedBox(height: 10.px),
                          Row(
                            children: [
                              Expanded(
                                child: commonTitleTextView(
                                    text: 'Include in dispersion',
                                    context: context),
                              ),
                              SizedBox(width: 16.px),
                              CW.commonSwitchButton(
                                context: context,
                                value: includeInDispersionSwitchButtonValue,
                                onChanged: (value) {
                                  includeInDispersionSwitchButtonValue =
                                      !includeInDispersionSwitchButtonValue;
                                  setState(() {});
                                },
                              ),
                              SizedBox(width: 8.px),
                              Icon(
                                Icons.info_outline,
                                color: Theme.of(context).colorScheme.surface,
                              )
                            ],
                          ),
                          if (countValue == 0)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10.px),
                                commonTitleTextView(
                                    text: 'Lie', context: context),
                                SizedBox(height: 10.px),
                                SizedBox(
                                  height: 32.px,
                                  child: ListView.builder(
                                    itemCount: levelTitleList.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          right:
                                              index != levelTitleList.length - 1
                                                  ? 6.px
                                                  : 0.px,
                                        ),
                                        child: CW.commonBlackCardView(
                                          context: context,
                                          onTap: () {
                                            selectedLevelValue = index;
                                            setState(() {});
                                          },
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.px,
                                              horizontal: 16.px),
                                          borderRadius: 16.px,
                                          isBlackBg:
                                              selectedLevelValue != index,
                                          widget: Center(
                                            child: Text(
                                              levelTitleList[index],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    color: selectedLevelValue ==
                                                            index
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 10.px),
                                commonTitleTextView(
                                    text: 'Stock Wind', context: context),
                                SizedBox(height: 10.px),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        isStockWindOpen = !isStockWindOpen;
                                        setState(() {});
                                      },
                                      child: CW.commonBlackCardView(
                                        context: context,
                                        widget: PopupMenuButton<String>(
                                          position: PopupMenuPosition.under,
                                          initialValue: selectedStockWind,
                                          onSelected: (value) {
                                            selectedStockWind = value;
                                            isStockWindOpen = false;
                                            setState(() {});
                                          },
                                          onCanceled: () {
                                            isStockWindOpen = false;
                                            setState(() {});
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          itemBuilder: (BuildContext context) {
                                            return stockWindList
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
                                            duration: const Duration(
                                                milliseconds: 200),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.px,
                                              vertical: 4.px,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              border: Border.all(
                                                color: isStockWindOpen
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
                                                  selectedStockWind,
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
                                    ),
                                    SizedBox(width: 20.px),
                                    Expanded(
                                      child: SizedBox(
                                        height: 38.px,
                                        child: ListView.builder(
                                          itemCount: 4,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              height: 32.px,
                                              width: 32.px,
                                              margin:
                                                  EdgeInsets.only(right: 8.px),
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/img/black_card_img.png'),
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  selectedStockWindValue =
                                                      index;
                                                  setState(() {});
                                                },
                                                child: Center(
                                                  child: RotatedBox(
                                                    quarterTurns: (index == 0)
                                                        ? 2
                                                        : (index == 1)
                                                            ? 4
                                                            : (index == 2)
                                                                ? 3
                                                                : 1,
                                                    child: Container(
                                                      height: 32.px,
                                                      width: 32.px,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            selectedStockWindValue ==
                                                                    index
                                                                ? Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .error
                                                                : Colors
                                                                    .transparent,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Center(
                                                        child: CW.imageView(
                                                          image:
                                                              'assets/icons/right_arrow_ic.png',
                                                          isAssetImage: true,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                          height: 20.px,
                                                          width: 20.px,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.px),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: commonTitleTextView(
                                          text: 'In Between', context: context),
                                    ),
                                    SizedBox(width: 16.px),
                                    CW.commonSwitchButton(
                                      context: context,
                                      value:
                                          inBetweenAndStockNumberSwitchButtonValue,
                                      onChanged: (value) {
                                        inBetweenAndStockNumberSwitchButtonValue =
                                            !inBetweenAndStockNumberSwitchButtonValue;
                                        setState(() {});
                                      },
                                    ),
                                    SizedBox(width: 8.px),
                                    Expanded(
                                      child: commonTitleTextView(
                                          context: context,
                                          text: 'Stock Number',
                                          textAlign: TextAlign.end),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          SizedBox(height: 10.px),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CW.commonGradiantDividerView(),
                              SizedBox(height: 12.px),
                              CW.commonElevatedButtonView(
                                context: context,
                                onTap: () {
                                  countValue++;
                                  pairLength[currentIndexValue] = true;
                                  notifyListeners();
                                  if (data.isNotEmpty && currentIndexValue>0) {
                                    startingPosition =
                                        data[currentIndexValue - 1]
                                                ['ending_lie'] ??
                                            'Fairway';
                                  }
                                  dataSave(context);
                                  NM.popMethod(context: context);
                                },
                                buttonText: 'Save Shot',
                              ),
                              SizedBox(height: 8.px),
                            ],
                          ),
                          SizedBox(height: 10.px),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  clickOnSaveShotButton({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 14.px),
                  questionTextView(
                      text: '''Stats Calculation Completed''',
                      context: context),
                  SizedBox(height: 14.px),
                  questionTextView(
                      text: '''Do you want to review your round stats now?''',
                      context: context),
                  SizedBox(height: 10.px),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CW.commonGradiantDividerView(),
                      SizedBox(height: 12.px),
                      Row(
                        children: [
                          Expanded(
                            child: inAsyncValue
                                ? GradientCircularProgressIndicator()
                                : CW.commonElevatedButtonView(
                                    context: context,
                                    onTap: () async {
                                      if(data.isNotEmpty)
                                        {
                                          data.removeAt(0);
                                        }
                                      Map<String, dynamic> formattedData = {
                                        "hitLocations": data,
                                        "courseId":
                                            "${AppSingleton.instance.courses?.sId}",
                                        "teeId":
                                            "${AppSingleton.instance.teeDetails?.sId}"
                                      };
                                      formattedDataAll.add(formattedData);
                                      inAsyncValue = true;
                                      setState(() {});
                                      print("Formatted Data: ${formattedData}");
                                      SaveGameModel? saveGameModel =
                                          await ApiMethods.saveGame(
                                              bodyParams: formattedData);
                                      if (saveGameModel != null &&
                                          saveGameModel.gameData != null) {
                                        removeData();
                                        NM.popMethod(context: context);
                                      }
                                      inAsyncValue = false;
                                      setState(() {});
                                      // clickOnSaveShotButton(context: context);
                                    },
                                    buttonText: 'Stay Here',
                                  ),
                          ),
                          SizedBox(width: 20.px),
                          Expanded(
                            child: CW.commonElevatedButtonView(
                              context: context,
                              isBlackBg: true,
                              // onTap: () {
                              //   countValue++;
                              //   setState(() {});
                              //   NM.popMethod(context: context);
                              //   clickOnSaveShotButton(context: context);
                              // },
                              onTap: () =>
                                  clickOnViewScorecard(context: context),
                              buttonText: 'Review Stats',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.px),
                    ],
                  ),
                  SizedBox(height: 10.px),
                  GestureDetector(
                    onTap: () => clickOnViewScorecard(context: context),
                    child: Center(
                      child: Text(
                        'View Scorecard',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.px),
                ],
              ),
            );
          },
        );
      },
    );
  }

  clickOnIncludeInDispersionSwitchButton() {
    includeInDispersionSwitchButtonValue =
        !includeInDispersionSwitchButtonValue;
    notifyListeners();
  }

  Widget questionNumberTextView(
          {required String text, required BuildContext context}) =>
      Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(fontWeight: FontWeight.w700),
      );

  Widget questionTextView(
          {required String text, required BuildContext context}) =>
      Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.w700),
      );

  Widget commonTitleTextView(
          {required String text,
          FontWeight? fontWeight,
          TextAlign? textAlign,
          required BuildContext context}) =>
      Text(
        text,
        textAlign: textAlign,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: fontWeight ?? FontWeight.w700,
            ),
      );

  clickOnViewScorecard({required BuildContext context}) {
    NM.popMethod(context: context);
    NM.pushMethod(
      screen: ScoreCardScreen(),
      context: context,
    );
  }

  clickOnClubCard({required int index}) {
    selectedClubsValue = index;
    notifyListeners();
  }

  clickOnSetShortResult({required BuildContext context}) {
    clickOnGolfBollButton(context: context);
  }

  removeData() {
    isDragging = false;
    distance = 0.0;
    points = [
      const Offset(100, 650),
    ];
    data.clear();
    currentIndexValue = 0;
    pairLength = [false];
    currentHoleIndexValue++;
    notifyListeners();
  }

  void dataSave(BuildContext context) {
    double distanceYard = 0;
    if (currentIndexValue <= 0) {
      distanceYard = calculateDistance(
          points[currentIndexValue], points[currentIndexValue]);
    } else {
      distanceYard = calculateDistance(
          points[currentIndexValue - 1], points[currentIndexValue]);
    }
    data.add({
      "club_id": "${listOfClubs[selectedClubsValue].sId}",
      "club_name": "${listOfClubs[selectedClubsValue].name}",
      'distance_yard': "$distanceYard",
      "ending_lie": selectedOption,
      "dispersion": "$includeInDispersionSwitchButtonValue",
      'lie': "${levelTitleList[selectedLevelValue]}",
      "wind_speed": "$selectedStockWindValue",
      "wind_direction": getDirection(),
      "in_between": "$inBetweenAndStockNumberSwitchButtonValue",
      "par": "$currentIndexValue",
      "starting_point": startingPosition,
      "distancePointToHole":
          "${calculateDistance(points[currentIndexValue], Offset(100, 650))}",
    });
    print("data:::::::${data}");
    print("data:::::::${AppSingleton.instance.courses}");
    print("data:::::::${AppSingleton.instance.courses?.sId}");
    print("data:::::::${AppSingleton.instance.teeDetails?.sId}");
  }

  getDirection() {
    switch (selectedStockWindValue) {
      case 0:
        return "Left";
      case 1:
        return "Right";
      case 2:
        return "Up";
      case 3:
        return "Down";
    }
  }

  void clearData() {
    distance = 0.0;
    currentIndexValue = 0;
    selectedLevelValue = 0;
    selectedStockWindValue = 0;
    selectedClubsValue = 0;
    countValue = 0;
    pairLength = [false];
    points = [
      const Offset(100, 650),
    ];
    levelTitleList = [
      'Rough',
      'Deep Rough',
      'Flyer',
      'Recovery',
    ];
    data = [];
    listOfClubs = [];
    options = ["Fairway"];
    stockWindList = ['0', '5', '10', '15', '20', '25', '30+'];
    selectedStockWind = "5";
    selectedOption = "Fairway";
    isDragging = false;
    isMenuOpen = false;
    isStockWindOpen = false;
    includeInDispersionSwitchButtonValue = true;
    inBetweenAndStockNumberSwitchButtonValue = true;
    isInitCalled = false; // A flag to track if initMethod is called
    notifyListeners();
  }
}
