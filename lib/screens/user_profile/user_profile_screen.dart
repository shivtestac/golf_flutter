import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/common/progress_bar.dart';
import 'package:golf_flutter/screens/user_profile/user_profile_controller.dart';
import 'package:golf_flutter/theme/cl/lt_colors.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../common/app_singleton.dart';
import '../../common/cp/gradient_circular_progress_bar.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var userProfileController = Provider.of<UserProfileController>(context);
    userProfileController.initMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileController>(
      builder: (context, UserProfileController controller, child) {
        return ProgressBar(
          inAsyncCall: controller.inAsyncCall,
          child: Scaffold(
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
                controller.data?.username ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              centerTitle: false,
              titleSpacing: -8.px,
              actions: [
                GestureDetector(
                  onTap: (){
                    controller.clickOnLogoutButton(context: context);
                  },
                  child: Icon(Icons.logout,size: 25.px,color: Colors.white,),
                ),
                SizedBox(width: 16.px),
                GestureDetector(
                  onTap: () => controller.clickOnEditButton(context: context),
                  child: commonAppBarActionIconButton(
                    icon: 'assets/icons/edit_ic.png',
                  ),
                ),
                SizedBox(width: 16.px),
                commonAppBarActionIconButton(
                  icon: 'assets/icons/settings_ic.png',
                ),
                SizedBox(width: 24.px),
              ],
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 0.px, vertical: 16.px),
              children: [
                commonHorizontalPaddingView(
                  widget: profileView(controller: controller),
                ),
                commonHorizontalPaddingView(
                  widget: communityView(controller: controller),
                ),
                commonHorizontalPaddingView(
                  widget: watchView(controller: controller),
                ),
                commonHorizontalPaddingView(
                  widget: statsView(controller: controller),
                ),
                SizedBox(height: 30.px),
                practiceAndPlayView(controller: controller),
                SizedBox(height: 15.px),
                practiceView(controller: controller),
                SizedBox(height: 15.px),
                subscribeNowView(controller: controller),
                SizedBox(height: 40.px),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget commonHorizontalPaddingView({required Widget widget}) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.px),
        child: widget,
      );

  Widget commonAppBarActionIconButton(
          {required String icon, GestureTapCallback? onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: CW.imageView(
          image: icon,
          isAssetImage: true,
          height: 20.px,
          width: 20.px,
        ),
      );

  Widget commonTitleTextView({required String text, FontWeight? fontWeight}) =>
      Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: fontWeight ?? FontWeight.w700,
            ),
      );

  Widget commonProfileCardView({required String text}) =>
      CW.commonBlackCardView(
        context: context,
        padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 4.px),
        borderRadius: 12.px,
        widget: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 12.px,
              ),
        ),
      );

  Widget profileView({required UserProfileController controller}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CW.imageView(
              image: AppSingleton.instance.userData?.profilePhoto ?? '',
              height: 40.px,
              width: 40.px,
              borderRadius: BorderRadius.circular(20.px),
            ),
          ),
          SizedBox(width: 10.px),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonTitleTextView(
                text: controller.data?.username ?? '',
              ),
              Text(
                '...',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 16.px),
              Row(
                children: [
                  commonProfileCardView(text: 'Stroke Play'),
                  SizedBox(width: 8.px),
                  commonProfileCardView(text: 'Eagle'),
                  SizedBox(width: 8.px),
                  commonProfileCardView(text: 'Birdie'),
                ],
              ),
              SizedBox(height: 16.px),
            ],
          ),
        ],
      );

  Widget commonColumView({
    required String text1,
    required String text2,
    bool isStarIc = false,
    GestureTapCallback? onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 88.px,
          // height: 35.px,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isStarIc)
                    Icon(
                      Icons.star,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 16.px,
                    ),
                  SizedBox(width: 4.px),
                  commonTitleTextView(text: text1),
                ],
              ),
              SizedBox(height: 2.px),
              Text(
                text2,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      );

  Widget commonVerticalDividerView({double? height}) => SizedBox(
        height: height ?? 35.px,
        child: VerticalDivider(
          width: 16.px,
          thickness: 1.px,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      );

  Widget communityView({required UserProfileController controller}) => SizedBox(
        height: 70.px,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            commonColumView(
                text1: '${controller.data?.handicap ?? ''}',
                text2: 'HCP',
                isStarIc: true),
            commonVerticalDividerView(),
            commonColumView(
              text1: '961',
              text2: 'Followers',
              onTap: () => controller.clickOnFollowersView(context: context),
            ),
            commonVerticalDividerView(),
            commonColumView(
              text1: '7',
              text2: 'Following',
              onTap: () => controller.clickOnFollowingView(context: context),
            ),
          ],
        ),
      );

  Widget watchView({required UserProfileController controller}) => SizedBox(
        height: 72.px,
        child: Row(
          children: [
            Container(
              height: 40.px,
              width: 40.px,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/dummy_img/watch_img.png'),
                ),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 16.px),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Apple Watch Ultra',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    'Connected',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.px),
            CW.commonElevatedButtonView(
              context: context,
              height: 32.px,
              width: 88.px,
              borderRadius: 6.px,
              buttonTextFontSize: 12.px,
              isBlackBg: true,
              buttonText: 'Disconnect',
            )
          ],
        ),
      );

  Widget statsView({required UserProfileController controller}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              commonTitleTextView(text: 'Strokes Gained'),
              CW.commonBlackCardView(
                context: context,
                widget: PopupMenuButton<String>(
                  position: PopupMenuPosition.under,
                  initialValue: controller.selectedOption,
                  onSelected: (value) {
                    setState(() {
                      controller.selectedOption = value;
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
                          style: Theme.of(context).textTheme.labelMedium,
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
                      color: Theme.of(context).scaffoldBackgroundColor,
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
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 12.px),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '-1.3',
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                      ),
                      SizedBox(width: 4.px),
                      Icon(
                        Icons.arrow_drop_up,
                        color: Theme.of(context).colorScheme.surface,
                        size: 16.px,
                      ),
                      Text(
                        '1.1',
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: LightColors().success,
                                ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.px),
                  Text(
                    'SG/Round',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              SizedBox(width: 20.px),
              commonVerticalDividerView(
                height: 48.px,
              ),
              SizedBox(width: 20.px),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text:
                        'You lose 1.3 strokes per round compared to a 0 HCP. Your',
                    style: Theme.of(context).textTheme.titleSmall,
                    children: [
                      TextSpan(
                        text: ' overall game has improved by 1.1 strokes ',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: LightColors().success,
                            ),
                        children: [
                          TextSpan(
                            text: 'over your last 10 rounds.',
                            style: Theme.of(context).textTheme.titleSmall,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.px),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: controller.strokesData.map((data) {
              return SizedBox(
                height: 184.px,
                width: 68.px,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (data['value'] < 0)
                      Container(
                        height: 1,
                        width: 168.px,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    Container(
                      // height: (data['value'].abs() * 40).toDouble(),
                      height: data['topColorHeight'],
                      width: 168.px,
                      decoration: BoxDecoration(
                        color: data['color'],
                      ),
                    ),
                    if (data['value'] > 0)
                      Container(
                        height: 1,
                        width: 168.px,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    Container(
                      height: data['bottomColorHeight'],
                      width: 168.px,
                      decoration: const BoxDecoration(
                        color: Color(0xff0D0808),
                      ),
                    ),
                    SizedBox(height: 8.px),
                    commonTitleTextView(
                      text: data['value'] > 0
                          ? '+${data['value']}'
                          : '${data['value']}',
                    ),
                    SizedBox(height: 4.px),
                    Text(
                      data['label'],
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      );

  Widget practiceAndPlayView({required UserProfileController controller}) {
    return Column(
      children: [
        SizedBox(
          height: 416.px,
          child: commonHorizontalPaddingView(
            widget: PageView.builder(
              onPageChanged: (value) => controller.onPageChange(value: value),
              itemCount: 3,
              itemBuilder: (context, index) {
                return practiceAndPlayUi(controller: controller);
              },
            ),
          ),
        ),
        SizedBox(height: 8.px),
        SizedBox(
          height: 8.px,
          child: Center(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return commonDotView(
                  isCurrentIndex:
                      controller.currentPageIndex == index.toString(),
                );
              },
            ),
          ),
        ),
      ],
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

  Widget practiceAndPlayUi({required UserProfileController controller}) {
    return Stack(
      children: [
        CW.imageView(
          image: 'assets/background_img/courses_detail_bg.png',
          isAssetImage: true,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.zero,
          child: Container(
            padding: EdgeInsets.all(24.px),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(.6),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                        Text(
                          'Wind: 21 km/h NNE',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.px,
                              ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 24.px),
                Text(
                  'Meadow Springs Golf And Country Club',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                SizedBox(height: 8.px),
                Text(
                  'San Francisco, United Stated',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(height: 16.px),
                Row(
                  children: [
                    Expanded(
                      child: CW.commonElevatedButtonView(
                        context: context,
                        onTap: () => controller.clickOnStartRoundButton(
                            context: context),
                        isBlackBg: true,
                        height: 40.px,
                        buttonTextFontSize: 12.px,
                        buttonText: 'Preview',
                      ),
                    ),
                    SizedBox(width: 8.px),
                    Expanded(
                      child: CW.commonElevatedButtonView(
                        context: context,
                        onTap: () => controller.clickOnStartRoundButton(
                            context: context),
                        height: 40.px,
                        buttonTextFontSize: 12.px,
                        buttonText: 'Start Round',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget practiceView({required UserProfileController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonHorizontalPaddingView(
          widget: commonTitleTextView(text: 'Practice'),
        ),
        SizedBox(height: 12.px),
        SizedBox(
          height: 32.px,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 24.px),
            itemCount: controller.practiceChipsList.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 6.px),
                child: GestureDetector(
                  onTap: () => controller.clickOnPracticeChipsList(
                      context: context, index: index),
                  child: CW.commonBlackCardView(
                    context: context,
                    borderRadius: 16.px,
                    padding: controller.selectedChipsValue
                            .contains(controller.practiceChipsList[index])
                        ? EdgeInsets.zero
                        : EdgeInsets.symmetric(horizontal: 16.px),
                    widget: Container(
                      padding: controller.selectedChipsValue
                              .contains(controller.practiceChipsList[index])
                          ? EdgeInsets.symmetric(
                              vertical: 5.px, horizontal: 16.px)
                          : EdgeInsets.zero,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.px),
                        color: controller.selectedChipsValue
                                .contains(controller.practiceChipsList[index])
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          controller.practiceChipsList[index],
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                color: controller.selectedChipsValue.contains(
                                        controller.practiceChipsList[index])
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.onSurface,
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
        SizedBox(height: 12.px),
        SizedBox(
          height: 160.px,
          child: controller.isChipsDataLoadValue
              ? Center(
                  child: SizedBox(
                    height: 20.px,
                    width: 20.px,
                    child: const GradientCircularProgressIndicator(),
                  ),
                )
              : ListView.builder(
                  itemCount: controller.practiceCardDataList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 24.px),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 120.px,
                      margin: EdgeInsets.only(right: 8.px),
                      padding: EdgeInsets.all(16.px),
                      decoration: BoxDecoration(
                        color: const Color(0xff0D0808),
                        borderRadius: BorderRadius.circular(12.px),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.practiceCardDataList[index],
                            style: Theme.of(context).textTheme.displaySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.px),
                          CW.imageView(
                            image: 'assets/img/golf_player_img.png',
                            isAssetImage: true,
                            height: 88.px,
                            width: 88.px,
                          )
                        ],
                      ),
                    );
                  },
                ),
        )
      ],
    );
  }

  Widget subscribeNowView({required UserProfileController controller}) =>
      Container(
        height: 220.px,
        width: double.infinity,
        padding: EdgeInsets.all(24.px),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/home_golf_img.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.px),
            Text(
              'Join the\nGo Red Golf',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    height: 1.3.px,
                  ),
            ),
            SizedBox(height: 6.px),
            Text(
              'Track your skills to enhance the shots.\nOur subscription will start with just  \$0.00.',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: 11.px,
                    fontWeight: FontWeight.w400,
                  ),
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
