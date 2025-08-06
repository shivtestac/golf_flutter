import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'ai_caddie_controller.dart';

class AiCaddieScreen extends StatefulWidget {
  const AiCaddieScreen({super.key});

  @override
  State<AiCaddieScreen> createState() => _AiCaddieScreenState();
}

class _AiCaddieScreenState extends State<AiCaddieScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var aiCaddieController = Provider.of<AiCaddieController>(context);
    aiCaddieController.initMethod(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AiCaddieController>(
      builder:
          (BuildContext context, AiCaddieController controller, Widget? child) {
        return SafeArea(
          child: Scaffold(
              body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.px),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A.I Caddie',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.px),
                    ),
                    SizedBox(height: 6.px),
                    Text(
                      'A.I Caddie offers real-time golf advice and course insights.',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.px),
                questionTextView(text: '''Select a Club''', context: context),
                SizedBox(height: 32.px),
                Expanded(
                  child: ListView(
                    children: [
                      Wrap(
                        children: List.generate(
                          controller.listOfClubs.length,
                          (index) => GestureDetector(
                            onTap: () {
                              controller.selectedClubsValue = index;
                              setState(() {});
                            },
                            child: Container(
                              height: 54.px,
                              width: MediaQuery.of(context).size.width * .14,
                              padding: EdgeInsets.all(10.px),
                              margin: EdgeInsets.only(left: 10.px, bottom: 10.px),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.px),
                                  border: Border.all(
                                      color: controller.selectedClubsValue ==
                                              index
                                          ? Theme.of(context).colorScheme.error
                                          : Theme.of(context)
                                              .colorScheme
                                              .surface)),
                              child: Text(
                                controller.listOfClubs[index].name ?? '',
                                //maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.px),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: commonTitleTextView(
                                text: 'Ending Lie', context: context),
                          ),
                          SizedBox(width: 16.px),
                          GestureDetector(
                            onTap: () {
                              controller.isMenuOpen = !controller.isMenuOpen;
                              setState(() {});
                            },
                            child: CW.commonBlackCardView(
                              context: context,
                              widget: PopupMenuButton<String>(
                                position: PopupMenuPosition.under,
                                initialValue: controller.selectedOption,
                                onSelected: (value) {
                                  controller.selectedOption = value;
                                  controller.isMenuOpen = false;
                                  setState(() {});
                                },
                                onCanceled: () {
                                  controller.isMenuOpen = false;
                                  setState(() {});
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
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
                                text: 'Include in dispersion', context: context),
                          ),
                          SizedBox(width: 16.px),
                          CW.commonSwitchButton(
                            context: context,
                            value:
                                controller.includeInDispersionSwitchButtonValue,
                            onChanged: (value) {
                              controller.includeInDispersionSwitchButtonValue =
                                  !controller
                                      .includeInDispersionSwitchButtonValue;
                              setState(() {});
                            },
                          ),
                          SizedBox(width: 8.px),
                          Icon(
                            Icons.info_outline,
                            color: Theme.of(context).colorScheme.surface,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.px),
                          commonTitleTextView(text: 'Lie', context: context),
                          SizedBox(height: 10.px),
                          Wrap( children: List.generate(controller.levelTitleList.length, (index) => Padding(
                            padding: EdgeInsets.only(
                              right: index !=
                                  controller.levelTitleList.length - 1
                                  ? 6.px
                                  : 0.px,
                              bottom: index !=
                            controller.levelTitleList.length - 1
                            ? 6.px
                              : 0.px,
                            ),
                            child: CW.commonBlackCardView(
                              context: context,
                              onTap: () {
                                controller.selectedLevelValue = index;
                                setState(() {});
                              },
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.px, horizontal: 16.px),
                              borderRadius: 16.px,
                              isBlackBg:
                              controller.selectedLevelValue != index,
                              widget: Text(
                                controller.levelTitleList[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color:
                                  controller.selectedLevelValue ==
                                      index
                                      ? Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      : Theme.of(context)
                                      .colorScheme
                                      .surface,
                                ),
                              ),
                            ),
                          ),),),
                          SizedBox(height: 10.px),
                          commonTitleTextView(
                              text: 'Stock Wind', context: context),
                          SizedBox(height: 10.px),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.isStockWindOpen =
                                      !controller.isStockWindOpen;
                                  setState(() {});
                                },
                                child: CW.commonBlackCardView(
                                  context: context,
                                  widget: PopupMenuButton<String>(
                                    position: PopupMenuPosition.under,
                                    initialValue: controller.selectedStockWind,
                                    onSelected: (value) {
                                      controller.selectedStockWind = value;
                                      controller.isStockWindOpen = false;
                                      setState(() {});
                                    },
                                    onCanceled: () {
                                      controller.isStockWindOpen = false;
                                      setState(() {});
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    color:
                                        Theme.of(context).scaffoldBackgroundColor,
                                    itemBuilder: (BuildContext context) {
                                      return controller.stockWindList
                                          .map((String option) {
                                        return PopupMenuItem<String>(
                                          height: 32.px,
                                          value: option,
                                          child: Text(
                                            option,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
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
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        border: Border.all(
                                          color: controller.isStockWindOpen
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
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
                                          onTap: () {
                                            controller.selectedStockWindValue =
                                                index;
                                            setState(() {});
                                          },
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
                                                  color: controller
                                                              .selectedStockWindValue ==
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
                                    text: 'In Between', context: context),
                              ),
                              SizedBox(width: 16.px),
                              CW.commonSwitchButton(
                                context: context,
                                value: controller
                                    .inBetweenAndStockNumberSwitchButtonValue,
                                onChanged: (value) {
                                  controller
                                          .inBetweenAndStockNumberSwitchButtonValue =
                                      !controller
                                          .inBetweenAndStockNumberSwitchButtonValue;
                                  setState(() {});
                                },
                              ),
                              SizedBox(width: 8.px),
                              Expanded(
                                child: commonTitleTextView(
                                    context: context,
                                    text: 'Stock Number',
                                    textAlign: TextAlign.end),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10.px),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CW.commonGradiantDividerView(),
                          SizedBox(height: 12.px),
                          CW.commonElevatedButtonView(
                            context: context,
                            onTap: () =>controller.clickOnCalculateTargetWithAi(context: context),
                            buttonText: 'Calculate Target with AI',
                          ),
                          SizedBox(height: 8.px),
                        ],
                      ),
                      SizedBox(height: 10.px),
                    ],
                  ),
                ),
              ],
            ),
          )),
        );
      },
    );
  }

  Widget questionNumberTextView(
          {required String text, required BuildContext context}) =>
      Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(fontWeight: FontWeight.w700),
      );

  Widget questionTextView(
          {required String text, required BuildContext context}) =>
      Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.w700),
      );

  Widget commonTitleTextView(
          {required String text,
          FontWeight? fontWeight,
          TextAlign? textAlign,
          required BuildContext context}) =>
      Text(
        text,
        textAlign: textAlign,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: fontWeight ?? FontWeight.w700,
            ),
      );

  clickOnViewScorecard({required BuildContext context}) {
    // NM.popMethod(context: context);
    // NM.pushMethod(
    //   screen: ScoreCardScreen(),
    //   context: context,
    // );
  }

  clickOnClubCard({required int index}) {
    // controller.selectedClubsValue = index;
    // notifyListeners();
  }

  clickOnSetShortResult({required BuildContext context}) {}
}
