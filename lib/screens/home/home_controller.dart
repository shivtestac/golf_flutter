import 'package:flutter/cupertino.dart';
import 'package:golf_flutter/common/nm.dart';
import 'package:golf_flutter/screens/notification/notification_screen.dart';
import 'package:golf_flutter/screens/search/search_screen.dart';
import 'package:golf_flutter/screens/user_profile/user_profile_screen.dart';

import '../../api/api_methods/api_methods.dart';
import '../../api/api_models/user_model.dart';
import '../../common/app_singleton.dart';

class HomeController extends ChangeNotifier {
  List daysNameList = [
    {'daysName': 'Mon', 'value': true},
    {'daysName': 'Tue', 'value': false},
    {'daysName': 'Wed', 'value': true},
    {'daysName': 'Thu', 'value': true},
    {'daysName': 'Fri', 'value': true},
    {'daysName': 'Sat', 'value': false},
    {'daysName': 'Sun', 'value': true},
  ];

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

  void clickOnSearchIcon({required BuildContext context}) {
    NM.pushMethod(context: context, screen: const SearchScreen());
  }

  void clickOnNotificationIcon({required BuildContext context}) {
    NM.pushMethod(context: context, screen: const NotificationScreen());
  }

  void clickOnRightArrowCardView({required BuildContext context}) {
    // NM.pushMethod(context: context, screen: const NotificationScreen());
  }

  void clickOnPracticeCardRightArrow({required BuildContext context}) {
    //NM.pushMethod(context: context, screen: const NotificationScreen());
  }

  void clickOnWatchConnectButton({required BuildContext context}) {
    //NM.pushMethod(context: context, screen: const NotificationScreen());
  }

  void clickOSubscribeNowButton({required BuildContext context}) {
    //NM.pushMethod(context: context, screen: const NotificationScreen());
  }

  void clickOnProfile({required BuildContext context}) {
    NM.pushMethod(context: context, screen: const UserProfileScreen());
  }
}
