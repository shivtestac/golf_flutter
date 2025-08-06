import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/screens/bottom_bar/bottom_bar_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarController>(
      builder: (BuildContext context, BottomBarController controller, Widget? child) {
        return Scaffold(
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CW.commonGradiantDividerView(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.px),
                margin: EdgeInsets.only(top: 6.px,bottom: 26.px),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildNavItem(index: 0, selectedIc: 'assets/bottom_bar_ic/r_home_ic.png', unSelectedIc: 'assets/bottom_bar_ic/g_home_ic.png', label:  "Home",controller:controller),
                    buildNavItem(index: 1, selectedIc: 'assets/bottom_bar_ic/r_play_ic.png', unSelectedIc: 'assets/bottom_bar_ic/g_play_ic.png', label: "Play",controller:controller),
                    buildNavItem(index: 2, selectedIc: 'assets/bottom_bar_ic/r_practice_round_ic.png', unSelectedIc: 'assets/bottom_bar_ic/g_practice_round_ic.png', label: "Simulate",controller:controller),
                    buildNavItem(index: 3, selectedIc: 'assets/bottom_bar_ic/r_lessons_ic.png', unSelectedIc: 'assets/bottom_bar_ic/g_lessons_ic.png', label: "Lessons",controller:controller),
                    buildNavItem(index: 4, selectedIc: 'assets/bottom_bar_ic/r_practice_ic.png', unSelectedIc: 'assets/bottom_bar_ic/g_practice_ic.png', label: "Practice",controller:controller),
                    buildNavItem(index: 5, selectedIc: 'assets/bottom_bar_ic/r_stats_ic.png', unSelectedIc: 'assets/bottom_bar_ic/g_stats_ic.png', label: "Stats",controller:controller),
                  ],
                ),
              ),
            ],
          ),
           body: controller.body(),
        );
      },
    );
  }

  Widget buildNavItem({required int index, required String selectedIc, required String unSelectedIc, required String label, required BottomBarController controller}) {
    final isSelected = bottomBarCurrentIndex == index;
    return GestureDetector(
      onTap: () => controller.clickOnBottomBarItemView(value: index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CW.imageView(
            image: isSelected ? selectedIc : unSelectedIc,
            isAssetImage: true,
            height: isSelected ? 24.px : 24.px,
            width: isSelected ? 24.px : 24.px,
            fit: BoxFit.contain
          ),
          SizedBox(height: 4.px),
          Text(
            label,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: isSelected
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.surface
            ),
          ),
        ],
      ),
    );
  }

}
