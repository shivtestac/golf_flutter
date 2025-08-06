import 'dart:async';
import 'package:flutter/material.dart';
import 'package:golf_flutter/api/api_models/get_systems_model.dart';
import 'package:golf_flutter/api/api_models/my_following_model.dart';
import 'package:golf_flutter/common/app_singleton.dart';
import 'package:golf_flutter/common/nm.dart';
import 'package:golf_flutter/screens/courses_detail_long/courses_detail_long_screen.dart';
import 'package:golf_flutter/screens/play_gps_online/play_gps_online_screen.dart';
import 'package:golf_flutter/screens/play_online/play_online_screen.dart';
import 'package:golf_flutter/screens/round_setup/round_setup_screen.dart';
import 'package:golf_flutter/screens/select_tees/select_tees_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/api_constants/api_key_constants.dart';
import '../../api/api_methods/api_methods.dart';
import '../../api/api_models/my_followers_model.dart';
import '../../api/api_models/user_model.dart';
import '../../api/api_models/view_courses_model.dart';
import '../play_at_course/play_at_course_screen.dart';
import '../round_setup_add_player/round_setup_add_player_screen.dart';
import '../setup_player/setup_player_screen.dart';

class CoursesDetailController extends ChangeNotifier {
  late AnimationController animationController;
  late Animation<double> linearProgressIndicatorAnimation;

  bool isSearchUiValue = true;

  Courses? courses;

  // Offset initialSwipeOffset = Offset.zero;


  void clickOnCard({required int index, required BuildContext context}) {
    AppSingleton.instance.pageName = '';
    NM.pushMethod(context: context, screen: PlayOnlineScreen());
  }

  final PageController pageController = PageController();
 // int currentPage = 0;

  List weatherDataList = [
    {'img': 'assets/icons/weather_sunny_ic.png', 'degree': '33', 'day': 'Tue'},
    {'img': 'assets/icons/weather_cloudy_ic.png', 'degree': '31', 'day': 'Wed'},
    {'img': 'assets/icons/weather_rain_ic.png', 'degree': '28', 'day': 'Thu'},
    {'img': 'assets/icons/weather_cloudy_ic.png', 'degree': '30', 'day': 'Fri'},
    {'img': 'assets/icons/weather_rain_ic.png', 'degree': '27', 'day': 'Sat'},
    {'img': 'assets/icons/weather_sunny_ic.png', 'degree': '30', 'day': 'Mon'},
  ];

  List leaderBoardUserDataList = [
    {
      'img': 'assets/dummy_img/img.png',
      'name': 'Peter Morgan',
      'detail': 'North Carolina, United States',
      'count': '72'
    },
    {
      'img': 'assets/dummy_img/img1.png',
      'name': 'Tom Fischer',
      'detail': 'Dallas, United States',
      'count': '73'
    },
    {
      'img': 'assets/dummy_img/img2.png',
      'name': 'Elena Emma Sabrina',
      'detail': 'San Francisco, United States',
      'count': '75'
    },
    {
      'img': 'assets/dummy_img/img3.png',
      'name': 'Kelly Wrangler',
      'detail': 'San Francisco, United States',
      'count': '76'
    },
    {
      'img': 'assets/dummy_img/img4.png',
      'name': 'Gladina Samantha',
      'detail': 'New Jersey, United States',
      'count': '76'
    },
    {
      'img': 'assets/dummy_img/img5.png',
      'name': 'Gladina Samantha',
      'detail': 'New Jersey, United States',
      'count': '76'
    },
  ];

  int isMenuOpen = -1;

  TextEditingController searchController = TextEditingController();

  Timer? debounce;
  bool isSearchLoading = false;
  List<Following> followersList = [];
  List<Following> addUserDataList = [];
  List<Following> filteredList = [];

  bool isInitCalled = false; // A flag to track if initMethod is called
  bool inAsyncCall = false;

  UserData? data; // A flag to track if initMethod is called
  List<SystemsModel> systems = [];

  Future<void> initMethod() async {
    if (!isInitCalled) {
      isInitCalled = true;
      inAsyncCall = true;
      GetSystemsModel? getSystemsModel = await ApiMethods.getSystems();
      if (getSystemsModel != null && getSystemsModel.systems != null) {
        systems = getSystemsModel.systems!;
        notifyListeners();
      }

      UserModel? userModel = await ApiMethods.getIn();
      if (userModel != null && userModel.data != null) {
        data = userModel.data!;
        notifyListeners();
      }
      MyFollowingModel? myFollowersModel = await ApiMethods.myFollowing();
      if (myFollowersModel != null && myFollowersModel.following != null) {
        followersList = myFollowersModel.following!;
        filteredList = followersList;
        print('Follower lenght: ${filteredList.length}');
        notifyListeners();
      }
    }
    inAsyncCall = false;
  }

  void clickOnBackButton({required BuildContext context}) {
    Navigator.pop(context);
  }

