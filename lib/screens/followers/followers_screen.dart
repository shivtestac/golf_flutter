import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cp/gradient_circular_progress_bar.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/screens/followers/followers_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FollowersScreen extends StatefulWidget {

  final String screenType;

  const FollowersScreen({super.key,required this.screenType});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var followersController = Provider.of<FollowersController>(context, listen: false);
    followersController.isSearchLoading = true;
    followersController.screenType=widget.screenType;
    followersController.initMethod();
  }

  @override
  void deactivate() {
    FollowersController followersController =
    Provider.of<FollowersController>(context);
    followersController.isSearchLoading = true;
    followersController.isInitCalled = false;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FollowersController>(
      builder: (context, FollowersController controller, child) {
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
                              SizedBox(width: 12.px),
                              Text(
                                widget.screenType,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.px,
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
                                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                                  contentPadding: EdgeInsets.symmetric(vertical: 20.px, horizontal: 0),
                                  hintText: 'Search Players',
                                  controller: controller.searchController,
                                  onChanged: (value) => controller.searchOnChange(query: value),
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
                            child: const GradientCircularProgressIndicator(),
                          ),
                          SizedBox(width: 12.px),
                          Text(
                            'Searching for “${controller.searchController.text}”...',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    )
                        :  Expanded(child:
                    widget.screenType=='Following'?
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.filteredFollowingList.length,
                      padding: EdgeInsets.all(24.px),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: 10.px,
                          ),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40.px,
                                width: 40.px,
                                margin: EdgeInsets.only(right: 8.px),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      controller.filteredFollowingList[index]
                                          .profilePhoto ??
                                          '',
                                    ),
                                  ),
                                ),
                                child: CW.imageView(
                                  image: controller
                                      .filteredFollowingList[index]
                                      .profilePhoto ??
                                      '',
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.filteredFollowingList[index]
                                          .name ??
                                          '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                        fontWeight:
                                        FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 4.px),
                                    Row(
                                      children: [
                                        /*if (controller.filteredList[
                                                                  index]
                                                              ['buttonName'] ==
                                                          'Joined' ||
                                                      controller.filteredList[
                                                                  index]
                                                              ['buttonName'] ==
                                                          'Join')*/
                                        Icon(
                                          Icons.star,
                                          size: 12.px,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                        ),
                                        Flexible(
                                          child: Text(
                                            ' ${controller.filteredFollowingList[index].handicap}',
                                            style: Theme.of(context)
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
                                onTap: () => controller.clickOnButton(
                                    index: index),
                                buttonText:  'Un Follow',
                                isBlackBg: false,
                              )
                            ],
                          ),
                        );
                      },
                    ):
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.filteredList.length,
                      padding: EdgeInsets.all(24.px),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: 10.px,
                          ),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40.px,
                                width: 40.px,
                                margin: EdgeInsets.only(right: 8.px),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      controller.filteredList[index]
                                          .profilePhoto ??
                                          '',
                                    ),
                                  ),
                                ),
                                child: CW.imageView(
                                  image: controller
                                      .filteredList[index]
                                      .profilePhoto ??
                                      '',
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.filteredList[index]
                                          .name ??
                                          '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                        fontWeight:
                                        FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 4.px),
                                    Row(
                                      children: [
                                        /*if (controller.filteredList[
                                                                  index]
                                                              ['buttonName'] ==
                                                          'Joined' ||
                                                      controller.filteredList[
                                                                  index]
                                                              ['buttonName'] ==
                                                          'Join')*/
                                        Icon(
                                          Icons.star,
                                          size: 12.px,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                        ),
                                        Flexible(
                                          child: Text(
                                            ' ${controller.filteredList[index].handicap}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        );
                      },
                    ),
                    )
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
