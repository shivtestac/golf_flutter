import 'dart:convert';
import 'dart:io';
import 'package:golf_flutter/api/api_constants/api_key_constants.dart';
import 'package:golf_flutter/api/api_models/get_notification_model.dart';
import 'package:golf_flutter/api/api_models/get_simple_model.dart';
import 'package:golf_flutter/api/api_models/get_systems_model.dart';
import 'package:golf_flutter/api/api_models/get_systems_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:http/http.dart' as http;
import '../../common/http_methods.dart';
import '../api_constants/api_url_constants.dart';
import '../api_models/get_clubs_model.dart';
import '../api_models/get_course_model.dart';
import '../api_models/get_lessions_model.dart';
import '../api_models/my_followers_model.dart';
import '../api_models/my_following_model.dart';
import '../api_models/report_approach_model.dart';
import '../api_models/report_driving_model.dart';
import '../api_models/report_putting_model.dart';
import '../api_models/save_course_model.dart';
import '../api_models/save_game_model.dart';
import '../api_models/search_user_model.dart';
import '../api_models/step4_model.dart';
import '../api_models/step_model.dart';
import '../api_models/user_model.dart';
import '../api_models/view_courses_model.dart';

class ApiMethods {
  static Future<UserModel?> login({Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfLogin, bodyParams: bodyParams);
    if (response != null) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<UserModel?> register({Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfRegister, bodyParams: bodyParams);
    if (response != null) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<SimpleModel?> forgotPassword({Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfForgotPassword, bodyParams: bodyParams);
    if (response != null) {
      return SimpleModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<SimpleModel?> verifyOtpApi({Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfVerifyOtp, bodyParams: bodyParams);
    if (response != null) {
      return SimpleModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<SimpleModel?> resetPasswordApi({Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfResetPassword, bodyParams: bodyParams);
    if (response != null) {
      return SimpleModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<UserModel?> editUser({
    Map<String, dynamic>? bodyParams,
    Map<String, File>? imageMap,
  }) async {
    http.Response? response = await MyHttp.multipart(
      url: ApiUrlConstants.endPointOfEditUser,
      bodyParams: bodyParams,
      imageMap: imageMap,
    );
    if (response != null) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<StepModel?> step1({Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfStep1, bodyParams: bodyParams);
    if (response != null) {
      return StepModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<StepModel?> step2({Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfStep2, bodyParams: bodyParams);
    if (response != null) {
      return StepModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<StepModel?> step3({Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfStep3, bodyParams: bodyParams);
    if (response != null) {
      return StepModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<Step4Model?> step4({Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfStep4, bodyParams: bodyParams);
    if (response != null) {
      return Step4Model.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<StepModel?> step5({Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfStep5, bodyParams: bodyParams);
    if (response != null) {
      return StepModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<MyFollowersModel?> myFollowers() async {
    http.Response? response =
        await MyHttp.getMethod(url: ApiUrlConstants.endPointOfMyFollowers);
    if (response != null) {
      return MyFollowersModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }
  static Future<MyFollowingModel?> myFollowing() async {
    http.Response? response =
        await MyHttp.getMethod(url: ApiUrlConstants.endPointOfMyFollowing);
    if (response != null) {
      return MyFollowingModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<GetClubsModel?> getClubs() async {
    http.Response? response = await MyHttp.getMethod(
      url: ApiUrlConstants.endPointOfGetClubs,
    );
    if (response != null) {
      return GetClubsModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }
  static Future<NotificationModel?> getNotifications() async {
    http.Response? response = await MyHttp.getMethod(
      url: ApiUrlConstants.endPointOfGetNotifications,
    );
    if (response != null) {
      return NotificationModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }
  ///Read All notifications....
  static Future<SimpleModel?> readAllNotifications() async {
    http.Response? response = await MyHttp.getMethod(
      url: ApiUrlConstants.endPointOfReadAllNotifications,
    );
    if (response != null) {
      return SimpleModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<ViewCoursesModel?> viewCourses({
    Map<String, dynamic>? bodyParams,
  }) async {
    http.Response? response = await MyHttp.getMethod(
      url: ApiUrlConstants.endPointOfViewCourses,
      // bodyParams: bodyParams,
    );
    if (response != null) {
      return ViewCoursesModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<ViewCoursesModel?> viewCoursesNew({
    required Map<String, dynamic> queryParameters,
  }) async {
    http.Response? response = await MyHttp.getMethod(
      url: '${ApiUrlConstants.endPointOfViewCoursesNew}?Latitude=${queryParameters[ApiKeyConstants.latitude]}&Longitude=${queryParameters[ApiKeyConstants.longitude]}',
      // endPointUri: ApiUrlConstants.endPointOfViewCoursesNew,
      // queryParameters: queryParameters,
    );
    if (response != null) {
      return ViewCoursesModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<ReportDrivingModel?> reportDriving({
    required Map<String, dynamic> queryParameters,
  }) async {
    http.Response? response = await MyHttp.getMethod(
      url: '${ApiUrlConstants.endPointOfReportDriving}?${ApiKeyConstants.club}=${queryParameters[ApiKeyConstants.club]}',
      // endPointUri: ApiUrlConstants.endPointOfReportDriving,
      // queryParameters: queryParameters,
    );
    if (response != null) {
      return ReportDrivingModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<ReportApproachModel?> reportApproach({
    required Map<String, dynamic> queryParameters,
  }) async {
    http.Response? response = await MyHttp.getMethod(
      url: '${ApiUrlConstants.endPointOfReportApproach}?${ApiKeyConstants.club}=${queryParameters[ApiKeyConstants.club]}',

      // endPointUri: ApiUrlConstants.endPointOfReportApproach,
      // queryParameters: queryParameters,
    );
    if (response != null) {
      return ReportApproachModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<ReportPuttingModel?> reportPutting({
    required Map<String, dynamic> queryParameters,
  }) async {
    http.Response? response = await MyHttp.getMethod(
      url: '${ApiUrlConstants.endPointOfReportPutting}?${ApiKeyConstants.club}=${queryParameters[ApiKeyConstants.club]}',

      // endPointUri: ApiUrlConstants.endPointOfReportPutting,
      // queryParameters: queryParameters,
    );
    if (response != null) {
      return ReportPuttingModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<ViewCoursesModel?> topRatedCourses() async {
    http.Response? response = await MyHttp.getMethod(
      url: ApiUrlConstants.endPointOfTopRatedCourses,
    );
    if (response != null) {
      return ViewCoursesModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<UserModel?> follow({Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfFollow, bodyParams: bodyParams);
    if (response != null) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<UserModel?> unFollow({Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfUnFollow, bodyParams: bodyParams);
    if (response != null) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<SaveCourseModel?> saveCourse(
      {Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfSaveCourse, bodyParams: bodyParams);
    if (response != null) {
      return SaveCourseModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<SaveGameModel?> saveGame(
      {Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfSaveGame, bodyParams: bodyParams);
    if (response != null) {
      return SaveGameModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<SaveCourseModel?> getSavedCourses() async {
    http.Response? response = await MyHttp.getMethod(
      url: ApiUrlConstants.endPointOfGetSavedCourses,
    );
    if (response != null) {
      return SaveCourseModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<GetLessonsModel?> getLessons() async {
    http.Response? response = await MyHttp.getMethod(
      url: ApiUrlConstants.endPointOfGetLessons,
    );
    if (response != null) {
      return GetLessonsModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<UserModel?> getIn() async {
    http.Response? response = await MyHttp.getMethod(
      url: ApiUrlConstants.endPointOfGetIn,
    );
    if (response != null) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<PracticeModel?> lagPutt() async {
    http.Response? response = await MyHttp.getMethod(
      url: ApiUrlConstants.endPointOfLagPutt,
    );
    if (response != null) {
      return PracticeModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<PracticeModel?> strokeTest() async {
    http.Response? response = await MyHttp.getMethod(
      url: ApiUrlConstants.endPointOfStrokeTest,
    );
    if (response != null) {
      return PracticeModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<PracticeModel?> makeable() async {
    http.Response? response = await MyHttp.getMethod(
      url: ApiUrlConstants.endPointOfMakeable,
    );
    if (response != null) {
      return PracticeModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<PracticeModel?> simulatedRound() async {
    http.Response? response = await MyHttp.getMethod(
      url: ApiUrlConstants.endPointOfSimulatedRound,
    );
    if (response != null) {
      return PracticeModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<PracticeModel?> chippingDrillFairway() async {
    http.Response? response = await MyHttp.getMethod(
      url: ApiUrlConstants.endPointOfChippingDrillFairway,
    );
    if (response != null) {
      return PracticeModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<PracticeModel?> chippingDrillRough() async {
    http.Response? response = await MyHttp.getMethod(
      url: ApiUrlConstants.endPointOfChippingDrillRough,
    );
    if (response != null) {
      return PracticeModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<PracticeModel?> survivor() async {
    http.Response? response = await MyHttp.getMethod(
      url: ApiUrlConstants.endPointOfSurvivor,
    );
    if (response != null) {
      return PracticeModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<PracticeModel?> driverTest() async {
    http.Response? response = await MyHttp.getMethod(
      url: ApiUrlConstants.endPointOfDriverTest,
    );
    if (response != null) {
      return PracticeModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<PracticeModel?> approach() async {
    http.Response? response = await MyHttp.getMethod(
      url: ApiUrlConstants.endPointOfApproach,
    );
    if (response != null) {
      return PracticeModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<PracticeModel?> approachVariable() async {
    http.Response? response = await MyHttp.getMethod(
      url: ApiUrlConstants.endPointOfApproachVariable,
    );
    if (response != null) {
      return PracticeModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<GetSystemsModel?> getSystems() async {
    http.Response? response = await MyHttp.getMethod(
      url: ApiUrlConstants.endPointOfGetSystems,
    );
    if (response != null) {
      return GetSystemsModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<SearchUserModel?> searchUser({
    required Map<String, dynamic> queryParameters,
  }) async {
    http.Response? response = await MyHttp.getMethod(
      url: '${ApiUrlConstants.endPointOfSearchUser}?search=${queryParameters[ApiKeyConstants.search]}',
     // endPointUri: ApiUrlConstants.endPointOfSearchUser,
     // queryParameters: queryParameters,
    );
    if (response != null) {
      return SearchUserModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }



  static Future<UserModel?> gameStartRound(
      {Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiUrlConstants.endPointOfGameStartRound, bodyParams: bodyParams);
    if (response != null) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
