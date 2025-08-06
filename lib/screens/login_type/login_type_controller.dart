import 'package:flutter/material.dart';
import 'package:golf_flutter/common/nm.dart';
import 'package:golf_flutter/screens/login/login_screen.dart';
import 'package:golf_flutter/screens/sign_up/sign_up_screen.dart';

class LoginTypeController extends ChangeNotifier {
  void clickOnCreateAnAccountButton({required BuildContext context}) {
    NM.pushAndRemoveUntilMethod(context: context, screen: const SignUpScreen());
  }

  void clickOnGoogleButton({required BuildContext context}) {
    //NM.pushAndRemoveUntilMethod(context: context, screen: const YourDispersionScreen());
  }

  void clickOnAppleButton({required BuildContext context}) {
    clickOnGoogleButton(context: context);
  }

  void clickOnFacebookButton({required BuildContext context}) {
    clickOnGoogleButton(context: context);
  }

  void clickOnLogInButton({required BuildContext context}) {
    NM.pushAndRemoveUntilMethod(context: context, screen: const LoginScreen());
  }
}
