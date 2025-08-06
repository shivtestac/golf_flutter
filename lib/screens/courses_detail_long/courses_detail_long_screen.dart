import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../courses_detail/courses_detail_controller.dart';

class CoursesDetailLongScreen extends StatefulWidget {
  const CoursesDetailLongScreen({super.key});

  @override
  State<CoursesDetailLongScreen> createState() =>
      _CoursesDetailLongScreenState();
}

class _CoursesDetailLongScreenState extends State<CoursesDetailLongScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var coursesDetailLongController =
        Provider.of<CoursesDetailController>(context, listen: false);
    coursesDetailLongController.pageController.addListener(() {
      // int next = coursesDetailLongController.pageController.page?.round() ?? 0;
      // if (coursesDetailLongController.currentPage != next) {
      //   setState(() {
      //     coursesDetailLongController.currentPage = next;
      //   });
      // }
    });
  }

  @override
  void dispose() {
    var coursesDetailLongController =
        Provider.of<CoursesDetailController>(context, listen: false);
   // coursesDetailLongController.pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoursesDetailController>(
      builder: (context, CoursesDetailController controller, child) {
        return Scaffold(
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              if (controller.courses != null &&
                  controller.courses?.gallery != null &&
                  controller.courses!.gallery!.isNotEmpty)
                bannerView(controller: controller),
              Padding(
                padding: EdgeInsets.all(24.px),
                child: courseNameAndButtonsView(controller: controller),
              ),
              CW.commonGradiantDividerView(),
              Padding(
                padding: EdgeInsets.all(24.px),
                child: informationView(controller: controller),
              ),
              CW.commonGradiantDividerView(),
              SizedBox(height: 24.px),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.px),
                child: weatherView(controller: controller),
              ),
              SizedBox(height: 18.px),
              weatherListViewData(controller: controller),
              SizedBox(height: 16.px),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.px),
                child: leaderBoardView(controller: controller),
              ),
              CW.commonGradiantDividerView(),
              Padding(
                padding: EdgeInsets.all(20.px),
                child: CW.commonElevatedButtonView(
                  context: context,
                  onTap: () =>
                      controller.clickOnStartRoundAndGoToTeesButton(context: context),
                  buttonText: 'Start Round',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget bannerView({required CoursesDetailController controller}) => SizedBox(
        height: 240.px,
        child: Stack(
          children: [
            PageView.builder(
              controller: controller.pageController,
              itemCount: controller.courses?.gallery?.length,
              pageSnapping: true,
              itemBuilder: (context, index) {
               // bool isCurrentPage = controller.currentPage == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  // margin: EdgeInsets.only(right: isCurrentPage ? 50 : 8.0), // adds gap for non-current pages
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CW.imageView(
                      image: controller.courses?.gallery?[index] ?? '',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 234.px,
                      borderRadius: BorderRadius.zero),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.px,
                  ),
                  SafeArea(
                    child: GestureDetector(
                      onTap: () =>
                          controller.clickOnBackButton(context: context),
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
                  ),
                  const Spacer(),
                  Row(
                    children: List.generate(
                      controller.courses!.gallery!.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.only(right: 4.px),
                        height: 6.px,
                        width:  12.px ,
                        decoration: BoxDecoration(
                          color:  Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(.4),
                          borderRadius: BorderRadius.circular(3.px),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.px)
                ],
              ),
            ),
          ],
        ),
      );

  Widget commonIconButtonView(
          {required String imgPth, GestureTapCallback? onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: CW.imageView(
          image: imgPth,
          isAssetImage: true,
          height: 40.px,
          width: 40.px,
        ),
      );

  Widget courseNameAndButtonsView(
          {required CoursesDetailController controller}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.courses?.name ?? '',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 20.px,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.px),
          Text(
            controller.courses?.address ?? '',
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 22.px),
          Row(
            children: [
              commonIconButtonView(
                onTap: () => controller.clickOnPhoneIcButton(context: context),
                imgPth: 'assets/icons/phone_bg_ic.png',
              ),
              SizedBox(width: 8.px),
              commonIconButtonView(
                onTap: () => controller.clickOnSendIcButton(),
                imgPth: 'assets/icons/send_bg_ic.png',
              ),
              SizedBox(width: 8.px),
              commonIconButtonView(
                onTap: () => controller.clickOnShareIcButton(context: context),
                imgPth: 'assets/icons/share_bg_ic.png',
              ),
              /*SizedBox(width: 8.px),
              commonIconButtonView(
                onTap: () =>
                    controller.clickOnCalendarIcButton(context: context),
                imgPth: 'assets/icons/calendar_bg_ic.png',
              ),*/
              const Spacer(),
              commonIconButtonView(
                onTap: () =>
                    controller.clickOnCalendarIcButton(context: context),
                imgPth: 'assets/icons/star_bg_ic.png',
              ),
            ],
          ),
        ],
      );

  Widget commonColumnForInformationView(
          {required String text1, required String text2}) =>
      SizedBox(
        height: 60.px,
        width: 108.px,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text1,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 14.px,
                  ),
            ),
            SizedBox(height: 4.px),
            Text(
              text2,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 12.px),
            ),
          ],
        ),
      );

  Widget commonVerticalDividerView() => SizedBox(
        height: 24.px,
        child: VerticalDivider(
          width: 0.px,
          thickness: 1.px,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      );

  Widget informationView({required CoursesDetailController controller}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Information',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 14.px,
                ),
          ),
          SizedBox(height: 16.px),
          Row(
            children: [
              commonColumnForInformationView(
                  text1: '${controller.courses?.avgRating ?? '0'}',
                  text2: 'Reviews'),
              commonVerticalDividerView(),
              commonColumnForInformationView(
                  text1: '${controller.courses?.followersCount ?? '0'}',
                  text2: 'Followers'),
              commonVerticalDividerView(),
              commonColumnForInformationView(
                  text1: '${controller.courses?.holesCount ?? '0'}',
                  text2: 'Holes'),
            ],
          ),
          SizedBox(height: 16.px),
          Text(
            controller.courses?.description ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      );

  Widget weatherView({required CoursesDetailController controller}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weather',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 14.px,
                ),
          ),
          SizedBox(height: 16.px),
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
              Expanded(
                child: Column(
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
                              color: Theme.of(context).colorScheme.onPrimary,
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
                    Text(
                      'Partial Cloudy Wind: 21 km/h NNE',
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      );

  Widget commonColumnForWeatherView(
          {required String imgPath,
          required String text1,
          required String text2}) =>
      SizedBox(
        height: 80.px,
        width: 72.px,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CW.imageView(
              image: imgPath,
              isAssetImage: true,
              width: 24.px,
              height: 24.px,
            ),
            SizedBox(height: 7.px),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text1,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 12.px,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                Container(
                  height: 4.px,
                  width: 4.px,
                  margin: EdgeInsets.only(left: 2.px),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 1.px,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.px),
            Text(
              text2,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );

  Widget weatherListViewData({required CoursesDetailController controller}) =>
      SizedBox(
        height: 80.px,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.weatherDataList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return commonColumnForWeatherView(
              imgPath: controller.weatherDataList[index]['img'],
              text1: controller.weatherDataList[index]['degree'],
              text2: controller.weatherDataList[index]['day'],
            );
          },
        ),
      );

  Widget leaderBoardView({required CoursesDetailController controller}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Leader board (Top 5 Gross)',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 14.px,
                    ),
              ),
              const Spacer(),
              Text(
                'View All',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 12.px,
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
              CW.imageView(
                image: 'assets/icons/right_arrow1_ic.png',
                isAssetImage: true,
                height: 20.px,
                width: 20.px,
              ),
            ],
          ),
          SizedBox(height: 16.px),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: controller.leaderBoardUserDataList.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                height: 68.px,
                // color: Colors.yellow,
                margin: EdgeInsets.only(bottom: 8.px),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Container(
                          height: 48.px,
                          width: 48.px,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                controller.leaderBoardUserDataList[index]
                                    ['img'],
                              ),
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          height: 20.px,
                          width: 20.px,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.error),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 8.px),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.leaderBoardUserDataList[index]['name'],
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.px),
                          Text(
                            controller.leaderBoardUserDataList[index]['detail'],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontSize: 10.px,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      controller.leaderBoardUserDataList[index]['count'],
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 20.px,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              );
            },
          ),
        ],
      );
}
