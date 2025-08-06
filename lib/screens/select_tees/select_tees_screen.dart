import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../common/app_singleton.dart';
import '../../common/cw.dart';
import '../courses_detail/courses_detail_controller.dart';

class SelectTeesScreen extends StatefulWidget {
  const SelectTeesScreen({super.key});

  @override
  State<SelectTeesScreen> createState() => _SelectTeesScreenState();
}

class _SelectTeesScreenState extends State<SelectTeesScreen> {
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
  }

  @override
  void deactivate() {
    super.deactivate();
    var coursesDetailController =
        Provider.of<CoursesDetailController>(context, listen: false);
    coursesDetailController.isSearchUiValue = true;
    //coursesDetailController.courses = null;
  }

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
              'Select Tees',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            centerTitle: false,
            titleSpacing: -8.px,
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
                      commonTitleTextView(
                          text: AppSingleton.instance.pageName == 'Play'
                              ? 'Meadow Springs Golf And Country Club'
                              : 'Cypress Point Club'),
                    ],
                  ),
                ),
                SizedBox(height: 16.px),
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
                          onTap: () => controller.clickOnSelectTreesListCard(
                              index: index, context: context),
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
                                            'Men: ${controller.courses!.teeDetails?[index].manScore ?? ''} - Women: ${controller.courses!.teeDetails?[index].womanScore ?? ''}',
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 24.px,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
