import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:golf_flutter/common/nm.dart';
import 'package:golf_flutter/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../api/api_constants/api_key_constants.dart';
import '../../api/api_methods/api_methods.dart';
import '../../api/api_models/get_clubs_model.dart';
import '../../api/api_models/step4_model.dart';
import '../../api/api_models/step_model.dart';
import '../../common/cm.dart';

class YourDispersionController extends ChangeNotifier {
  int pageIndex = 0;

  bool isTimeValue = true;

  PageController pageController = PageController();

  String isLeftRightCardSelectedValue = '';

  int timerTime = 5;
  Timer? timer;

  List<GetClubsData> getClubsData = [];

  int selectedNumber = 25;
  final List<int> items = List.generate(50, (index) => index * 5);

  List<String> firstQuesRadioTitleList = [
    'Draw',
    'Straight',
    'Fade',
  ];

  String firstQuesRadioSelectedValue = '';

  List<String> secondQuesRadioTitleList = [
    'Left',
    'Right',
    'Both',
  ];

  String secondQuesRadioSelectedValue = '';

  double progress = 0.5;

  String get progressPercentage => '${(progress * 100).toInt()}%';

  List progressBarPerList = [
    '100%',
    '90%',
    '80%',
    '70%',
    '60%',
    '50%',
    '40%',
    '30%',
    '20%',
    '10%',
    '',
    '',
  ];


  List<GetClubsData> getClubsDataSelected = [];

  final List<String> options = ["Fairway"];
  String selectedOption = "Fairway";
  bool isMenuOpen = false;

  final List<String> stockWindList = ['0', '5', '10', '15', '20', '25', '30+'];
  String selectedStockWind = "5";
  bool isStockWindOpen = false;

  bool includeInDispersionSwitchButtonValue = true;
  bool inBetweenAndStockNumberSwitchButtonValue = true;

  int selectedLevelValue = 0;
  int selectedStockWindValue = 0;
  int selectedClubsValue = 0;

  List levelTitleList = [
    'Rough',
    'Deep Rough',
    'Flyer',
    'Recovery',
  ];

  String selectedGender = '';

  bool inAsyncCall = false;

  TextEditingController yourHandicapIndexController = TextEditingController();

  void clickOnSkipButton({required BuildContext context}) {
    clickOnCloseButton(context: context);
  }

