import 'package:flutter/material.dart';
import 'package:golf_flutter/common/progress_bar.dart';
import 'package:golf_flutter/screens/play_saved_courses/play_saved_courses_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/cw.dart';

class PlaySavedCoursesScreen extends StatefulWidget {
  const PlaySavedCoursesScreen({super.key});

  @override
  State<PlaySavedCoursesScreen> createState() => _PlaySavedCoursesScreenState();
}

class _PlaySavedCoursesScreenState extends State<PlaySavedCoursesScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var playSavedCoursesController =
        Provider.of<PlaySavedCoursesController>(context);
    playSavedCoursesController.initMethod();
  }

  @override
  void deactivate() {
    super.deactivate();
    var playSavedCoursesController =
        Provider.of<PlaySavedCoursesController>(context);
    playSavedCoursesController.isInitCalled = false;
    playSavedCoursesController.inAsyncCall = false;
    playSavedCoursesController.saveCourseData.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaySavedCoursesController>(
      builder: (context, PlaySavedCoursesController controller, child) {
        return ProgressBar(
          inAsyncCall: controller.inAsyncCall,
          child: Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.px),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.px),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => controller.clickOnBackButton(
                                  context: context),
                              child: Center(
                                child: CW.imageView(
                                  image: 'assets/icons/left_arrow_ic.png',
                                  isAssetImage: true,
                                  height: 24.px,
                                  width: 24.px,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.px),
                            Text(
                              'Saved Courses',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.px),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.px),
                        Row(
                          children: [
                            CW.imageView(
                              image: 'assets/icons/search_ic.png',
                              isAssetImage: true,
                              height: 20.px,
                              width: 20.px,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            SizedBox(width: 8.px),
                            Expanded(
                              child: CW.commonTextFieldForLoginSignUP(
                                context: context,
                                isBorder: false,
                                filled: true,
                                fillColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20.px, horizontal: 0),
                                hintText: 'Type to search...',
                                controller: controller.searchController,
                                // onChanged: (value) => controller.searchOnChange(value: value),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CW.commonGradiantDividerView(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.saveCourseData.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                          vertical: 16.px, horizontal: 24.px),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.px),
                          child: CW.commonBlackCardView(
                            context: context,
                            width: double.infinity,
                            height: 185.px,
                            borderRadius: 16.px,
                            widget: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    SizedBox(
                                      height: 136.px,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          height: 120.px,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16.px),
                                              topRight: Radius.circular(16.px),
                                            ),
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/dummy_img/play_ground_img.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          child: CW.imageView(
                                            image: controller
                                                    .saveCourseData[index]
                                                    .course
                                                    ?.image ??
                                                '',
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => controller.clickOnSaveIcon(index: index),
                                      child: Container(
                                        height: 32.px,
                                        width: 32.px,
                                        margin: EdgeInsets.only(right: 16.px),
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/img/black_card_img.png'),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: Center(
                                          child: CW.imageView(
                                              image:
                                                  'assets/icons/bookmark_ic.png',
                                              isAssetImage: true,
                                              height: 20.px,
                                              width: 20.px,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .error),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.px),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.saveCourseData[index].course
                                                ?.name ??
                                            '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 8.px),
                                      Row(
                                        children: [
                                          commonRowForNearbyCard(
                                            image:
                                                'assets/icons/map_pin_ic.png',
                                            text: controller
                                                    .saveCourseData[index]
                                                    .course
                                                    ?.city ??
                                                '',
                                          ),
                                          SizedBox(width: 6.px),
                                          commonRowForNearbyCard(
                                            image: 'assets/icons/clock_ic.png',
                                            text: controller
                                                    .saveCourseData[index]
                                                    .course
                                                    ?.address ??
                                                '',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget commonRowForNearbyCard(
          {required String image, required String text}) =>
      Row(
        children: [
          CW.imageView(
            image: image,
            isAssetImage: true,
            width: 16.px,
            height: 16.px,
          ),
          SizedBox(width: 4.px),
          Text(
            text,
            style: Theme.of(context).textTheme.titleSmall,
          )
        ],
      );
}
