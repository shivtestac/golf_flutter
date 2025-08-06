import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/screens/stats_data_list/stats_data_list_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StatsDataListScreen extends StatefulWidget {
  List shortListData;
  StatsDataListScreen({super.key,required this.shortListData});

  @override
  State<StatsDataListScreen> createState() => _StatsDataListScreenState();
}

class _StatsDataListScreenState extends State<StatsDataListScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StatsDataListController>(
      builder: (context, StatsDataListController controller, child) {
        return Scaffold(
          appBar: AppBar(
            leadingWidth: 76.px,
            leading: GestureDetector(
              onTap: () => controller.clickOnBackButton(context: context),
              child: Center(
                child: CW.imageView(
                  image: 'assets/icons/left_arrow_ic.png',
                  isAssetImage: true,
                  height: 24.px,
                  width: 24.px,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            title: Text(
              'Shot List',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: false,
            titleSpacing: -8.px,
            actions: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    controller.isMenuOpen = !controller.isMenuOpen;
                  });
                },
                child: CW.commonBlackCardView(
                  context: context,
                  widget: PopupMenuButton<String>(
                    position: PopupMenuPosition.under,
                    initialValue: controller.selectedOption,
                    onSelected: (value) {
                      setState(() {
                        controller.selectedOption = value;
                        controller.isMenuOpen = false;
                      });
                    },
                    onCanceled: () {
                      setState(() {
                        controller.isMenuOpen = false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    itemBuilder: (BuildContext context) {
                      return controller.options.map((String option) {
                        return PopupMenuItem<String>(
                          height: 32.px,
                          value: option,
                          child: Text(
                            option,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        );
                      }).toList();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.px,
                        vertical: 4.px,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        border: Border.all(
                          color: controller.isMenuOpen ? Theme.of(context).colorScheme.primary : Colors.transparent,
                          width: 2.px,
                        ),
                        borderRadius: BorderRadius.circular(8.px),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            controller.selectedOption,
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          SizedBox(width: 6.px),
                          CW.imageView(
                            image: 'assets/icons/down_up_ic.png',
                            isAssetImage: true,
                            height: 14.px,
                            width: 16.px,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 24.px),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.px,vertical: 12.px),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: commonSubTitleTextView(
                        text: 'Hole#',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 24.px),
                    Expanded(
                      flex: 6,
                      child: commonSubTitleTextView(
                        text: 'Club- Shot Distance',
                      ),
                    ),
                    SizedBox(width: 24.px),
                    Expanded(
                      flex: 2,
                      child: commonSubTitleTextView(
                        text: 'Strokes Gained',
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.px),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: widget.shortListData.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      String strokesGainedValue =widget.shortListData[index]['StrokesGainedValue'];
                      return Padding(
                        padding:  EdgeInsets.only(bottom: 12.px),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      commonTitleTextView(
                                        text: '${index+1}',
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 5.px),
                                      commonSubTitleTextView(
                                        text: 'Hole',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 24.px),
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      commonTitleTextView(
                                        text: widget.shortListData[index]['ClubShotDistanceValue'],
                                      ),
                                      SizedBox(height: 5.px),
                                      commonSubTitleTextView(
                                        text: widget.shortListData[index]['ClubShotDistanceDetail'],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 24.px),
                                Expanded(
                                  flex: 2,
                                  child: commonTitleTextView(
                                    text: strokesGainedValue,
                                    textAlign: TextAlign.end,
                                    color: strokesGainedValue.contains('-')
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.onError,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.px),
                            CW.commonGradiantDividerView()
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget commonTitleTextView({required String text, FontWeight? fontWeight,Color? color,TextAlign? textAlign}) => Text(
    text,
    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontWeight: fontWeight ?? FontWeight.w700,
      color: color,
    ),
    textAlign: textAlign,
  );

  Widget commonSubTitleTextView({required String text, FontWeight? fontWeight,TextAlign? textAlign}) => Text(
    text,
    style: Theme.of(context).textTheme.titleMedium?.copyWith(
      fontSize: 10.px,
    ),
    textAlign: textAlign,
  );

}
