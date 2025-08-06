import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cm.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/common/progress_bar.dart';
import 'package:golf_flutter/screens/round_setup/round_setup_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/app_singleton.dart';
import '../courses_detail/courses_detail_controller.dart';

class RoundSetupScreen extends StatefulWidget {
  const RoundSetupScreen({super.key});

  @override
  State<RoundSetupScreen> createState() => _RoundSetupScreenState();
}

class _RoundSetupScreenState extends State<RoundSetupScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CoursesDetailController>(
      builder: (context, CoursesDetailController controller, child) {
        return ProgressBar(
          inAsyncCall: controller.inAsyncCall,
          child: Scaffold(
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
                'Round Setup',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              centerTitle: false,
              titleSpacing: -8.px,
            ),
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.px),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonTitleTextView(text: 'Course'),
                          SizedBox(height: 16.px),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CW.imageView(
                                image:
                                    AppSingleton.instance.teeDetails?.image ?? '',
                                width: 70.px,
                                height: 90.px,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 16.px),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    commonTitleTextView(
                                      text: controller.courses?.name ?? '',
                                    ),
                                    SizedBox(height: 8.px),
                                    commonSubTitleTextView(
                                      text: controller.courses?.address ?? '',
                                      fontSize: 12.px,
                                    ),
                                    SizedBox(height: 8.px),
                                    Row(
                                      children: [
                                        commonColumViewForCourseCard(
                                          title: '71.8',
                                          subTitle: 'CR',
                                        ),
                                        commonVerticalDividerView(),
                                        commonColumViewForCourseCard(
                                          title: '129',
                                          subTitle: 'SR',
                                        ),
                                        commonVerticalDividerView(),
                                        commonColumViewForCourseCard(
                                          title:
                                              '${AppSingleton.instance.teeDetails?.par ?? '0'}',
                                          subTitle: 'PAR',
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.px),
                    CW.commonGradiantDividerView(),
                    SizedBox(height: 16.px),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.px),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              commonTitleTextView(text: 'Players'),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => controller.clickOnAddPlayerButton(
                                    context: context),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Add Player',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                    Icon(
                                      Icons.add,
                                      color: Theme.of(context).colorScheme.error,
                                      size: 16.px,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 4.px),
                          commonSubTitleTextView(
                              text: 'You can add up to 4 players'),
                          SizedBox(height: 24.px),
                          Padding(
                            padding: EdgeInsets.only(bottom: 16.px),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    CW.imageView(
                                        height: 40.px,
                                        width: 40.px,
                                        radius: 20.px,
                                        image:
                                            controller.data?.profilePhoto ?? ''),
                                    Container(
                                      height: 16.px,
                                      width: 16.px,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0xff3333FA),
                                        border: Border.all(
                                          width: 2.px,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 16.px),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    commonTitleTextView(
                                        text:
                                            '${controller.data?.name ?? ''} (You)'),
                                    SizedBox(height: 4.px),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color:
                                              Theme.of(context).colorScheme.error,
                                          size: 12.px,
                                        ),
                                        commonSubTitleTextView(
                                            text:
                                                '${controller.data?.handicap ?? ''}')
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (controller.addUserDataList.isNotEmpty)
                            SizedBox(height: 16.px),
                          if (controller.addUserDataList.isNotEmpty)
                            ListView.builder(
                              itemCount: controller.addUserDataList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 16.px),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.bottomLeft,
                                        children: [
                                          CW.imageView(
                                              height: 40.px,
                                              width: 40.px,
                                              radius: 20.px,
                                              image: controller
                                                      .addUserDataList[index]
                                                      .profilePhoto ??
                                                  ''),
                                          Container(
                                            height: 16.px,
                                            width: 16.px,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: const Color(0xff3333FA),
                                              border: Border.all(
                                                width: 2.px,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 16.px),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          commonTitleTextView(
                                              text: controller
                                                      .addUserDataList[index]
                                                      .name ??
                                                  ''),
                                          SizedBox(height: 4.px),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error,
                                                size: 12.px,
                                              ),
                                              commonSubTitleTextView(
                                                  text:
                                                      '${controller.addUserDataList[index].handicap ?? ''}')
                                            ],
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      PopupMenuButton<String>(
                                        padding: EdgeInsets.zero,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.px),
                                          side: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                            width: .5.px,
                                          ),
                                        ),
                                        icon: CW.imageView(
                                          image: 'assets/icons/menu_ic.png',
                                          isAssetImage: true,
                                          height: 20.px,
                                          width: 20.px,
                                        ),
                                        onSelected: (value) =>
                                            controller.clickOnMenuButton(
                                                context: context,
                                                value: value,
                                                index: index),
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry<String>>[
                                          PopupMenuItem<String>(
                                            height: 36.px,
                                            value: 'Setup Player',
                                            child: commonTitleTextView(
                                                text: 'Setup Player',
                                                fontWeight: FontWeight.w400),
                                          ),
                                          PopupMenuItem<String>(
                                            height: 36.px,
                                            value: 'Remove',
                                            child: commonTitleTextView(
                                                text: 'Remove',
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                        ],
                      ),
                    ),
                    CW.commonGradiantDividerView(),
                  ],
                ),
                SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CW.commonGradiantDividerView(),
                      SizedBox(height: 12.px),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.px),
                        child: CW.commonElevatedButtonView(
                          context: context,
                          onTap: () => controller.clickOnStartRoundButton(
                              context: context),
                          buttonText: 'Start Round',
                        ),
                      ),
                      SizedBox(height: 8.px),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget commonTitleTextView({required String text, FontWeight? fontWeight}) =>
      Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: fontWeight ?? FontWeight.w700,
            ),
      );

  Widget commonSubTitleTextView({required String text, double? fontSize}) =>
      Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(fontSize: fontSize ?? 10.px),
      );

  Widget commonVerticalDividerView() => SizedBox(
        height: 24.px,
        child: VerticalDivider(
          width: 8.px,
          thickness: 1.px,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      );

  Widget commonColumViewForCourseCard(
          {required String title, required String subTitle}) =>
      SizedBox(
        width: 70.px,
        //height: 34.px,
        child: Column(
          children: [
            commonTitleTextView(text: title),
            SizedBox(height: 3.px),
            commonSubTitleTextView(text: subTitle)
          ],
        ),
      );
}