  Future<void> clickOnContinueButton({required BuildContext context}) async {
    if (pageIndex == 0) {
      if (pageIndex != 7) {
        pageController.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.linear);
      }
    } else if (pageIndex == 1) {
      if (yourHandicapIndexController.text.trim().isNotEmpty) {
        Map<String, dynamic> bodyParams = {
          ApiKeyConstants.handicap: yourHandicapIndexController.text
        };
        inAsyncCall = true;
        notifyListeners();
        StepModel? stepModel = await ApiMethods.step1(bodyParams: bodyParams);
        if (stepModel != null && stepModel.user != null) {
          if (pageIndex != 7) {
            pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
          }
        }
      } else {
        CM.showMyToastMessage('Handicap field require!');
      }
      inAsyncCall = false;
      notifyListeners();
    } else if (pageIndex == 2) {
      if (isLeftRightCardSelectedValue.isNotEmpty) {
        Map<String, dynamic> bodyParams = {
          ApiKeyConstants.handPreference:
              isLeftRightCardSelectedValue == 'L' ? 'left' : 'right'
        };
        inAsyncCall = true;
        notifyListeners();
        StepModel? stepModel = await ApiMethods.step2(bodyParams: bodyParams);
        if (stepModel != null && stepModel.user != null) {
          if (pageIndex != 7) {
            pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
          }
        }
      } else {
        CM.showMyToastMessage('Please select card!');
      }
      inAsyncCall = false;
      notifyListeners();
    } else if (pageIndex == 3) {
      initMethod();
      if (firstQuesRadioSelectedValue.isNotEmpty &&
          secondQuesRadioSelectedValue.isNotEmpty) {
        Map<String, dynamic> bodyParams = {
          ApiKeyConstants.drivingDistance: selectedNumber,
          ApiKeyConstants.shotShape: firstQuesRadioSelectedValue.toLowerCase(),
          ApiKeyConstants.commonMiss: secondQuesRadioSelectedValue.toLowerCase(),
        };
        inAsyncCall = true;
        notifyListeners();
        StepModel? stepModel = await ApiMethods.step3(bodyParams: bodyParams);
        if (stepModel != null && stepModel.user != null) {
          if (pageIndex != 7) {
            pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
          }
        }
      } else {
        CM.showMyToastMessage('All field require!');
      }
      inAsyncCall = false;
      notifyListeners();
    } else if (pageIndex == 4) {
      if (getClubsDataSelected.isNotEmpty) {
        Map<String, dynamic> bodyParams = {
          ApiKeyConstants.clubStringIds: jsonEncode(getClubsDataSelected.map((club) => club.sId).toList())
        };
        inAsyncCall = true;
        notifyListeners();
        Step4Model? step4Model = await ApiMethods.step4(bodyParams: bodyParams);
        if (step4Model?.status != null && step4Model!.status!) {
        if (pageIndex != 7) {
          pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear);
        }
        }
      } else {
        CM.showMyToastMessage('Please add minimum 1 card!');
      }
      inAsyncCall = false;
      notifyListeners();
    } else if (pageIndex == 5) {
      Map<String, dynamic> bodyParams = {
        ApiKeyConstants.fairwayPercentage:
            int.parse(progressPercentage.replaceAll('%', ''))
      };
      inAsyncCall = true;
      notifyListeners();
      StepModel? stepModel = await ApiMethods.step5(bodyParams: bodyParams);
      if (stepModel != null && stepModel.user != null) {
        if (pageIndex != 7) {
          pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear);
        }
      }
      inAsyncCall = false;
      notifyListeners();
    } else {
      if (pageIndex != 7) {
        pageController.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.linear);
      }
    }
  }

  void clickOnCloseButton({required BuildContext context}) {
    if (isTimeValue) {
      NM.pushAndRemoveUntilMethod(
          context: context, screen: const BottomBarScreen());
    }
    isTimeValue = false;
    notifyListeners();
  }

  void onPageChanged({required int value}) {
    pageIndex = value;
    notifyListeners();
  }

  void clickOnLAndRCardView({required String value}) {
    isLeftRightCardSelectedValue = value;
    notifyListeners();
  }

  void clickOnFirstQuesRadioButton({required int index}) {
    firstQuesRadioSelectedValue = firstQuesRadioTitleList[index];
    notifyListeners();
  }

  void clickOnSecondQuesRadioButton({required int index}) {
    secondQuesRadioSelectedValue = secondQuesRadioTitleList[index];
    notifyListeners();
  }

  clickOnIncludeInDispersionSwitchButton() {
    includeInDispersionSwitchButtonValue =
        !includeInDispersionSwitchButtonValue;
    notifyListeners();
  }

  clickOnInBetweenAndStockNumberSwitchButton() {
    inBetweenAndStockNumberSwitchButtonValue =
        !inBetweenAndStockNumberSwitchButtonValue;
    notifyListeners();
  }

  void clickOnLevelCardView({required int index}) {
    selectedLevelValue = index;
    notifyListeners();
  }

  clickOnStockWindArrow({required int index}) {
    selectedStockWindValue = index;
    notifyListeners();
  }

  clickOnClubCard({required int index}) {
    if (getClubsDataSelected.contains(getClubsData[index])) {
      getClubsDataSelected.remove(getClubsData[index]);
    } else {
      getClubsDataSelected.add(getClubsData[index]);
    }
    notifyListeners();
  }

  Widget commonCheckBoxView({required bool checkValue}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 16.px,
          width: 16.px,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.px),
              border: Border.all(
                width: 1.px,
                color: checkValue
                    ? const Color(0xffFF0023)
                    : const Color(0xff2E2525),
              ),
              color: checkValue ? const Color(0xffB50005) : Colors.transparent),
          /*child: checkValue
              ? Center(
            child: CW.imageView(
                image: 'assets/icons/check_ic.png',
                isAssetImage: true,
                height: 16.px,
                width: 16.px
            ),
          )
              : const SizedBox(),*/
        ),
      ],
    );
  }

  clickOnRadioButton({required String selectedValue}) {
    selectedGender = selectedValue;
    notifyListeners();
  }

  Future<void> initMethod() async {
    GetClubsModel? getClubsModel = await ApiMethods.getClubs();
    if (getClubsModel != null &&
        getClubsModel.data != null &&
        getClubsModel.data!.isNotEmpty) {
      getClubsData = getClubsModel.data!;
      notifyListeners();
    }
  }
}
