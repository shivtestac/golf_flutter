import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_flutter/api/api_models/get_notification_model.dart';
import 'package:golf_flutter/api/api_models/get_simple_model.dart';

import '../../api/api_methods/api_methods.dart';
import '../../common/cm.dart';

class NotificationController extends ChangeNotifier{
  bool isInitCalled = false;
  List<NotificationData> notificationList = [
     ];

  void clickOnBackButton({required BuildContext context}) {
    Navigator.pop(context);
  }

  Future<void> initMethod() async {
    if (!isInitCalled) {
      isInitCalled = true;
      NotificationModel? notificationModel = await ApiMethods.getNotifications();
      if (notificationModel != null &&
          notificationModel.data != null &&
          notificationModel.data!.isNotEmpty) {
        notificationList = notificationModel.data!;
        notifyListeners();
      }
    }
  }

  Future<void> readAllMessage()async{
    SimpleModel? simpleModel = await ApiMethods.readAllNotifications();
    if (simpleModel != null && simpleModel.status != null
        && simpleModel.status!) {
     CM.showMyToastMessage('All messages successfully read ....');
    }
  }

}