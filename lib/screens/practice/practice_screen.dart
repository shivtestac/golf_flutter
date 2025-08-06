import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cp/gradient_circular_progress_bar.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/screens/practice/practice_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PracticeController>(
      builder: (context, PracticeController controller, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Practice',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.px,
                  ),
                ),
                SizedBox(height: 6.px),
                Text(
                  'You can track your practice records',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            leading: const SizedBox(),
            leadingWidth: 24.px,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.px),
              practiceTopCardListView(controller: controller),
              Expanded(
                child: controller.isChipsDataLoadValue
                 ? loaderView()
                 : ListView.builder(
                     physics: const ScrollPhysics(),
                     itemCount: controller.cardDetailList.length,
                     shrinkWrap: true,
                     padding: EdgeInsets.symmetric(vertical: 16.px, horizontal: 24.px),
                     itemBuilder: (context, index) {
                       if (controller.selectedCardValue == "All" || controller.selectedCardValue == controller.cardDetailList[index]['cardType']) {
                         return GestureDetector(
                           onTap: () => controller.clickOnPracticeCardView(context:context,index:index),
                           child: commonCardVie(controller: controller, index: index),
                         );
                       }
                       return const SizedBox.shrink();
                   },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget practiceTopCardListView({required PracticeController controller}) {
    return SizedBox(
      height: 32.px,
      child: ListView.builder(
        itemCount: controller.topListCardTitle.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 24.px),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index != controller.topListCardTitle.length - 1 ? 6.px : 0.px,
            ),
            child: CW.commonBlackCardView(
              context: context,
              onTap: () => controller.clickOnPracticeTopListCardView(index: index),
              padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 16.px),
              borderRadius: 16.px,
              isBlackBg: !controller.selectedCardValue.contains(controller.topListCardTitle[index]),
              widget: Center(
                child: Text(
                  controller.topListCardTitle[index],
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: controller.selectedCardValue.contains(controller.topListCardTitle[index])
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget commonTextButtonView({GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Start Learning',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
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
    );
  }

  Widget loaderView() => Center(
    child: SizedBox(
      height: 20.px,
      width: 20.px,
      child: const GradientCircularProgressIndicator(),
    ),
  );

  Widget commonCardVie({required PracticeController controller, required int index}) {
    final bgImage = controller.cardBgImgList[index % controller.cardBgImgList.length];
    return Container(
      height: 140.px,
      width: double.infinity,
      padding: EdgeInsets.all(16.px),
      margin: EdgeInsets.only(bottom: 12.px),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            // controller.cardBgImgList[index],
            bgImage,
          ),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(16.px),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.cardDetailList[index]['cardName'],
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6.px),
                Text(
                  controller.cardDetailList[index]['cardDetail'],
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                commonTextButtonView()
              ],
            ),
          ),
          SizedBox(width: 112.px)
        ],
      ),
    );
  }
}
