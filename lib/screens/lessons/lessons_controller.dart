import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_flutter/common/nm.dart';
import 'package:golf_flutter/screens/my_video_player/my_video_player_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_constants/api_url_constants.dart';
import '../../api/api_methods/api_methods.dart';
import '../../api/api_models/get_lessions_model.dart';

class LessonsController extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  List<GetLessonsData> getLessonsData = [];
  bool isInitCalled = false;
  bool inAsyncCall = false;

  Future<void> initMethod() async {
    if (!isInitCalled) {
      isInitCalled = true;
      inAsyncCall = true;
      GetLessonsModel? getLessonsModel = await ApiMethods.getLessons();
      getLessonsData.clear();
      if (getLessonsModel != null &&
          getLessonsModel.data != null &&
          getLessonsModel.data!.isNotEmpty) {
        getLessonsData = getLessonsModel.data!;
        notifyListeners();
      }
    }
    inAsyncCall = false;
  }

  void clickOnBookMarkButton({required BuildContext context}) {}

  clickOnCard({required BuildContext context, required int index}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('video',
        ApiUrlConstants.baseUrlForImages + (getLessonsData[index].video ?? ''));
    NM.pushMethod(context: context, screen: MyVideoPlayerScreen());
  }
}
