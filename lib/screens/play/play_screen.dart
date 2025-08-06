import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/screens/play/play_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayController>(
      builder: (context, PlayController controller, child) {
        return Scaffold(
          body: Stack(
            children: [
              CW.imageView(
                image: 'assets/background_img/image_play_bg.png',
                isAssetImage: true,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.px),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.px),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CW.imageView(
                              image: 'assets/img/red_play_img.png',
                              isAssetImage: true,
                              height: 28.px,
                              width: 100.px,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.px),
                      ListView.builder(
                        itemCount: controller.listOfItems.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: 8.px),
                          child: GestureDetector(
                            onTap: () => controller.clickOnCard(
                                index: index, context: context),
                            child: CW.commonBlackCardView(
                              context: context,
                              width: double.infinity,
                              borderRadius: 16.px,
                              widget: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.px,
                                  horizontal: 16.px,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CW.imageView(
                                      image: controller.listOfItems[index]['image'] ?? '',
                                      isAssetImage: true,
                                      height: 68.px,
                                      width: 68.px,
                                    ),
                                    SizedBox(width: 12.px),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.listOfItems[index]
                                                    ['title'] ??
                                                '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16.px),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 2.px),
                                          Text(
                                            controller.listOfItems[index]
                                                    ['sub'] ??
                                                '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.px),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 12.px),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Theme.of(context).primaryColor,
                                      size: 14.px,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.px),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
