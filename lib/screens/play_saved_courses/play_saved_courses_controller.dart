import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/api_constants/api_key_constants.dart';
import '../../api/api_methods/api_methods.dart';
import '../../api/api_models/save_course_model.dart';
import '../play_online/play_online_controller.dart';

class PlaySavedCoursesController extends ChangeNotifier{

  List<SaveCourseData> saveCourseData = [];

  bool isInitCalled = false; // A flag to track if initMethod is called
  bool inAsyncCall = false; // A flag to track if initMethod is called

  Future<void> initMethod() async {
    if (!isInitCalled) {
      isInitCalled = true;
      inAsyncCall = true;
      SaveCourseModel? saveCourseModel = await ApiMethods.getSavedCourses();
      saveCourseData.clear();
      if (saveCourseModel != null &&
          saveCourseModel.data != null &&
          saveCourseModel.data!.isNotEmpty) {
        saveCourseData = saveCourseModel.data!;
        notifyListeners();
      }
    }
    inAsyncCall = false;
    notifyListeners();
  }

  TextEditingController searchController = TextEditingController();
  void clickOnBackButton({required BuildContext context}) {
    Navigator.pop(context);
    var playOnlineController = Provider.of<PlayOnlineController>(context, listen: false);
    playOnlineController.isInitCalled = false;
    playOnlineController.inAsyncCall = false;;
    playOnlineController.courses.clear();
    playOnlineController.coursesTopRated.clear();
    playOnlineController.initMethod();
  }

  clickOnSaveIcon({required int index}) async {
    inAsyncCall = true;
    notifyListeners();
    SaveCourseModel? saveCourseModel = await ApiMethods.saveCourse(bodyParams: {
      ApiKeyConstants.courseId: saveCourseData[index].course?.sId,
    });
    isInitCalled = false;
    await initMethod();
    inAsyncCall = false;
    notifyListeners();
  }
}