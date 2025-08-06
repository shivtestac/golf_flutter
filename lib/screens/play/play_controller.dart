import 'package:flutter/material.dart';
import 'package:golf_flutter/common/nm.dart';
import 'package:golf_flutter/screens/play_online/play_online_screen.dart';
import '../../common/app_singleton.dart';
import '../ai_caddie/ai_caddie_screen.dart';
import '../play_at_course/play_at_course_screen.dart';

class PlayController extends ChangeNotifier {
  var listOfItems = [
    {
      'image': 'assets/dummy_img/play_live.png',
      'title': 'Play Live: Tournament Mode',
      'sub': 'Connect apple watch or use your phone to use live GPS.'
    },
    {
      'image': 'assets/dummy_img/aI_caddy_mode.png',
      'title': 'Play Live: AI Caddy Mode',
      'sub': 'A.I Caddie offers real-time golf advice and course insights.'
    },
    {
      'image': 'assets/dummy_img/play_live.png',
      'title': 'Preview Course: Test Strategy',
      'sub': 'Plan your round using RED’s smart targeting.'
    },
    {
      'image': 'assets/dummy_img/play_live.png',
      'title': 'Post a Round',
      'sub':
          'Already play? Record your round here to get a deep stats breakdown.'
    },
  ];

  clickOnCard({required int index, required BuildContext context}) {
    if (index == 0) {
      AppSingleton.instance.pageName = 'Play';
      AppSingleton.instance.gameType = 'GPS';
      NM.pushMethod(context: context, screen: PlayOnlineScreen());
    }
    if (index == 1) {
      NM.pushMethod(context: context, screen: const AiCaddieScreen());
    }
    if (index == 2) {
      AppSingleton.instance.pageName = 'Preview';
      AppSingleton.instance.gameType = 'Preview';
      NM.pushMethod(context: context, screen: PlayOnlineScreen());
    }
    if (index == 3) {
      AppSingleton.instance.gameType = 'Post';
      NM.pushMethod(context: context, screen: const PlayAtCourseScreen());
    }
  }
}
