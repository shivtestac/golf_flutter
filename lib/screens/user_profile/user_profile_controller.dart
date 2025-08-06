import 'package:flutter/material.dart';
import 'package:golf_flutter/common/nm.dart';
import 'package:golf_flutter/screens/followers/followers_screen.dart';
import 'package:golf_flutter/screens/splash/splash_screen.dart';
import 'package:golf_flutter/screens/update_profile/update_profile_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_methods/api_methods.dart';
import '../../api/api_models/user_model.dart';
import '../../common/app_singleton.dart';

class UserProfileController extends ChangeNotifier {
  String currentPageIndex = '0';

  final List<String> options = ["Last 5", "Last 20", "Last 100"];
  String selectedOption = "Last 100";

  final List<Map<String, dynamic>> strokesData = [
    {
      'value': -2.6,
      'label': 'Driving',
      'color': Colors.red,
      'topColorHeight': 35.px,
      'bottomColorHeight': 35.px,
    },
    {
      'value': 1.2,
      'label': 'Approach',
      'color': Colors.green,
      'topColorHeight': 19.px,
      'bottomColorHeight': 70.px,
    },
    {
      'value': 1.0,
      'label': 'Short',
      'color': Colors.brown[400],
      'topColorHeight': 19.px,
      'bottomColorHeight': 70.px,
    },
    {
      'value': -0.9,
      'label': 'Putting',
      'color': Colors.brown[400],
      'topColorHeight': 19.px,
      'bottomColorHeight': 70.px,
    },
  ];

  String selectedChipsValue = "All";

  List practiceChipsList = [
    'All',
    'Putting',
    'Short Game',
    'Full Swing',
  ];

  List practiceCardDataList = [
    'Lag Putt Tornado Lag Putt Tornado',
    'Stroke test',
    'Marketable',
  ];

  bool isChipsDataLoadValue = false;

  UserData? data;
  bool inAsyncCall = true; // A flag to track if initMethod is called
  bool isInitCalled = false; // A flag to track if initMethod is called

  Future<void> initMethod() async {
    if (!isInitCalled) {
      isInitCalled = true;
      UserModel? userModel = await ApiMethods.getIn();
      if (userModel != null && userModel.data != null) {
        data = userModel.data!;
        AppSingleton.instance.userData = data;
        notifyListeners();
      }
    }
    inAsyncCall = false;
  }

  void clickOnBackButton({required BuildContext context}) {
    NM.popMethod(context: context);
  }

  void onPageChange({required int value}) {
    currentPageIndex = value.toString();
    notifyListeners();
  }

  void clickOnStartRoundButton({required BuildContext context}) {}

  void clickOSubscribeNowButton({required BuildContext context}) {}

  Future<void> clickOnPracticeChipsList({
    required BuildContext context,
    required int index,
  }) async {
    isChipsDataLoadValue = true;
    if (!selectedChipsValue.contains(practiceChipsList[index])) {
      selectedChipsValue = practiceChipsList[index];
      notifyListeners();
    }
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        isChipsDataLoadValue = false;
      },
    );
    notifyListeners();
  }

  void clickOnFollowersView({required BuildContext context}) {
    NM.pushMethod(
        context: context,
        screen: const FollowersScreen(
          screenType: 'Followers',
        ));
  }

  void clickOnFollowingView({required BuildContext context}) {
    NM.pushMethod(
        context: context,
        screen: const FollowersScreen(
          screenType: 'Following',
        ));
  }

  clickOnEditButton({required BuildContext context}) async {
    NM.pushMethod(context: context, screen: const UpdateProfileScreen());
  }

  clickOnLogoutButton({required BuildContext context})async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    prefs.clear();
    NM.pushAndRemoveUntilMethod(context: context, screen: SplashScreen());
  }
}
