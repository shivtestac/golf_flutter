import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/screens/notification/notification_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../api/api_models/get_notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var notificationController = Provider.of<NotificationController>(context);
    notificationController.initMethod();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationController>(
      builder: (BuildContext context, NotificationController controller, Widget? child) {
        return Scaffold(
          appBar: appBarView(controller: controller),
          body: Column(
            children: [
              controller.notificationList.isNotEmpty?
              ListView.builder(
                padding: EdgeInsets.only(bottom: 20.px),
                itemCount: controller.notificationList.length,
                itemBuilder: (context, index) {
                  NotificationData item=controller.notificationList[index];
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.px),
                        child: Row(
                          children: [
                            Container(
                              height: 48.px,
                              width: 48.px,
                              margin: EdgeInsets.only(right: 14.px),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
              
                              ),
                              child: CW.imageView(
                                image: item.sender?.image?? '',
                                height: 32.px,
                                width: 32.px,
                                borderRadius: BorderRadius.circular(24.px),
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                     text: item.sender?.name,
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.w700,
                                       ),
                                       children: [
                                        TextSpan(
                                         text: 'is now ${item.type} you',
                                         style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                            fontSize: 14.px,
                                         ),
                                        ),
                                      ]
                                    ),
                                  ),
                                  SizedBox(height: 4.px),
                                  Text('${getTimeAgo(item.createdAt??'0')}',
                                    style: Theme.of(context).textTheme.labelLarge,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 12.px),
                      CW.commonGradiantDividerView(),
                      SizedBox(height: 12.px),
                    ],
                  );
                },
              ):
              Center(
                child: Padding(
                  padding:  EdgeInsets.only(top: 200),
                  child: Text('Notification not found ....', style: Theme.of(context).textTheme.displaySmall!.copyWith(color:Colors.white,fontSize: 24 ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  AppBar appBarView({required NotificationController controller}) => AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
          'Notifications',
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
        titleSpacing: -8.px,
        actions: [
          GestureDetector(
            onTap: (){
              controller.readAllMessage();
            },
            child: Text(
              'Mark all as read',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.error),
            ),
          ),
          SizedBox(width: 24.px),
        ],
      );


  String getTimeAgo(String createdAt) {
    final createdDate = DateTime.parse(createdAt).toLocal();
    final now = DateTime.now();
    final diff = now.difference(createdDate);

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} min ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hours ago';
    } else if (diff.inDays < 30) {
      return '${diff.inDays} days ago';
    } else {
      final months = (diff.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    }
  }
}
