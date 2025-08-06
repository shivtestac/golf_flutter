import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:golf_flutter/api/api_constants/api_key_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/nm.dart';
import '../bottom_bar/bottom_bar_screen.dart';
import '../on_boarding/on_boarding_screen.dart';
import '../your_dispersion/your_dispersion_screen.dart';

class SplashController extends ChangeNotifier {
  bool valueMethod = true;

  switchMethod(bool value) {
    valueMethod = value;
    notifyListeners();
  }

  void initMethod({required BuildContext context}) {
    Timer(const Duration(seconds: 2), () async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      //sharedPreferences.clear();
      if (sharedPreferences.getString(ApiKeyConstants.token) != null) {
        NM.pushMethod(context: context, screen: const BottomBarScreen());
      }else{
        NM.pushAndRemoveUntilMethod(
          context: context,
          screen:const OnBoardingScreen(),//YourDispersionScreen()
        );
      }
    });
  }
}
