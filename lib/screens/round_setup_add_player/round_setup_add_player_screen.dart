import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cp/gradient_circular_progress_bar.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../courses_detail/courses_detail_controller.dart';

class RoundSetupAddPlayerScreen extends StatefulWidget {
  const RoundSetupAddPlayerScreen({super.key});

  @override
  State<RoundSetupAddPlayerScreen> createState() =>
      _RoundSetupAddPlayerScreenState();
}

class _RoundSetupAddPlayerScreenState extends State<RoundSetupAddPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CoursesDetailController>(
      builder: (context, CoursesDetailController controller, child) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
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
                                'Add Player',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.px),
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
                                  hintText: 'Search Players',
                                  controller: controller.searchController,
                                  onChanged: (value) =>
                                      controller.searchOnChange(value: value),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CW.commonGradiantDividerView(),
                    controller.isSearchLoading
                        ? Padding(
                            padding: EdgeInsets.all(24.px),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20.px,
                                  width: 20.px,
                                  child:
                                      const GradientCircularProgressIndicator(),
                                ),
                                SizedBox(width: 12.px),
                                Text(
                                  'Searching for ${controller.searchController.text}...',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: controller.filteredList.isEmpty &&
                                    controller.searchController.text.isNotEmpty
                                ? Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 180.px),
                                      child: Text(
                                        'Data not found!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                      ),
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(24.px),
                                        child: Text(
                                          'Available Players',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14.px,
                                              ),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount:
                                              controller.filteredList.length,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24.px),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                bottom: index !=
                                                        controller.followersList
                                                                .length -
                                                            1
                                                    ? 24.px
                                                    : 0.px,
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CW.imageView(
                                                      height: 40.px,
                                                      width: 40.px,
                                                      radius: 20.px,
                                                      image: controller
                                                              .filteredList[
                                                                  index]
                                                              .profilePhoto ??
                                                          '',
                                                      isAssetImage: false),
                                                  SizedBox(
                                                    width: 8.px,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          controller
                                                                  .filteredList[
                                                                      index]
                                                                  .name ??
                                                              '',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelMedium
                                                                  ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                        ),
                                                        SizedBox(height: 4.px),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.star,
                                                              size: 12.px,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .error,
                                                            ),
                                                            Flexible(
                                                              child: Text(
                                                                ' ${controller.filteredList[index].handicap}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  CW.commonElevatedButtonView(
                                                    context: context,
                                                    height: 32.px,
                                                    width: 88.px,
                                                    buttonTextFontSize: 12.px,
                                                    onTap: () => controller
                                                        .clickOnAddButton(
                                                            context: context,
                                                            index: index),
                                                    buttonText: controller
                                                            .addUserDataList
                                                            .contains(controller
                                                                    .filteredList[
                                                                index])
                                                        ? 'Added'
                                                        : 'Add',
                                                    isBlackBg: controller
                                                        .addUserDataList
                                                        .contains(controller
                                                                .filteredList[
                                                            index]),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                          )
                  ],
                ),
                if (controller.addUserDataList.isNotEmpty)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CW.commonGradiantDividerView(),
                      SizedBox(height: 12.px),
                      SizedBox(
                        height: 66.px,
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 24.px),
                          shrinkWrap: true,
                          itemCount: controller.addUserDataList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 16.px),
                              child: SizedBox(
                                width: 70.px,
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Column(
                                      children: [
                                        CW.imageView(
                                            width: 48.px,
                                            height: 48.px,
                                            image: controller
                                                    .filteredList[index]
                                                    .profilePhoto ??
                                                '',
                                            radius: 24.px,
                                            isAssetImage: false),
                                        SizedBox(height: 4.px),
                                        Text(
                                          controller.addUserDataList[index]
                                                  .name ??
                                              '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          controller.clickOnRemoveUserButton(
                                              context: context, index: index),
                                      child: Container(
                                        height: 20.px,
                                        width: 20.px,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                width: 1.px)),
                                        child: Center(
                                          child: CW.imageView(
                                              image:
                                                  'assets/icons/cancel_ic.png',
                                              isAssetImage: true,
                                              width: 16.px,
                                              height: 16.px),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 8.px),
                      CW.commonGradiantDividerView(),
                      SizedBox(height: 12.px),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.px),
                        child: CW.commonElevatedButtonView(
                          context: context,
                          onTap: () =>
                              controller.clickOnBackButton(context: context),
                          buttonText:
                              'Add ${controller.addUserDataList.length} Players',
                        ),
                      ),
                      SizedBox(height: 8.px),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
