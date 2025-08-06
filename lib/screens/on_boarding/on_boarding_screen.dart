import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/screens/on_boarding/on_boarding_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OnBoardingController>(
      builder: (context, OnBoardingController controller, child) {
        return SafeArea(
          child: Scaffold(
            bottomNavigationBar: Padding(
              padding: EdgeInsets.all(24.px),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: controller.currentPageIndex != '0'
                        ? backButtonView(controller: controller)
                        : const SizedBox(),
                  ),
                  SizedBox(
                    height: 8.px,
                    child: Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.onboardingImgList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return commonDotView(
                            isCurrentIndex: controller.currentPageIndex == index.toString(),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: nextButtonView(controller: controller),
                  ),
                ],
              ),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.onboardingImgList.length,
                    onPageChanged: (value) => controller.onPageChange(value: value),
                    itemBuilder: (context, index) {
                      return ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CW.imageView(
                                image: controller.onboardingImgList[index],
                                isAssetImage: true,
                                height: 484.px,
                                width: double.infinity,
                                fit: BoxFit.fill,
                                borderRadius: BorderRadius.circular(0.px),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.px),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 24.px),
                                    Text(
                                      controller.onboardingTitleList[index],
                                      style: Theme.of(context).textTheme.displayLarge,
                                    ),
                                    SizedBox(height: 12.px),
                                    Text(
                                      controller.onboardingSubTitleList[index],
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(24.px),
                      child: GestureDetector(
                        onTap: () => controller.clickOnSkipButton(context: context),
                        child: Text(
                          'Skip',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
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

  Widget commonDotView({required bool isCurrentIndex}) => Container(
        height: 8.px,
        width: 8.px,
        margin: EdgeInsets.only(right: 4.px),
        decoration: BoxDecoration(
          color: isCurrentIndex
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(4.px),
        ),
      );

  Widget backButtonView({required OnBoardingController controller}) => GestureDetector(
        onTap: () => controller.clickOnBackButton(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CW.imageView(
              image: 'assets/icons/left_arrow_ic.png',
              isAssetImage: true,
              width: 16.px,
              height: 16.px,
            ),
            SizedBox(width: 4.px),
            CW.commonTextButtonView(
              buttonText: 'Back',
              context: context,
            ),
          ],
        ),
      );

  Widget nextButtonView({required OnBoardingController controller}) => GestureDetector(
        onTap: () => controller.clickOnNextButton(context: context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CW.commonTextButtonView(
              buttonText: controller.currentPageIndex == '2'
               ? 'Get Started'
               : 'Next',
              context: context,
            ),
            SizedBox(width: 4.px),
            CW.imageView(
              image: 'assets/icons/right_arrow_ic.png',
              isAssetImage: true,
              width: 16.px,
              height: 16.px,
            ),
          ],
        ),
      );
}
