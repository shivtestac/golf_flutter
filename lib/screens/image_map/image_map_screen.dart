import 'dart:math';
import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cm.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../common/cw.dart';
import 'image_map_controller.dart';

class ImageMapScreen extends StatefulWidget {
  const ImageMapScreen({super.key});

  @override
  State<ImageMapScreen> createState() => _ImageMapScreenState();
}

class _ImageMapScreenState extends State<ImageMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ImageMapController>(
      builder: (context, ImageMapController controller, child) {
        return Scaffold(
          appBar: AppBar(
            leadingWidth: 76.px,
            leading: GestureDetector(
              onTap: () => controller.clickOnBackButton(context: context),
              child: Center(
                child: CW.imageView(
                  image: 'assets/dummy_img/04 Play at course (1).png',
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
          body: Stack(
            children: [
              CW.imageView(
                image: 'assets/dummy_img/04 Play at course (1).png',
                isAssetImage: true,
                height: double.infinity,
                width: double.infinity,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ],
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
