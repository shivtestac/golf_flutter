import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:golf_flutter/common/nm.dart';
import 'package:golf_flutter/screens/courses_detail/courses_detail_screen.dart';
import 'package:golf_flutter/screens/play_saved_courses/play_saved_courses_screen.dart';
import '../../api/api_constants/api_key_constants.dart';
import '../../api/api_methods/api_methods.dart';
import '../../api/api_models/save_course_model.dart';
import '../../api/api_models/view_courses_model.dart';
import '../../common/app_singleton.dart';
import '../../common/cm.dart';
import '../select_tees/select_tees_screen.dart';

class PlayOnlineController extends ChangeNotifier {
  List<Courses> courses = [];
  List<Courses> coursesTopRated = [];
  bool isInitCalled = false;
  bool inAsyncCall = true;

  Future<void> initMethod() async {
    if (!isInitCalled) {
      Position? position = await CM.getLatLong();
      isInitCalled = true;
      inAsyncCall = true;
      ViewCoursesModel? viewCoursesModel =
          await ApiMethods.viewCoursesNew(queryParameters: {
        ApiKeyConstants.latitude: '${position?.latitude ?? ''}',
        ApiKeyConstants.longitude: '${position?.longitude ?? ''}',
      });
      if (viewCoursesModel != null &&
          viewCoursesModel.courses != null &&
          viewCoursesModel.courses!.isNotEmpty) {
        courses = viewCoursesModel.courses!;
        notifyListeners();
      }
      ViewCoursesModel? viewCoursesTopRatedModel =
          await ApiMethods.topRatedCourses();
      if (viewCoursesTopRatedModel != null &&
          viewCoursesTopRatedModel.courses != null &&
          viewCoursesTopRatedModel.courses!.isNotEmpty) {
        coursesTopRated = viewCoursesTopRatedModel.courses!;
        notifyListeners();
      }
    }
    inAsyncCall = false;
    notifyListeners();
  }

  TextEditingController searchController = TextEditingController();

  void clickOnBookMarkButton({required BuildContext context}) {
    NM.pushMethod(context: context, screen: const PlaySavedCoursesScreen());
  }

  void clickOnNearbyCoursesCardView(
      {required int index, required BuildContext context}) {
    AppSingleton.instance.courses = courses[index];
    NM.pushMethod(context: context, screen: const CoursesDetailScreen());
  }

  void clickOnNearbyCoursesCardViewPreview(
      {required int index, required BuildContext context}) {
    AppSingleton.instance.courses = courses[index];
    NM.pushMethod(context: context, screen: const SelectTeesScreen());
  }

  void clickOnTopRatedCardView(
      {required int index, required BuildContext context}) {
    AppSingleton.instance.courses = coursesTopRated[index];
    NM.pushMethod(context: context, screen: const CoursesDetailScreen());
  }

  clickOnBackButton({required BuildContext context}) {
    NM.popMethod(context: context);
  }

  clickOnSaveIcon({required int index}) async {
    inAsyncCall = true;
    notifyListeners();
    courses[index].isSaved = !(courses[index].isSaved ?? false);
    SaveCourseModel? saveCourseModel = await ApiMethods.saveCourse(bodyParams: {
      ApiKeyConstants.courseId: courses[index].sId,
    });
    inAsyncCall = false;
    notifyListeners();
  }
}
