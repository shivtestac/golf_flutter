

import 'package:flutter/material.dart';
import 'package:golf_flutter/screens/reset_password/reset_password_screen.dart';

import '../../api/api_constants/api_key_constants.dart';
import '../../api/api_methods/api_methods.dart';
import '../../api/api_models/get_simple_model.dart';
import '../../common/cm.dart';
import '../../common/nm.dart';

class OtpController extends ChangeNotifier {
  final pinController = TextEditingController();

  bool inAsyncCall = false;
  String email='';

  bool checkFormFieldIsEmptyOrNot() {
    return pinController.text.trim().isEmpty ;
  }


  Future<void> clickOnVerifyButton({required BuildContext context}) async {
    if (!checkFormFieldIsEmptyOrNot()) {
      Map<String, dynamic> bodyParams = {
        ApiKeyConstants.email: email,
        ApiKeyConstants.otp:pinController.text
      };
      inAsyncCall = true;
      notifyListeners();
      SimpleModel? simpleModel = await ApiMethods.verifyOtpApi(bodyParams: bodyParams);
      if (simpleModel != null && simpleModel.status != null && simpleModel.status!) {

        NM.pushMethod(
          context: context, screen:  ResetPasswordScreen(email:email,),);
      }
    } else {
      CM.showMyToastMessage('Otp  is required!');
    }
    inAsyncCall = false;
    notifyListeners();
  }


  void onChangedUserField({required String value}) {
    notifyListeners();
  }



}
