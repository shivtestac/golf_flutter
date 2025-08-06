import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_flutter/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:golf_flutter/screens/forgot_password/forgot_password_screen.dart';
import 'package:golf_flutter/screens/sign_up/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api_constants/api_key_constants.dart';
import '../../api/api_methods/api_methods.dart';
import '../../api/api_models/user_model.dart';
import '../../common/cm.dart';
import '../../common/nm.dart';

class LoginController extends ChangeNotifier {
  final userNameAndEmailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool inAsyncCall = false;

  void clickOnGoogleButton() {}

  void clickOnAppleButton() {}

  void clickOnFacebookButton() {}

  bool checkFormFieldIsEmptyOrNot() {
    return passwordController.text.trim().isEmpty ||
        userNameAndEmailController.text.trim().isEmpty;
  }

  Future<void> clickOnLogInButton({required BuildContext context}) async {
    if (!checkFormFieldIsEmptyOrNot()) {
      Map<String, dynamic> bodyParams = {
        ApiKeyConstants.email: userNameAndEmailController.text,
        ApiKeyConstants.password: passwordController.text,
      };
      inAsyncCall = true;
      notifyListeners();
      UserModel? userModel = await ApiMethods.login(bodyParams: bodyParams);
      if (userModel != null && userModel.data != null) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.clear();
        sharedPreferences.setString(
            ApiKeyConstants.token, userModel.data!.token ?? '');
        sharedPreferences.setString(
            ApiKeyConstants.email, userModel.data?.email ?? "");
        sharedPreferences.setString(
            ApiKeyConstants.name, userModel.data?.name ?? "");
        sharedPreferences.setString(
            ApiKeyConstants.username, userModel.data?.username ?? "");
        sharedPreferences.setString(
            ApiKeyConstants.gender, userModel.data?.gender ?? "");
        sharedPreferences.setString(
            ApiKeyConstants.dob, userModel.data?.dob ?? "");
        NM.pushAndRemoveUntilMethod(
            context: context, screen: const BottomBarScreen());
      }
    } else {
      CM.showMyToastMessage('All field required!');
    }
    inAsyncCall = false;
    notifyListeners();
  }

  void clickOnRegisterNowButton({required BuildContext context}) {
    NM.pushMethod(context: context, screen: const SignUpScreen());
  }

  void clickOnForgetPasswordButton() {
    NM.pushMethod(context: Get.context!, screen: const ForgotPasswordScreen());
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
