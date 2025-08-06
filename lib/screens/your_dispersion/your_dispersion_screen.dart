import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/screens/your_dispersion/your_dispersion_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timer_count_down/timer_count_down.dart';

class YourDispersionScreen extends StatefulWidget {
  const YourDispersionScreen({super.key});

  @override
  State<YourDispersionScreen> createState() => _YourDispersionScreenState();
}

class _YourDispersionScreenState extends State<YourDispersionScreen> {


  @override
  Widget build(BuildContext context) {
    return Consumer<YourDispersionController>(
      builder: (context, YourDispersionController controller, child) {
        return SafeArea(
          child: Scaffold(
            bottomNavigationBar: (controller.pageIndex != 7)
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.px),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CW.commonElevatedButtonView(
                            context: context,
                            buttonText: 'Skip',
                            isBlackBg: true,
                            onTap: () =>
                                controller.clickOnSkipButton(context: context),
                          ),
                        ),
                        SizedBox(width: 16.px),
                        Expanded(
                          flex: 4,
                          child: CW.commonElevatedButtonView(
                            context: context,
                            buttonText:
                                controller.pageIndex == 0 ? 'Continue' : 'Next',
                            onTap: () => controller.clickOnContinueButton(
                                context: context),
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox(),
            body: Column(
              children: [
                if (controller.pageIndex != 0 && controller.pageIndex != 7)
                  Container(
                    height: 64.px,
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Color(0xff0D0808)),
                    child: Center(
                      child: SizedBox(
                        height: 38.px,
                        child: ListView.builder(
                          itemCount: 7,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 32.px,
                              width: 32.px,
                              margin: EdgeInsets.only(right: 8.px),
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/img/black_card_img.png'),
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: controller.pageIndex > index
                                      ? Theme.of(context).colorScheme.error
                                      : Colors.transparent,
                                ),
                              ),
                              child: Center(
                                child: controller.pageIndex > index &&
                                        controller.pageIndex != index + 1
                                    ? Container(
                                        height: 32.px,
                                        width: 32.px,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: CW.imageView(
                                            image: 'assets/icons/check_ic.png',
                                            isAssetImage: true,
                                            height: 20.px,
                                            width: 20.px,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        '${index + 1}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              color: controller.pageIndex ==
                                                      index + 1
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .secondary
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .onSecondary,
                                            ),
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                if (controller.pageIndex != 0 && controller.pageIndex != 7)
                  CW.commonGradiantDividerView(),
                if (controller.pageIndex != 0 && controller.pageIndex != 7)
                  SizedBox(height: 10.px),
                Expanded(
                  child: PageView.builder(
                    itemCount: 8,
                    controller: controller.pageController,
                    onPageChanged: (value) =>
                        controller.onPageChanged(value: value),
                    itemBuilder: (context, index) {
                      if (controller.pageIndex == 0) {
                        return zeroIndexUiView();
                      } else if (controller.pageIndex == 1) {
                        return oneIndexUiView(
                            controller: controller, index: index);
                      } else if (controller.pageIndex == 2) {
                        return twoIndexUiView(
                            controller: controller, index: index);
                      } else if (controller.pageIndex == 3) {
                        return threeIndexUiView(
                            controller: controller, index: index);
                      } else if (controller.pageIndex == 4) {
                        return fourthIndexUiView(
                            controller: controller, index: index);
                      } else if (controller.pageIndex == 5) {
                        return fifthIndexUiView(
                            controller: controller, index: index);
                      } else if (controller.pageIndex == 6) {
                        return sixthIndexUiView(
                            controller: controller, index: index);
                      } else if (controller.pageIndex == 7) {
                        return seventhIndexUiView(
                            controller: controller, index: index);
                      }
                      return const SizedBox();
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

  Widget questionNumberTextView({required String text}) => Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(fontWeight: FontWeight.w700),
      );

  Widget questionTextView({required String text}) => Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.w700),
      );

  Widget commonRadioButton({required String title, required String value}) {
    return Row(
      children: [
        Container(
          height: 20.px,
          width: 20.px,
          margin: EdgeInsets.only(right: 8.px),
          decoration: BoxDecoration(
              color: title == value
                  ? Theme.of(context).colorScheme.error
                  : Colors.transparent,
              border: Border.all(
                color: Theme.of(context).colorScheme.onSecondary,
                width: 1.px,
              ),
              shape: BoxShape.circle),
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget zeroIndexUiView() {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CW.imageView(
              image: 'assets/img/your_dispersion_img.png',
              isAssetImage: true,
              height: 380.px,
              width: double.infinity,
              fit: BoxFit.fill,
              borderRadius: BorderRadius.circular(0.px),
            ),
            Padding(
              padding: EdgeInsets.all(24.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 36.px),
                  Text(
                    '''As you hit real shots on the golf course RED will begin to learn your tendencies and patterns, complete with accurate dispersion ovals. Within a few rounds, you'll be able to use your dispersion pattern and Red's AI algorithms to lower your scores and help you make better decisions on the course. You can use this knowledge to scout your next round or improve your course strategy during your round. \n\nFor now, help us know you better with a few basic questions...''',
                    // style: Theme.of(context).textTheme.displayLarge,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  // SizedBox(height: 48.px),
                  // SizedBox(height: 48.px),
                  // SizedBox(height: 24.px),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget oneIndexUiView(
      {required YourDispersionController controller, required int index}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          questionNumberTextView(text: 'Question 0$index'),
          SizedBox(height: 8.px),
          questionTextView(text: '''What's your handicap?'''),
          SizedBox(height: 14.px),
          CW.commonTextFieldForLoginSignUP(
              context: context,
              hintText: 'Your handicap index',
              labelText: 'Your handicap index',
              controller: controller.yourHandicapIndexController),
          SizedBox(height: 14.px),
          CW.commonGradiantDividerView(),
          /*
          SizedBox(height: 14.px),
          questionTextView(text: '''Select your gender'''),
          SizedBox(height: 14.px),
          GestureDetector(
            onTap: () => controller.clickOnRadioButton(selectedValue: 'Male'),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                controller.commonCheckBoxView(
                    checkValue: controller.selectedGender == 'Male'),
                SizedBox(width: 10.px),
                Flexible(
                  child: Text(
                    'Male',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.px),
          GestureDetector(
            onTap: () => controller.clickOnRadioButton(selectedValue: 'Female'),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                controller.commonCheckBoxView(
                    checkValue: controller.selectedGender == 'Female'),
                SizedBox(width: 10.px),
                Flexible(
                  child: Text(
                    'Female',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.px),
          GestureDetector(
            onTap: () => controller.clickOnRadioButton(
                selectedValue: 'Choose not to disclose'),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                controller.commonCheckBoxView(
                    checkValue:
                        controller.selectedGender == 'Choose not to disclose'),
                SizedBox(width: 10.px),
                Flexible(
                  child: Text(
                    'Choose not to disclose',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.all(12.px),
            margin: EdgeInsets.only(bottom: 32.px),
            decoration: BoxDecoration(
              // color: const Color(0xff2E2525),
              borderRadius: BorderRadius.circular(8.px),
              border: Border.all(
                color: const Color(0xff2E2525),
                width: 1.px,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CW.imageView(
                    image: 'assets/icons/Info_ic.png',
                    isAssetImage: true,
                    height: 20.px,
                    width: 20.px),
                SizedBox(width: 12.px),
                Flexible(
                  child: Text(
                    '''If you don't know your handicap you can estimate it. Total beginners, put 54. 30 handicaps average around 108, 20 handicaps average 96, 10 handicaps average 85.''',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                )
              ],
            ),
          )*/
        ],
      ),
    );
  }

  Widget twoIndexUiView(
      {required YourDispersionController controller, required int index}) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.px),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              questionNumberTextView(text: 'Question 0$index'),
              SizedBox(height: 8.px),
              questionTextView(text: 'Do you play right or left handed?'),
              SizedBox(height: 32.px),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => controller.clickOnLAndRCardView(value: 'L'),
                    child: Container(
                      height: 80.px,
                      width: 80.px,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/img/black_card_img.png'),
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color:
                                controller.isLeftRightCardSelectedValue == 'L'
                                    ? Theme.of(context).colorScheme.error
                                    : Theme.of(context).colorScheme.onSecondary,
                            width: .5.px),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color:
                                controller.isLeftRightCardSelectedValue == 'L'
                                    ? Theme.of(context).colorScheme.error
                                    : Colors.transparent,
                            shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            'L',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  color: controller
                                              .isLeftRightCardSelectedValue ==
                                          'L'
                                      ? Theme.of(context).colorScheme.secondary
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 24.px),
                  GestureDetector(
                    onTap: () => controller.clickOnLAndRCardView(value: 'R'),
                    child: Container(
                      height: 80.px,
                      width: 80.px,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/img/black_card_img.png'),
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color:
                                controller.isLeftRightCardSelectedValue == 'R'
                                    ? Theme.of(context).colorScheme.error
                                    : Theme.of(context).colorScheme.onSecondary,
                            width: .5.px),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color:
                                controller.isLeftRightCardSelectedValue == 'R'
                                    ? Theme.of(context).colorScheme.error
                                    : Colors.transparent,
                            shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            'R',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  color: controller
                                              .isLeftRightCardSelectedValue ==
                                          'R'
                                      ? Theme.of(context).colorScheme.secondary
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget threeIndexUiView(
      {required YourDispersionController controller, required int index}) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.px),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              questionNumberTextView(text: 'Question 0$index'),
              SizedBox(height: 8.px),
              questionTextView(
                  text: '''What's your driving distance average?'''),
              SizedBox(height: 32.px),
              SizedBox(
                height: 160.px,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 48.px,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xff2E2525),
                              width: 1.px,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CupertinoPicker(
                            selectionOverlay:
                                const CupertinoPickerDefaultSelectionOverlay(
                              background: Colors.transparent,
                            ),
                            scrollController: FixedExtentScrollController(
                              initialItem: controller.items
                                  .indexOf(controller.selectedNumber),
                            ),
                            itemExtent: 48.px,
                            onSelectedItemChanged: (index) {
                              setState(() {
                                controller.selectedNumber =
                                    controller.items[index];
                              });
                            },
                            children: controller.items.map((value) {
                              return Center(
                                child: Text(
                                  "$value",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.px),
                          child: Text(
                            "Yards",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.px),
              CW.commonGradiantDividerView(),
              SizedBox(height: 24.px),
              questionTextView(text: '''What's your shot shape off the tee?'''),
              SizedBox(height: 24.px),
              SizedBox(
                height: 18.px,
                child: ListView.builder(
                  itemCount: controller.firstQuesRadioTitleList.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 16.px),
                      child: GestureDetector(
                        onTap: () => controller.clickOnFirstQuesRadioButton(
                            index: index),
                        child: commonRadioButton(
                          title: controller.firstQuesRadioTitleList[index],
                          value: controller.firstQuesRadioSelectedValue,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 24.px),
              CW.commonGradiantDividerView(),
              SizedBox(height: 24.px),
              questionTextView(text: '''What is your most common miss?'''),
              SizedBox(height: 24.px),
              SizedBox(
                height: 18.px,
                child: ListView.builder(
                  itemCount: controller.secondQuesRadioTitleList.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 16.px),
                      child: GestureDetector(
                        onTap: () => controller.clickOnSecondQuesRadioButton(
                            index: index),
                        child: commonRadioButton(
                          title: controller.secondQuesRadioTitleList[index],
                          value: controller.secondQuesRadioSelectedValue,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget fourthIndexUiView(
      {required YourDispersionController controller, required int index}) {
    double barHeight = 350.px;
    double handlePosition = barHeight * (1 - controller.progress);
    handlePosition =
        handlePosition <= 90 ? handlePosition : handlePosition - 20;
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.px),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              questionNumberTextView(text: 'Question 0$index'),
              SizedBox(height: 8.px),
              questionTextView(text: '''Choose a club in your bag'''),
              SizedBox(height: 32.px),
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  setState(() {
                    controller.progress -= details.primaryDelta! / barHeight;
                    controller.progress = controller.progress.clamp(0.0, 1.0);
                  });
                },
                child: SizedBox(
                  height: barHeight * 1.5.px,
                  child: ListView(
                    children: [
                      Wrap(
                        children: List.generate(
                          controller.getClubsData.length,
                          (index) => GestureDetector(
                            onTap: () =>
                                controller.clickOnClubCard(index: index),
                            child: Container(
                              height: 54.px,
                              width: MediaQuery.of(context).size.width * .14,
                              padding: EdgeInsets.all(10.px),
                              margin:
                                  EdgeInsets.only(left: 10.px, bottom: 10.px),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.px),
                                border: Border.all(
                                  color: controller.getClubsDataSelected
                                          .contains(
                                              controller.getClubsData[index])
                                      ? Theme.of(context).colorScheme.error
                                      : Theme.of(context).colorScheme.surface,
                                ),
                              ),
                              child: Text(
                                controller.getClubsData[index].code ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.px,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      /*Row(
                        children: [
                          Expanded(
                            child: commonTitleTextView(
                              text: 'Ending Lie',
                            ),
                          ),
                          SizedBox(width: 16.px),
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
                                        style:
                                            Theme.of(context).textTheme.labelMedium,
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
                                    color:
                                        Theme.of(context).scaffoldBackgroundColor,
                                    border: Border.all(
                                      color: controller.isMenuOpen
                                          ? Theme.of(context).colorScheme.primary
                                          : Colors.transparent,
                                      width: 2.px,
                                    ),
                                    borderRadius: BorderRadius.circular(8.px),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        controller.selectedOption,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
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
                          )
                        ],
                      ),
                      SizedBox(height: 10.px),
                      Row(
                        children: [
                          Expanded(
                            child: commonTitleTextView(
                              text: 'Include in dispersion',
                            ),
                          ),
                          SizedBox(width: 16.px),
                          CW.commonSwitchButton(
                            context: context,
                            value: controller.includeInDispersionSwitchButtonValue,
                            onChanged: (value) =>
                                controller.clickOnIncludeInDispersionSwitchButton(),
                          ),
                          SizedBox(width: 8.px),
                          Icon(
                            Icons.info_outline,
                            color: Theme.of(context).colorScheme.surface,
                          )
                        ],
                      ),
                      SizedBox(height: 10.px),
                      commonTitleTextView(text: 'Lie'),
                      SizedBox(height: 10.px),
                      SizedBox(
                        height: 32.px,
                        child: ListView.builder(
                          itemCount: controller.levelTitleList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                right: index != controller.levelTitleList.length - 1
                                    ? 6.px
                                    : 0.px,
                              ),
                              child: CW.commonBlackCardView(
                                context: context,
                                onTap: () =>
                                    controller.clickOnLevelCardView(index: index),
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.px, horizontal: 16.px),
                                borderRadius: 16.px,
                                isBlackBg: controller.selectedLevelValue != index,
                                widget: Center(
                                  child: Text(
                                    controller.levelTitleList[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color:
                                              controller.selectedLevelValue == index
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                        ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10.px),
                      commonTitleTextView(text: 'Stock Wind'),
                      SizedBox(height: 10.px),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                controller.isStockWindOpen = !controller.isStockWindOpen;
                              });
                            },
                            child: CW.commonBlackCardView(
                              context: context,
                              widget: PopupMenuButton<String>(
                                position: PopupMenuPosition.under,
                                initialValue: controller.selectedStockWind,
                                onSelected: (value) {
                                  setState(() {
                                    controller.selectedStockWind = value;
                                    controller.isStockWindOpen = false;
                                  });
                                },
                                onCanceled: () {
                                  setState(() {
                                    controller.isStockWindOpen = false;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                color: Theme.of(context).scaffoldBackgroundColor,
                                itemBuilder: (BuildContext context) {
                                  return controller.stockWindList
                                      .map((String option) {
                                    return PopupMenuItem<String>(
                                      height: 32.px,
                                      value: option,
                                      child: Text(
                                        option,
                                        style:
                                            Theme.of(context).textTheme.labelMedium,
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
                                    color:
                                        Theme.of(context).scaffoldBackgroundColor,
                                    border: Border.all(
                                      color: controller.isStockWindOpen
                                          ? Theme.of(context).colorScheme.primary
                                          : Colors.transparent,
                                      width: 2.px,
                                    ),
                                    borderRadius: BorderRadius.circular(8.px),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        controller.selectedStockWind,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
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
                          SizedBox(width: 20.px),
                          Expanded(
                            child: SizedBox(
                              height: 38.px,
                              child: ListView.builder(
                                itemCount: 4,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 32.px,
                                    width: 32.px,
                                    margin: EdgeInsets.only(right: 8.px),
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/img/black_card_img.png'),
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: GestureDetector(
                                      onTap: () => controller
                                          .clickOnStockWindArrow(index: index),
                                      child: Center(
                                        child: RotatedBox(
                                          quarterTurns: (index == 0)
                                              ? 2
                                              : (index == 1)
                                                  ? 4
                                                  : (index == 2)
                                                      ? 3
                                                      : 1,
                                          child: Container(
                                            height: 32.px,
                                            width: 32.px,
                                            decoration: BoxDecoration(
                                              color:
                                                  controller.selectedStockWindValue ==
                                                          index
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .error
                                                      : Colors.transparent,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: CW.imageView(
                                                image:
                                                    'assets/icons/right_arrow_ic.png',
                                                isAssetImage: true,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                height: 20.px,
                                                width: 20.px,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.px),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: commonTitleTextView(
                              text: 'In Between',
                            ),
                          ),
                          SizedBox(width: 16.px),
                          CW.commonSwitchButton(
                            context: context,
                            value: controller.inBetweenAndStockNumberSwitchButtonValue,
                            onChanged: (value) =>
                                controller.clickOnInBetweenAndStockNumberSwitchButton(),
                          ),
                          SizedBox(width: 8.px),
                          Expanded(
                            child: commonTitleTextView(
                                text: 'Stock Number', textAlign: TextAlign.end),
                          ),
                        ],
                      ),*/
                      SizedBox(height: 10.px),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget fifthIndexUiView(
      {required YourDispersionController controller, required int index}) {
    double barHeight = 350.px;
    double handlePosition = barHeight * (1 - controller.progress);
    handlePosition =
        handlePosition <= 90 ? handlePosition : handlePosition - 20;
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.px),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              questionNumberTextView(text: 'Question 0$index'),
              SizedBox(height: 8.px),
              questionTextView(text: '''Rate your driver fairway percentage'''),
              SizedBox(height: 32.px),
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  setState(() {
                    controller.progress -= details.primaryDelta! / barHeight;
                    controller.progress = controller.progress.clamp(0.0, 1.0);
                  });
                },
                child: SizedBox(
                  height: barHeight,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Exceptional',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium),
                                    Text('Average',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium),
                                    Text('Poor',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(height: barHeight * 0.32),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CW.commonGradiantDividerView(),
                                        ),
                                        Text(
                                          'PGA Tour Average 65%',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                  fontSize: 8.px,
                                                  fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: barHeight * 0.35),
                                    CW.commonGradiantDividerView(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.px),
                          Expanded(
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                      width: 22.px,
                                      child: Center(
                                        child: Container(
                                          width: 16.px,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.px),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.px),
                                          ),
                                          child: CustomPaint(
                                            size: Size(16.px, barHeight),
                                            painter:
                                                SegmentedProgressBarPainter(
                                                    controller.progress,
                                                    context),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 22.px,
                                      height: 32.px,
                                      margin:
                                          EdgeInsets.only(top: handlePosition),
                                      decoration: const BoxDecoration(
                                          // color: Theme.of(context).colorScheme.onPrimary,
                                          //   borderRadius: BorderRadius.circular(12.px),
                                          image: DecorationImage(
                                        image: AssetImage(
                                            'assets/img/progress_bar_handal_img.png'),
                                        fit: BoxFit.contain,
                                      )),
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount:
                                        controller.progressBarPerList.length,
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            bottom: barHeight / 12 - 7),
                                        child: Text(
                                          controller.progressBarPerList[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge
                                              ?.copyWith(
                                                fontSize: 9.px,
                                                // color: Colors.black
                                              ),
                                          textAlign: TextAlign.end,
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          Container(
                            width: 40.px,
                            height: 25.px,
                            padding: EdgeInsets.symmetric(
                                vertical: 4.px, horizontal: 6.px),
                            margin: EdgeInsets.only(
                                top: handlePosition, right: 100.px),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary
                                      .withOpacity(.8),
                                  blurRadius: 5.px,
                                  spreadRadius: .2.px,
                                )
                              ],
                              borderRadius: BorderRadius.circular(12.px),
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/background_img/black_button_bg.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                controller.progressPercentage,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 10.px,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget sixthIndexUiView(
      {required YourDispersionController controller, required int index}) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          questionNumberTextView(text: 'Question 0$index'),
          SizedBox(height: 8.px),
          questionTextView(
              text:
                  '''Based on your responses we can expect 95% of your shots to fall within this range of outcomes. As we record your actual shots this will get even more accurate.'''),
          SizedBox(height: 16.px),
          CW.imageView(
              image: 'assets/dummy_img/play_at_course_img.png',
              isAssetImage: true,
              height: 592.px,
              width: double.infinity,
              borderRadius: BorderRadius.circular(24.px)),
          SizedBox(height: 25.px),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 8.px),
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color(0xff1A171780),
                  Color(0xff08060680),
                ]),
                border: Border.all(
                  color: const Color(0xff2E2525),
                  width: 1.px,
                ),
                borderRadius: BorderRadius.circular(8.px)),
            child: Text(
              'When you use the course preview tool this will help you pick targets and optimized your strokes gained',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: 50.px),
        ],
      ),
    );
  }

  Widget commonTimeTextView({required String text}) => Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500, color: const Color(0xff665252)),
      );

  Widget seventhIndexUiView(
      {required YourDispersionController controller, required int index}) {
    return Padding(
      padding: EdgeInsets.all(24.px),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              CW.imageView(
                  image: 'assets/img/check_img.png',
                  isAssetImage: true,
                  height: 200.px,
                  width: 200.px),
              Text(
                'Well Done, Andrew!',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(height: -1.px),
              ),
              SizedBox(height: 16.px),
              Text(
                'Your profile setup successfully!',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Countdown(
                seconds: 5,
                build: (BuildContext context, double time) => commonTimeTextView(
                    text:
                        'Redirect to home screen in 0${time.toInt()} seconds.'),
                interval: const Duration(milliseconds: 100),
                onFinished: () {
                  controller.clickOnCloseButton(context: context);
                },
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => controller.clickOnCloseButton(context: context),
              child: SizedBox(
                height: 24.px,
                width: 24.px,
                child: Center(
                  child: CW.imageView(
                      image: 'assets/icons/ic_close.png',
                      isAssetImage: true,
                      height: 20.px,
                      width: 20.px),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget commonTitleTextView(
          {required String text,
          FontWeight? fontWeight,
          TextAlign? textAlign}) =>
      Text(
        text,
        textAlign: textAlign,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: fontWeight ?? FontWeight.w700,
            ),
      );
}

class SegmentedProgressBarPainter extends CustomPainter {
  final double progress;
  final BuildContext context;

  SegmentedProgressBarPainter(this.progress, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = size.width
      ..strokeCap = StrokeCap.round;

    double height = size.height;

    // Draw "Poor" section in red (bottom 30%)
    paint.color = Theme.of(context).scaffoldBackgroundColor;
    canvas.drawLine(
      Offset(size.width / 2, height),
      Offset(size.width / 2, height * 0.7),
      paint,
    );

    // Draw "Average" section in gray (30% to 70%)
    paint.color = Theme.of(context).scaffoldBackgroundColor;
    canvas.drawLine(
      Offset(size.width / 2, height * 0.7),
      Offset(size.width / 2, height * 0.3),
      paint,
    );

    // Draw "Exceptional" section in dark gray (top 30%)
    paint.color = Theme.of(context).scaffoldBackgroundColor;
    canvas.drawLine(
      Offset(size.width / 2, height * 0.3),
      Offset(size.width / 2, 0),
      paint,
    );

    // Draw the filled portion based on progress
    paint.color = Theme.of(context).colorScheme.error;
    canvas.drawLine(
      Offset(size.width / 2, height),
      Offset(size.width / 2, height * (1 - progress)),
      paint,
    );

    // Draw divider lines at each 10% interval
    Paint dividerPaint = Paint()
      ..color = Theme.of(context).colorScheme.onSurface
      ..strokeWidth = 2;

    for (int i = 1; i <= 9; i++) {
      double y = height *
          (1 - i * 0.103); // Calculate the position at each 10% increment
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        dividerPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
