import 'package:flutter/material.dart';
import 'package:golf_flutter/common/nm.dart';

class StatsDataListController extends ChangeNotifier{

  final List<String> options = ["Hole 5", "Hole 20", "Hole 100"];
  String selectedOption = "Hole";
  bool isMenuOpen = false;

  void clickOnBackButton({required BuildContext context}) {
    NM.popMethod(context: context);
  }

}