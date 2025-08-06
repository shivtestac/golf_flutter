import 'package:flutter/cupertino.dart';
import 'package:golf_flutter/common/nm.dart';
import 'package:golf_flutter/screens/play_at_course_ai_caddie/play_at_course_ai_caddie_screen.dart';

import '../../api/api_methods/api_methods.dart';
import '../../api/api_models/get_clubs_model.dart';

class AiCaddieController extends ChangeNotifier {
  List<GetClubsData> listOfClubs = [];
  int selectedClubsValue = 0;
  int selectedLevelValue = 0;
  bool isMenuOpen = false;

  List<String> options = ["Tee", "Fairway", "Green", "Sent", "Rough"];
  String selectedOption = "Fairway";
  List<String> stockWindList = ['0', '5', '10', '15', '20', '25', '30+'];



  int selectedStockWindValue = 0;
  bool isStockWindOpen = false;
  bool includeInDispersionSwitchButtonValue = true;
  bool inBetweenAndStockNumberSwitchButtonValue = true;


  String selectedStockWind = "5";



  List levelTitleList = [
    'Rough',
    'Deep Rough',
    'Flyer',
    'Tee',
    'Recovery',
    'Bunker',
  ];

  String selectedGender = '';

  bool inAsyncCall = false;
  bool isInitCalled = false;



  Future<void> initMethod({required BuildContext context}) async {
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

  clickOnCalculateTargetWithAi({required BuildContext context}) {
    NM.pushMethod(context: context, screen: PlayAtCourseAiCaddieScreen());
  }
}
