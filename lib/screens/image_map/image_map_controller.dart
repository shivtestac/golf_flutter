import 'package:flutter/cupertino.dart';
import 'package:golf_flutter/common/nm.dart';
import 'package:golf_flutter/screens/play_at_course/play_at_course_screen.dart';

class ImageMapController extends ChangeNotifier {
  List list = [
    {
      'color': const Color(0xff1C1C1E),
      'Name': 'Black - 6981 yards',
      'detail': 'Men:74.3/141'
    },
    {
      'color': const Color(0xffECE5B6),
      'Name': 'Tan - 6515 yards',
      'detail': 'Men:72.2/136-Women:78.1/145'
    },
    {
      'color': const Color(0xffADD8E6),
      'Name': 'Combination - 6238 yards',
      'detail': 'Men:70.9/134-Women:76.4/142'
    },
    {
      'color': const Color(0xff3333FA),
      'Name': 'Blue - 6075 yards',
      'detail': 'Men:70.2/132-Women:75.6/140'
    },
    {
      'color': const Color(0xffFFD700),
      'Name': 'Yellow - 5747 yards',
      'detail': 'Men:68.6/129-Women:73.8/136'
    },
    {
      'color': const Color(0xffBAC816),
      'Name': 'Yellow/Green - 5382 yards',
      'detail': 'Men:67.0/126-Women:71.7/132'
    },
    {
      'color': const Color(0xff449A18),
      'Name': 'Green - 5187 yards',
      'detail': 'Men:66.0/125-Women:70.7/130'
    },
  ];

  String selectTreeValue = '';

  void clickOnBackButton({required BuildContext context}) {
    NM.popMethod(context: context);
  }

  void clickOnSelectTreesListCard(
      {required int index, required BuildContext context}) {
    NM.pushMethod(context: context, screen: const PlayAtCourseScreen());
  }
}