  void searchOnChange({required String value}) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    isSearchLoading = true;
    notifyListeners();
    debounce = Timer(const Duration(milliseconds: 500), () {
      isSearchLoading = false;
      if (value.isEmpty) {
        filteredList = followersList;
        notifyListeners();
        return;
      }
      List<Following> tempList = [];
      for (var item in followersList) {
        if (item.name!.toLowerCase().contains(value.toLowerCase())) {
          tempList.add(item);
        }
      }
      filteredList = tempList;
      notifyListeners();
    });
  }

  void clickOnAddButton({required BuildContext context, required int index}) {
    if (addUserDataList.contains(followersList[index])) {
    } else {
      addUserDataList.add(followersList[index]);
    }
    notifyListeners();
  }

  void clickOnRemoveUserButton(
      {required BuildContext context, required int index}) {
    addUserDataList.removeAt(index);
    notifyListeners();
  }

  void clickOnMenuButton(
      {required BuildContext context,
      required int index,
      required String value}) {
    isMenuOpen = index;
    if (value == 'Setup Player') {
      NM.pushMethod(context: context, screen: const SetupPlayerScreen());
    } else if (value == 'Remove') {
      clickOnRemoveUserButton(index: index, context: context);
    }
  }

  void clickOnAddPlayerButton({required BuildContext context}) {
    NM.pushMethod(context: context, screen: const RoundSetupAddPlayerScreen());
  }

  Future<void> clickOnPhoneIcButton({required BuildContext context}) async {
    final String url = 'tel:${courses?.contact ?? ''}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> clickOnSendIcButton() async {
    final String googleMapsUrl =
        'google.navigation:q=${courses?.latitude},${courses?.longitude}'; // Directions URL
    final String appleMapsUrl =
        'https://maps.apple.com/?q=${courses?.latitude},${courses?.longitude}'; // iOS Maps (fallback)
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl);
    } else {
      throw 'Could not launch Google Maps';
    }
  }

  void clickOnShareIcButton({required BuildContext context}) {}

  void clickOnCalendarIcButton({required BuildContext context}) {}

  void clickOnStarIcButton({required BuildContext context}) {}

  clickOnStartRoundAndGoToTeesButton({required BuildContext context}) {
    NM.pushMethod(context: context, screen: const SelectTeesScreen());
  }

  clickOnStartRoundButton({required BuildContext context}) async {
    inAsyncCall = true;
    notifyListeners();
    Map<String, dynamic> bodyParams = {
      ApiKeyConstants.courseId: courses?.sId ?? '',
      ApiKeyConstants.userTeeId: AppSingleton.instance.teeDetails?.sId ?? '',
      ApiKeyConstants.otherUsers: otherUsers,
    };
    UserModel? userModel =
        await ApiMethods.gameStartRound(bodyParams: bodyParams);
    if (userModel != null) {
      if(AppSingleton.instance.gameType=='GPS'){
        NM.pushMethod(context: context, screen: const PlayGpsOnlineScreen());
      }else{
        NM.pushMethod(context: context, screen: const PlayAtCourseScreen());
      }
       }
    inAsyncCall = false;
    notifyListeners();
  }

  void onSwipeEnd(
      {required BuildContext context, }) {
    // if (initialSwipeOffset.dy < 20) {
      // NM.pushMethod(context: context, screen: const CoursesDetailLongScreen());
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const CoursesDetailLongScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    //}
  }

  void clickOnSelectTreesListCard(
      {required int index, required BuildContext context}) {
    AppSingleton.instance.teeDetails = courses?.teeDetails?[index];
    if (AppSingleton.instance.pageName == 'Play') {
      NM.pushMethod(context: context, screen: const RoundSetupScreen());
    } else {
      NM.pushMethod(context: context, screen: const PlayAtCourseScreen());
    }
  }

  String selectTeeValue = '';
  String isYourHandicapCardSelectedValue = '';
  TextEditingController dropDownTextEditingController = TextEditingController();
  int? systemsId;
  List<Map<String, dynamic>> otherUsers = [];

  void clickOnSelectTeesListCard({required String sId}) {
    if (selectTeeValue == sId) {
      selectTeeValue = '';
    } else {
      selectTeeValue = sId;
    }
    notifyListeners();
  }

  void clickOnYourHandicapCardView({required String value}) {
    if (isYourHandicapCardSelectedValue.contains(value)) {
      isYourHandicapCardSelectedValue = '';
    } else {
      isYourHandicapCardSelectedValue = value;
    }
    notifyListeners();
  }

  clickOnSaveSettingsButton({required BuildContext context}) {
    otherUsers.removeWhere((element) =>
        element[ApiKeyConstants.userId] == addUserDataList[isMenuOpen].sId);
    otherUsers.add({
      ApiKeyConstants.userId: addUserDataList[isMenuOpen].sId,
      ApiKeyConstants.handicap: AppSingleton.instance.userData?.handicap,
      ApiKeyConstants.playingHandicap: addUserDataList[isMenuOpen].handicap,
      ApiKeyConstants.teeId: selectTeeValue,
      ApiKeyConstants.handicapSystemId: systemsId,
      ApiKeyConstants.selectedHandicap: isYourHandicapCardSelectedValue,
    });
    NM.popMethod(context: context);
    print('otherUsers:::::::::::::::::${otherUsers}');
  }

  clickOnListOfDropDown({String? value}) {
    for (var element in systems) {
      if (dropDownTextEditingController.text == element.name) {
        systemsId = element.id;
        notifyListeners();
      }
    }
  }
}
