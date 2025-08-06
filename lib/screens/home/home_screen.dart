import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/common/progress_bar.dart';
import 'package:golf_flutter/screens/home/home_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/app_singleton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Do not call Provider.of here
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Safely access the provider here
    HomeController homeController = Provider.of<HomeController>(context);
    homeController.initMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
        return Scaffold(
          appBar: appBarView(controller: controller),
          body: ProgressBar(
            inAsyncCall: controller.inAsyncCall,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                drillsCardView(controller: controller),
                CW.commonGradiantDividerView(),
                SizedBox(height: 16.px),
                Column(
                  children: [
                    practiceCardView(controller: controller),
                    SizedBox(height: 16.px),
                    watchConnectImageView(controller: controller),
                    SizedBox(height: 16.px),
                  ],
                ),
                golfImageView(controller: controller),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar appBarView({required HomeController controller}) => AppBar(
        leadingWidth: 76.px,
        leading: GestureDetector(
          onTap: () => controller.clickOnProfile(context: context),
          child: Center(
            child: CW.imageView(
              image: AppSingleton.instance.userData?.profilePhoto ?? '',
              height: 32.px,
              width: 32.px,
              borderRadius: BorderRadius.circular(16.px),
            ),
          ),
        ),
        title: Text(
          'Hi, ${controller.data?.username ?? ''}',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
        titleSpacing: -8.px,
        actions: [
          GestureDetector(
            onTap: () => controller.clickOnSearchIcon(context: context),
            child: CW.imageView(
              image: 'assets/icons/search_ic.png',
              isAssetImage: true,
              height: 24.px,
              width: 24.px,
            ),
          ),
          SizedBox(width: 16.px),
          GestureDetector(
            onTap: () => controller.clickOnNotificationIcon(context: context),
            child: SizedBox(
              height: 24.px,
              width: 24.px,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Center(
                    child: CW.imageView(
                      image: 'assets/icons/notification_ic.png',
                      isAssetImage: true,
                      height: 20.px,
                      width: 20.px,
                    ),
                  ),
                  Container(
                    height: 5.px,
                    width: 5.px,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 24.px),
        ],
      );

  Widget commonColumnView({
    required String titleText,
    required String dataText,
  }) {
    return SizedBox(
      width: 80.px,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            titleText,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5.px),
          Text(
            dataText,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 20.px,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget commonVerticalDividerView() => SizedBox(
        height: 40.px,
        child: VerticalDivider(
          width: 8.px,
          thickness: 1.px,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      );

  Widget commonRightArrowIcView() => CW.imageView(
        image: 'assets/icons/right_arrow1_ic.png',
        isAssetImage: true,
        height: 20.px,
        width: 20.px,
      );

  Widget drillsCardView({required HomeController controller}) => Container(
        height: 80.px,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24.px),
        // color: Colors.red,
        child: Row(
          children: [
            Expanded(
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  commonColumnView(
                    titleText: 'Drills',
                    dataText: '24',
                  ),
                  commonVerticalDividerView(),
                  commonColumnView(
                    titleText: 'Handicap',
                    dataText: '18.2*',
                  ),
                  commonVerticalDividerView(),
                  commonColumnView(
                    titleText: 'Rounds',
                    dataText: '7',
                  )
                ],
              ),
            ),
            CW.commonBlackCardView(
              height: 32.px,
              width: 32.px,
              context: context,
              widget: Center(
                child: commonRightArrowIcView(),
              ),
              onTap: () =>
                  controller.clickOnRightArrowCardView(context: context),
            ),
          ],
        ),
      );

  Widget practiceCardView({required HomeController controller}) {
    return CW.commonBlackCardView(
      context: context,
      width: double.infinity,
      borderRadius: 16.px,
      padding: EdgeInsets.all(16.px),
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Practice',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 14.px,
                          ),
                    ),
                    SizedBox(height: 4.px),
                    Text(
                      'Drills designed specifically for you',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () =>
                    controller.clickOnPracticeCardRightArrow(context: context),
                child: commonRightArrowIcView(),
              )
            ],
          ),
          SizedBox(height: 16.px),
          SizedBox(
            height: 48.px,
            child: ListView.builder(
              itemCount: controller.daysNameList.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 12.px),
                  child: Column(
                    children: [
                      Container(
                        height: 32.px,
                        width: 32.px,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image:
                                  AssetImage('assets/img/black_card_img.png'),
                              fit: BoxFit.contain),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: controller.daysNameList[index]['value']
                                ? Theme.of(context).colorScheme.error
                                : Colors.transparent,
                            width: .5.px,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              color: controller.daysNameList[index]['value']
                                  ? Theme.of(context).colorScheme.error
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: CW.imageView(
                                image: controller.daysNameList[index]['value']
                                    ? 'assets/icons/check_ic.png'
                                    : 'assets/icons/r_minus_ic.png',
                                isAssetImage: true,
                                height: 20.px,
                                width: 20.px,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.px),
                      Text(
                        controller.daysNameList[index]['daysName'],
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 8.px,
                            color: Theme.of(context).colorScheme.error),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget watchConnectImageView({required HomeController controller}) =>
      Container(
        height: 130.px,
        width: double.infinity,
        padding: EdgeInsets.all(16.px),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/home_watch_img.png'),
                fit: BoxFit.fill)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gadget Connect',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 14.px,
                  ),
            ),
            SizedBox(height: 6.px),
            Text(
              'Connect your apple watch',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Spacer(),
            CW.commonElevatedButtonView(
              context: context,
              onTap: () =>
                  controller.clickOnWatchConnectButton(context: context),
              width: 78.px,
              height: 28.px,
              borderRadius: 6.px,
              buttonText: 'Connect',
              buttonTextFontSize: 10.px,
            )
          ],
        ),
      );

  Widget golfImageView({required HomeController controller}) => Container(
        height: 220.px,
        width: double.infinity,
        padding: EdgeInsets.all(24.px),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/img/home_golf_img.png'),
          fit: BoxFit.cover,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.px),
            Text(
              'Join the\nGo Red Golf',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(height: 1.4.px),
            ),
            SizedBox(height: 6.px),
            Text(
              'Track your skills to enhance the shots.\nOur subscription will start with just  \$0.00.',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontSize: 11.px, fontWeight: FontWeight.w400),
            ),
            const Spacer(),
            CW.commonElevatedButtonView(
              context: context,
              onTap: () =>
                  controller.clickOSubscribeNowButton(context: context),
              width: 120.px,
              height: 32.px,
              borderRadius: 6.px,
              isBlackBg: true,
              buttonText: 'Subscribe Now',
              buttonTextFontSize: 12.px,
            )
          ],
        ),
      );
}
