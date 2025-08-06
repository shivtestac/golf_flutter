import 'dart:math';

//import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../common/cm.dart';
import '../../common/cw.dart';
import '../courses_detail/courses_detail_controller.dart';

class SetupPlayerScreen extends StatefulWidget {
  const SetupPlayerScreen({super.key});

  @override
  State<SetupPlayerScreen> createState() => _SetupPlayerScreenState();
}

class _SetupPlayerScreenState extends State<SetupPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CoursesDetailController>(
      builder: (context, CoursesDetailController controller, child) {
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
              'Setup Player',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            centerTitle: false,
            titleSpacing: -8.px,
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CW.commonGradiantDividerView(),
              SizedBox(height: 12.px),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.px),
                child: CW.commonElevatedButtonView(
                  context: context,
                  onTap: () =>
                      controller.clickOnSaveSettingsButton(context: context),
                  buttonText: 'Save Settings',
                ),
              ),
              SizedBox(height: 8.px),
            ],
          ),
          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 16.px),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.px),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonTitleTextView(text: 'Player'),
                      SizedBox(height: 16.px),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CW.imageView(
                            image: controller
                                    .addUserDataList[controller.isMenuOpen]
                                    .profilePhoto ??
                                '',
                            height: 40.px,
                            width: 40.px,
                            radius: 20.px,
                          ),
                          SizedBox(width: 16.px),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              commonTitleTextView(
                                text: controller
                                        .addUserDataList[controller.isMenuOpen]
                                        .name ??
                                    '',
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(height: 4.px),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Theme.of(context).colorScheme.error,
                                    size: 12.px,
                                  ),
                                  commonSubTitleTextView(
                                      text:
                                          "${controller.addUserDataList[controller.isMenuOpen].handicap ?? ''}")
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.px),
                CW.commonGradiantDividerView(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.px, vertical: 16.px),
                  child: commonTitleTextView(text: 'Select Tees'),
                ),
                if (controller.courses != null &&
                    controller.courses!.teeDetails != null &&
                    controller.courses!.teeDetails!.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.courses?.teeDetails?.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 24.px),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.px),
                        child: GestureDetector(
                          onTap: () => controller.clickOnSelectTeesListCard(
                              sId: controller.courses!.teeDetails![index].sId!),
                          child: Container(
                            padding: EdgeInsets.all(16.px),
                            decoration: BoxDecoration(
                              color: const Color(0xff0D0808),
                              borderRadius: BorderRadius.circular(8.px),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 24.px,
                                  width: 24.px,
                                  margin: EdgeInsets.only(right: 8.px),
                                  decoration: BoxDecoration(
                                    color: Color(int.parse(
                                        '0xFF${controller.courses!.teeDetails?[index].colorCode?.replaceAll('#', '')}')),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color(0xff332929),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      commonTitleTextView(
                                        text:
                                            '${controller.courses!.teeDetails?[index].color ?? ''} - ${controller.courses!.teeDetails?[index].distanceInYards ?? ''} yards',
                                      ),
                                      SizedBox(height: 5.px),
                                      commonSubTitleTextView(
                                        text:
                                            'Men:${controller.courses!.teeDetails?[index].manScore ?? ''} - Women:${controller.courses!.teeDetails?[index].womanScore ?? ''}',
                                      ),
                                    ],
                                  ),
                                ),
                                (controller.selectTeeValue ==
                                        controller
                                            .courses?.teeDetails?[index].sId)
                                    ? Container(
                                        height: 20.px,
                                        width: 20.px,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            width: 5.px,
                                          ),
                                        ),
                                      )
                                    : CW.commonBlackCardView(
                                        context: context,
                                        widget: const SizedBox(),
                                        height: 20.px,
                                        width: 20.px,
                                        borderRadius: 10.px,
                                      )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                SizedBox(height: 8.px),
                CW.commonGradiantDividerView(),
                if (controller.systems.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 24.px, vertical: 16.px),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonTitleTextView(text: 'Handicap System'),
                        SizedBox(height: 16.px),
                        ///Comment by arvind .....
                        // commonDropDown(
                        //   context: context,
                        //   hintText: 'Select Handicap System',
                        //   items: (filter, loadProps) => List.generate(
                        //     controller.systems.length,
                        //     (index) =>
                        //         controller.systems[index].name.toString(),
                        //   ),
                        //   textC: controller.dropDownTextEditingController,
                        //   inAsyncCall: false,
                        //   clickOnListOfDropDown: (value) =>
                        //       controller.clickOnListOfDropDown(value: value),
                        // ),
                        SizedBox(height: 16.px),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: commonHandicapSystemSelectCard(
                                onTap: () =>
                                    controller.clickOnYourHandicapCardView(
                                        value: 'Your Handicap'),
                                isSelectValue: controller
                                        .isYourHandicapCardSelectedValue ==
                                    'Your Handicap',
                                text: 'Your Handicap',
                              ),
                            ),
                            SizedBox(width: 16.px),
                            Expanded(
                              child: commonHandicapSystemSelectCard(
                                onTap: () =>
                                    controller.clickOnYourHandicapCardView(
                                        value: 'Playing Handicap'),
                                isSelectValue: controller
                                        .isYourHandicapCardSelectedValue ==
                                    'Playing Handicap',
                                text: 'Playing Handicap',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.px),
                        Text(
                          'Input 36 if you don’t have',
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                      ],
                    ),
                  ),
                SizedBox(height: 80.px),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget commonTitleTextView({
    required String text,
    FontWeight? fontWeight,
  }) =>
      Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: fontWeight ?? FontWeight.w700,
            ),
      );

  Widget commonSubTitleTextView({
    required String text,
    double? fontSize,
  }) =>
      Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: fontSize ?? 10.px,
            ),
      );

 /* Widget commonDropDown({
    required BuildContext context,
    required String hintText,
    required DropdownSearchOnFind<String>? items,
    required TextEditingController textC,
    bool isValidate = false,
    required bool inAsyncCall,
    required Function(String? value) clickOnListOfDropDown,
    Color? errorTextColor,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return DropdownSearch<String>(
          popupProps: PopupProps.menu(
            fit: FlexFit.loose,
            menuProps: MenuProps(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.px),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 1.px,
                ),
              ),
            ),
            itemBuilder: (context, item, dis, isSelected) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.px),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.px),
                    Text(
                      item,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.px,
                          ),
                    ),
                    SizedBox(height: 10.px),
                    CW.commonGradiantDividerView(),
                  ],
                ),
              );
            },
          ),
          decoratorProps: DropDownDecoratorProps(
            textAlign: TextAlign.left,
            textAlignVertical: TextAlignVertical.center,
            baseStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.px,
                ),
            decoration: InputDecoration(
              fillColor: const Color(0xff2E2525),
              filled: false,
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.titleMedium,
              // contentPadding: EdgeInsets.symmetric(horizontal: 4.px,),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.px),
                borderSide: BorderSide(
                  color: const Color(0xff2E2525),
                  width: 1.px,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.px),
                borderSide: BorderSide(
                  color: const Color(0xff2E2525),
                  width: 1.px,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.px),
                borderSide: BorderSide(
                  color: const Color(0xff2E2525),
                  width: 1.px,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.px),
                borderSide: BorderSide(
                  color: const Color(0xff2E2525),
                  width: 1.px,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.px),
                borderSide: BorderSide(
                  color: const Color(0xff2E2525),
                  width: 1.px,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.px),
                borderSide: BorderSide(
                  color: const Color(0xff2E2525),
                  width: 1.px,
                ),
              ),
            ),
          ),
          items: items,
          onChanged: (value) {
            CM.unFocsKeyBoard();
            if (value != null) {
              setState(() {
                textC.text = value;
                clickOnListOfDropDown(value);
                // controller.count.value++;
              });
            }
          },
          selectedItem: textC.text.isNotEmpty ? textC.text : null,
        );
      },
    );
  }*/

  Widget commonHandicapSystemSelectCard({
    required bool isSelectValue,
    required String text,
    GestureTapCallback? onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: CW.commonBlackCardView(
          context: context,
          width: double.infinity,
          height: 48.px,
          widget: Container(
            decoration: BoxDecoration(
              color: isSelectValue
                  ? Theme.of(context).colorScheme.error
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8.px),
            ),
            child: Center(
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isSelectValue
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.onSurface,
                      fontWeight:
                          isSelectValue ? FontWeight.w600 : FontWeight.w400,
                    ),
              ),
            ),
          ),
        ),
      );
}
