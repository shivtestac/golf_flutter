import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_flutter/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:golf_flutter/screens/forgot_password/forgot_password_screen.dart';
import 'package:golf_flutter/screens/login/login_screen.dart';
import 'package:golf_flutter/screens/sign_up/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api_constants/api_key_constants.dart';
import '../../api/api_methods/api_methods.dart';
import '../../api/api_models/get_simple_model.dart';
import '../../api/api_models/user_model.dart';
import '../../common/cm.dart';
import '../../common/nm.dart';

class ResetPasswordController extends ChangeNotifier {
  final cnfPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool inAsyncCall = false;
  String email='';


  bool checkFormFieldIsEmptyOrNot() {
    return passwordController.text.trim().isEmpty ||
        cnfPasswordController.text.trim().isEmpty;
  }



  Future<void> clickOnConfirmButton({required BuildContext context}) async {
    if (!checkFormFieldIsEmptyOrNot()) {
      Map<String, dynamic> bodyParams = {
        ApiKeyConstants.email: email,
        ApiKeyConstants.password:passwordController.text
      };
      inAsyncCall = true;
      notifyListeners();
      SimpleModel? simpleModel = await ApiMethods.resetPasswordApi(bodyParams: bodyParams);
      if (simpleModel != null && simpleModel.status != null && simpleModel.status!) {

        NM.pushAndRemoveUntilMethod(
          context: context, screen:  LoginScreen(),);
      }
    } else {
      CM.showMyToastMessage('All field are required!');
    }
    inAsyncCall = false;
    notifyListeners();
  }




  void onChangedUserField({required String value}) {
    notifyListeners();
  }

  void onChangedPasswordField({required String value}) {
    notifyListeners();
  }

  void clickOnPasswordFieldEyeButton() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }
}
