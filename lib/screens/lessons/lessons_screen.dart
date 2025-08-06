import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cp/gradient_circular_progress_bar.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/common/progress_bar.dart';
import 'package:golf_flutter/screens/lessons/lessons_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({super.key});

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var lessonsController = Provider.of<LessonsController>(context);
    lessonsController.initMethod();
  }

  @override
  void dispose() {
    super.deactivate();
    var lessonsController = Provider.of<LessonsController>(context);
    lessonsController.isInitCalled = false;
    lessonsController.inAsyncCall = false;
    lessonsController.searchController.clear();
    lessonsController.getLessonsData.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LessonsController>(
      builder: (context, LessonsController controller, child) {
        return ProgressBar(
          inAsyncCall: controller.inAsyncCall,
          child: Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.px),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.px),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Lessons',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: 20.px),
                                  ),
                                  SizedBox(height: 6.px),
                                  Text(
                                    'Find the videos resources to learn your most  favourite shots',
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => controller.clickOnBookMarkButton(context: context),
                              child:  CW.imageView(
                              image: 'assets/icons/bookmark_ic.png',
                              isAssetImage: true,
                              height: 24.px,
                              width: 24.px,
                            ),
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
                                contentPadding: EdgeInsets.symmetric(vertical: 20.px, horizontal: 0),
                                hintText: 'Type to search...',
                                controller: controller.searchController,
                                // onChanged: (value) => controller.searchOnChange(value: value),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CW.commonGradiantDividerView(),
                  // loadingProgressBarView(controller:controller),
                  // SizedBox(height: 16.px),
                  if(controller.getLessonsData.isNotEmpty)
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10.px,mainAxisSpacing: 10.px),
                      itemCount: controller.getLessonsData.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 24.px,vertical: 16.px),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => controller.clickOnCard(context: context,index: index),
                          child: Stack(
                            children: [
                              CW.imageView(image: controller.getLessonsData[index].thumbnail ?? '',fit: BoxFit.cover, width: double.infinity,height: double.infinity),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Spacer(),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(8.px),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(16.px),
                                        bottomRight: Radius.circular(16.px),
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Theme.of(context).scaffoldBackgroundColor.withOpacity(.1),
                                          Theme.of(context).scaffoldBackgroundColor.withOpacity(.8),
                                        ],
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 24.px,
                                          width: 24.px,
                                          margin: EdgeInsets.only(right: 8.px),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.4),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                width: 1.px,
                                                color: Theme.of(context).scaffoldBackgroundColor,
                                              )
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.play_arrow,
                                              color: Theme.of(context).colorScheme.error,
                                              size: 12.px,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 4.px),
                                        Flexible(
                                          child: Text(
                                            controller.getLessonsData[index].title ?? '',
                                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 10.px
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
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

  Widget loadingProgressBarView({required LessonsController controller}) => Padding(
    padding: EdgeInsets.all(24.px),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20.px,
          width: 20.px,
          child: const GradientCircularProgressIndicator(),
        ),
        SizedBox(width: 12.px),
        Text(
          'Searching for “Emm”...',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    ),
  );


}
