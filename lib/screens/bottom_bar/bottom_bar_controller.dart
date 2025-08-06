import 'package:flutter/material.dart';
import 'package:golf_flutter/screens/ai_caddie/ai_caddie_screen.dart';
import 'package:golf_flutter/screens/home/home_screen.dart';
import 'package:golf_flutter/screens/lessons/lessons_screen.dart';
import 'package:golf_flutter/screens/play/play_screen.dart';
import 'package:golf_flutter/screens/play_at_practice_simulated/play_at_practice_simulated_screen.dart';
import 'package:golf_flutter/screens/practice/practice_screen.dart';
import 'package:golf_flutter/screens/stats/stats_screen.dart';

int bottomBarCurrentIndex = 0;

class BottomBarController extends ChangeNotifier {
  void clickOnBottomBarItemView({required int value}) {
    bottomBarCurrentIndex = value;
    notifyListeners();
  }

  body() {
    switch (bottomBarCurrentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const PlayScreen();
      case 2:
        return const PlayAtPracticeSimulatedScreen();
      case 3:
        return const LessonsScreen();
      case 4:
        return const PracticeScreen();
      case 5:
        return const StatsScreen();
    }
  }
}
