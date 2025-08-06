import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cp/gradient_circular_progress_bar.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/screens/search/search_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchDiscoverController>(
      builder: (context, SearchDiscoverController controller, child) {
        return Scaffold(
          appBar: AppBar(
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
          ),
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
                      Text(
                        'Discover',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 20.px),
                      ),
                      SizedBox(height: 6.px),
                      Text(
                        'Connected to some golfers and get inspired.',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
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
                              hintText: 'Type to search...',
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
                    : Expanded(
                        child: controller.filteredList.isEmpty &&
                                controller.searchController.text
                                    .trim()
                                    .isNotEmpty
                            ? Center(
                                child: Text(
                                  'Data not found!',
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                              )
                            : ListView.builder(
                                itemCount: controller.filteredList.length,
                                padding: EdgeInsets.all(24.px),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: index !=
                                              controller.searchUserData.length -
                                                  1
                                          ? 24.px
                                          : 0.px,
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
                                                controller.searchUserData[index]
                                                        .profilePhoto ??
                                                    '',
                                              ),
                                            ),
                                          ),
                                          child: CW.imageView(
                                            image: controller
                                                    .searchUserData[index]
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
                                                controller.searchUserData[index]
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
                                        CW.commonElevatedButtonView(
                                          context: context,
                                          height: 32.px,
                                          width: 88.px,
                                          buttonTextFontSize: 12.px,
                                          onTap: () => controller.clickOnButton(
                                              index: index),
                                          buttonText: controller
                                                      .filteredList[index]
                                                      .isFollowing ??
                                                  false
                                              ? 'Following'
                                              : 'Follow',
                                          isBlackBg: controller
                                                  .filteredList[index]
                                                  .isFollowing ??
                                              false,
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
