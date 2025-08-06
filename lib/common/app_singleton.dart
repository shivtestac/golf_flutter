import '../api/api_models/user_model.dart';
import '../api/api_models/view_courses_model.dart';

class AppSingleton {
  AppSingleton._privateConstructor();
  static final AppSingleton _instance = AppSingleton._privateConstructor();
  static AppSingleton get instance => _instance;
  String pageName = "";
  String gameType = "GPS";
  Courses? courses;
  TeeDetails? teeDetails;
  UserData? userData;
}
