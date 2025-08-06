import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../common/app_singleton.dart';
import 'courses_detail_controller.dart';

class CoursesDetailScreen extends StatefulWidget {
  const CoursesDetailScreen({super.key});

  @override
  State<CoursesDetailScreen> createState() => _CoursesDetailScreenState();
}

class _CoursesDetailScreenState extends State<CoursesDetailScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var coursesDetailController =
        Provider.of<CoursesDetailController>(context, listen: false);
    coursesDetailController.courses = AppSingleton.instance.courses;
    coursesDetailController.initMethod();
    coursesDetailController.animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    coursesDetailController.linearProgressIndicatorAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: coursesDetailController.animationController,
          curve: Curves.easeInOut),
    )..addListener(() {
            setState(() {
              if (coursesDetailController
                      .linearProgressIndicatorAnimation.value ==
                  1.0) {
                coursesDetailController.isSearchUiValue = false;
              }
            });
          });

    coursesDetailController.animationController.forward();
  }

  @override
  void deactivate() {
    super.deactivate();
    var coursesDetailController =
        Provider.of<CoursesDetailController>(context, listen: false);
    coursesDetailController.animationController.dispose();
    coursesDetailController.isSearchUiValue = true;
    coursesDetailController.courses = null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoursesDetailController>(
      builder: (context, CoursesDetailController controller, child) {
        return Scaffold(
          body: controller.isSearchUiValue
              ? searchCourseAnimationUi(controller: controller)
              : startRoundUi(controller: controller),
        );
      },
    );
  }

  Widget commonTextView({required String text, FontWeight? fontWeight}) => Text(
        text,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: fontWeight ?? FontWeight.w700,
              fontSize: 14.px,
            ),
      );

  Widget searchCourseAnimationUi(
      {required CoursesDetailController controller}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.px),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RotationTransition(
              turns: controller.animationController,
              child: CW.imageView(
                image: 'assets/img/connection_img.png',
                isAssetImage: true,
                width: 160.px,
                height: 160.px,
              ),
            ),
            SizedBox(height: 60.px),
            commonTextView(text: 'Search nearby courses'),
            SizedBox(height: 8.px),
            Row(
              children: [
                Expanded(
                  child: AnimatedBuilder(
                    animation: controller.linearProgressIndicatorAnimation,
                    builder: (context, child) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(4.px),
                        child: LinearProgressIndicator(
                          minHeight: 8.px,
                          value:
                              controller.linearProgressIndicatorAnimation.value,
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(.25),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.primary),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 20.px),
                commonTextView(
                  text:
                      '${(controller.linearProgressIndicatorAnimation.value * 100).toInt()}%',
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget startRoundUi({required CoursesDetailController controller}) {
    return Stack(
      children: [
        CW.imageView(
          image: controller.courses?.image ?? '',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                left: 24.px, right: 24.px, top: 24.px, bottom: 8.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => controller.clickOnBackButton(context: context),
                  child: Container(
                    height: 30.px,
                    width: 30.px,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: CW.imageView(
                        image: 'assets/icons/left_arrow_ic.png',
                        isAssetImage: true,
                        height: 20.px,
                        width: 20.px,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CW.imageView(
                      image: 'assets/icons/weather_cloudy_ic.png',
                      isAssetImage: true,
                      height: 42.px,
                      width: 42.px,
                    ),
                    SizedBox(width: 12.px),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '33',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            Container(
                              height: 4.px,
                              width: 4.px,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  width: 1.px,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(
                              'c',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.px,
                                  ),
                            ),
                          ],
                        ),
                        commonTextView(
                          text: 'Wind: 21 km/h NNE',
                          fontWeight: FontWeight.w400,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 24.px),
                Text(
                  controller.courses?.name ?? '',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                SizedBox(height: 12.px),
                Text(
                  controller.courses?.address ?? '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(height: 32.px),
                CW.commonElevatedButtonView(
                  context: context,
                  onTap: () => controller.clickOnStartRoundAndGoToTeesButton(
                      context: context),
                  buttonText: 'Start Round',
                ),
                SizedBox(height: 28.px),
                Center(
                  child: GestureDetector(
                    // onVerticalDragStart: (details) {
                    //   setState(() {
                    //     controller.initialSwipeOffset = details.localPosition;
                    //   });
                    // },
                    onTap: (){
                      controller.onSwipeEnd(
                        context: context, );
                    },
                    onVerticalDragEnd: (details) => controller.onSwipeEnd(
                        context: context, ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 24.px,
                          width: 24.px,
                          margin: EdgeInsets.only(right: 10.px),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: CW.imageView(
                              image: 'assets/icons/up_arrow_ic.png',
                              isAssetImage: true,
                              height: 16.px,
                              width: 16.px,
                            ),
                          ),
                        ),
                        commonTextView(text: 'Swipe for detail')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

/*return Scaffold(
          body: Stack(
            children: [
              CW.imageView(
                image: 'assets/background_img/image_play_bg.png',
                isAssetImage: true,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.px, vertical: 16.px),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.px),
                          CW.imageView(
                            image: 'assets/img/courses_detail_bg.png',
                            isAssetImage: true,
                            height: 28.px,
                            width: 100.px,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.px),
                    ListView.builder(
                      itemCount: controller.listOfItems.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: 4.px),
                        child: GestureDetector(
                          onTap: () => controller.clickOnCard(index: index,context: context),
                          child: CW.commonBlackCardView(
                            context: context,
                            width: double.infinity,
                            borderRadius: 16.px,
                            widget: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.px,horizontal: 16.px),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CW.imageView(
                                    image: 'assets/dummy_img/play_live.png',
                                    isAssetImage: true,
                                    height: 68.px,
                                    width: 68.px,
                                  ),
                                  SizedBox(width: 16.px),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.listOfItems[index]['title'] ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.px),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 8.px),
                                        Text(
                                          controller.listOfItems[index]['sub'] ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12.px),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.px),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Theme.of(context).primaryColor,
                                    size: 14.px,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.px),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget loadingProgressBarView({required CoursesDetailController controller}) =>
      Padding(
        padding: EdgeInsets.all(24.px),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.px,
              width: 20.px,
              child: const GradientCircularProgressIndicator(),
            ),
            SizedBox(width: 12.px),
            Text(
              'Searching for “Emm”...',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      );

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

  Widget commonRowForNearbyCard({required String image, required String text}) => Row(
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

  Widget nearbyCoursesView() {
    return commonListView(
      title: 'Nearby Courses',
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(right: 16.px),
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
                        ),
                      ),
                    ),
                    Container(
                      height: 32.px,
                      width: 32.px,
                      margin: EdgeInsets.only(right: 16.px),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/black_card_img.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Center(
                        child: CW.imageView(
                          image: 'assets/icons/bookmark_ic.png',
                          isAssetImage: true,
                          height: 20.px,
                          width: 20.px,
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
                        'Cypress Point Club',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.px),
                      commonRowForNearbyCard(
                          image: 'assets/icons/map_pin_ic.png',
                          text: 'Del Monte Forest, California'),
                      SizedBox(height: 2.px),
                      commonRowForNearbyCard(
                          image: 'assets/icons/clock_ic.png', text: '2.4 kms'),
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

  Widget topRatedView() {
    return commonListView(
      title: 'Top Rated',
      listHeight: 180.px,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(right: 16.px),
          child: Container(
            height: 180.px,
            width: 148.px,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.px),
              image: const DecorationImage(
                image: AssetImage('assets/dummy_img/play_ground_img.png'),
                fit: BoxFit.fill,
              ),
            ),
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
                      borderRadius: BorderRadius.circular(4.px)),
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
                        '3.2k',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  height: 76.px,
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
                        'California',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.px),
                      Text(
                        'Cypress Point Club',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
        );
      },
    );
  }*/
