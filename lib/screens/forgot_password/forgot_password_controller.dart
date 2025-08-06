import 'package:flutter/material.dart';
import 'package:golf_flutter/api/api_models/get_simple_model.dart';
import 'package:golf_flutter/common/cm.dart';
import 'package:golf_flutter/screens/otp/otp_screen.dart';

import '../../api/api_constants/api_key_constants.dart';
import '../../api/api_methods/api_methods.dart';
import '../../common/nm.dart';

class ForgotPasswordController extends ChangeNotifier {
  final emailController = TextEditingController();

  bool inAsyncCall = false;


  bool checkFormFieldIsEmptyOrNot() {
    return emailController.text.trim().isEmpty ;
  }



  Future<void> clickOnSendOtpButton({required BuildContext context}) async {
    if (!checkFormFieldIsEmptyOrNot()) {
      Map<String, dynamic> bodyParams = {
        ApiKeyConstants.email: emailController.text,
      };
      inAsyncCall = true;
      notifyListeners();
      SimpleModel? simpleModel = await ApiMethods.forgotPassword(bodyParams: bodyParams);
      if (simpleModel != null && simpleModel.status != null && simpleModel.status!) {
        CM.showMyToastMessage('OTP:  1234');
        NM.pushMethod(
            context: context, screen:  OtpScreen(email: emailController.text,),);
      }
    } else {
      CM.showMyToastMessage('Email is required!');
    }
    inAsyncCall = false;
    notifyListeners();
  }


  void onChangedUserField({required String value}) {
    notifyListeners();
  }



}
