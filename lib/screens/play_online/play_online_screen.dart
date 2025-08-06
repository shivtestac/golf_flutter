import 'package:flutter/material.dart';
import 'package:golf_flutter/common/app_singleton.dart';
import 'package:golf_flutter/common/cp/gradient_circular_progress_bar.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/common/progress_bar.dart';
import 'package:golf_flutter/screens/play_online/play_online_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PlayOnlineScreen extends StatefulWidget {
  const PlayOnlineScreen({super.key});

  @override
  State<PlayOnlineScreen> createState() => _PlayOnlineScreenState();
}

class _PlayOnlineScreenState extends State<PlayOnlineScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var playOnlineController = Provider.of<PlayOnlineController>(context);
    playOnlineController.initMethod();
  }

  @override
  void deactivate() {
    super.deactivate();
    var playOnlineController = Provider.of<PlayOnlineController>(context);
    playOnlineController.isInitCalled = false;
    playOnlineController.inAsyncCall = false;
    playOnlineController.courses.clear();
    playOnlineController.coursesTopRated.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayOnlineController>(
      builder: (context, PlayOnlineController controller, child) {
        return ProgressBar(
          inAsyncCall: controller.inAsyncCall,
          child: Scaffold(
            appBar: AppBar(
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
            ),
            body: SafeArea(
              child: SingleChildScrollView(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppSingleton.instance.pageName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20.px),
                                    ),
                                    SizedBox(height: 6.px),
                                    Text(
                                      'Course Preview allows you to do your homework on a course',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => controller.clickOnBookMarkButton(
                                    context: context),
                                child: CW.imageView(
                                  image: 'assets/icons/bookmark_ic.png',
                                  isAssetImage: true,
                                  height: 24.px,
                                  width: 24.px,
                                ),
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
                    // loadingProgressBarView(controller:controller),
                    SizedBox(height: 16.px),
                    if (controller.courses.isNotEmpty)
                      nearbyCoursesView(controller: controller),
                    SizedBox(height: 20.px),
                    if (controller.coursesTopRated.isNotEmpty)
                      topRatedView(controller: controller),
                    SizedBox(height: 20.px),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget commonListView(
      {required String title,
      required NullableIndexedWidgetBuilder itemBuilder,
      required int itemCount,
      GestureTapCallback? onTapViewAllButton,
      double? listHeight}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.px),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              GestureDetector(
                onTap: onTapViewAllButton,
                child: Row(
                  children: [
                    Text(
                      'View All',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontSize: 12.px,
                          color: Theme.of(context).colorScheme.error),
                    ),
                    CW.imageView(
                        image: 'assets/icons/right_arrow1_ic.png',
                        isAssetImage: true,
                        height: 20.px,
                        width: 20.px)
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.px),
        SizedBox(
          height: listHeight ?? 210.px,
          child: ListView.builder(
            itemCount: itemCount,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 24.px),
            itemBuilder: itemBuilder,
          ),
        )
      ],
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

  Widget nearbyCoursesView({required PlayOnlineController controller}) {
    return commonListView(
      title: 'Nearby Courses',
      itemCount: controller.courses.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(right: 16.px),
          child: GestureDetector(
            onTap: () => AppSingleton.instance.pageName == 'Preview'
                ? controller.clickOnNearbyCoursesCardViewPreview(
                    context: context, index: index)
                : controller.clickOnNearbyCoursesCardView(
                    context: context, index: index),
            child: CW.commonBlackCardView(
              context: context,
              width: 246.px,
              borderRadius: 16.px,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CW.imageView(
                        image: controller.courses[index].image ?? '',
                        height: 136.px,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.px),
                          topRight: Radius.circular(16.px),
                        ),
                        fit: BoxFit.fill,
                      ),
                      GestureDetector(
                        onTap: () => controller.clickOnSaveIcon(index: index),
                        child: Container(
                          height: 32.px,
                          width: 32.px,
                          margin: EdgeInsets.only(right: 16.px),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/img/black_card_img.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Center(
                            child: CW.imageView(
                              image:
                                  (controller.courses[index].isSaved ?? false)
                                      ? 'assets/icons/bookmark_active_ic.png'
                                      : 'assets/icons/bookmark_ic.png',
                              isAssetImage: true,
                              height: 20.px,
                              width: 20.px,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.px),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.courses[index].name ?? '',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.px),
                        commonRowForNearbyCard(
                          image: 'assets/icons/map_pin_ic.png',
                          text: controller.courses[index].city ?? '',
                        ),
                        SizedBox(height: 2.px),
                        commonRowForNearbyCard(
                          image: 'assets/icons/clock_ic.png',
                          text: '${controller.courses[index].distance ?? ''} KM',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget topRatedView({required PlayOnlineController controller}) {
    return commonListView(
      title: 'Top Rated',
      listHeight: 180.px,
      itemCount: controller.coursesTopRated.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(right: 16.px),
          child: GestureDetector(
            onTap: () => controller.clickOnTopRatedCardView(
                context: context, index: index),
            child: Stack(
              children: [
                CW.imageView(
                  image: controller.coursesTopRated[index].image ?? '',
                  height: 180.px,
                  width: 148.px,
                  borderRadius: BorderRadius.circular(16.px),
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 180.px,
                  width: 148.px,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.px),
                        margin: EdgeInsets.all(16.px),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(.7),
                          borderRadius: BorderRadius.circular(4.px),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: Theme.of(context).colorScheme.error,
                              size: 10.px,
                            ),
                            SizedBox(width: 2.px),
                            Text(
                              '${controller.coursesTopRated[index].avgRating ?? ''}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        // height: 76.px,
                        width: double.infinity,
                        padding: EdgeInsets.all(12.px),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16.px),
                            bottomRight: Radius.circular(16.px),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(.2),
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(.6),
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(.8),
                              Theme.of(context).scaffoldBackgroundColor,
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.coursesTopRated[index].state ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.px),
                            Text(
                              controller.coursesTopRated[index].name ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
