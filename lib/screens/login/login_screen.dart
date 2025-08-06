import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/common/progress_bar.dart';
import 'package:golf_flutter/screens/login/login_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void deactivate() {
    LoginController loginController =Provider.of<LoginController>(context);
    loginController.inAsyncCall = false;
    loginController.isPasswordVisible = false;
    loginController.inAsyncCall = false;
    loginController.passwordController.clear();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, LoginController controller, child) {
        return ProgressBar(
          inAsyncCall: controller.inAsyncCall,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black,
              body: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(24.px),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CW.imageView(
                          image: 'assets/img/red_img.png',
                          isAssetImage: true,
                          height: 48.px,
                          width: 100.px,
                          fit: BoxFit.fill,
                          borderRadius: BorderRadius.circular(0.px),
                        ),
                        SizedBox(height: 36.px),
                        Text(
                          'Log in to your account',
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(color:Colors.white),
                        ),
                        SizedBox(height: 24.px),
                        CW.commonTextFieldForLoginSignUP(
                          context: context,
                          hintText: 'Enter user id or email address',
                          labelText: 'Enter user id or email address',
                          controller: controller.userNameAndEmailController,
                          onChanged: (value) => controller.onChangedUserField(value: value),
                        ),
                        SizedBox(height: 16.px),
                        CW.commonTextFieldForLoginSignUP(
                          context: context,
                          hintText: 'Password',
                          labelText: 'Password',
                          controller: controller.passwordController,
                          obscureText: !controller.isPasswordVisible,
                          onChanged: (value) => controller.onChangedPasswordField(value: value),
                          suffixIcon:  GestureDetector(
                          onTap: () => controller.clickOnPasswordFieldEyeButton(),
                          child: SizedBox(
                           width: 18.px,
                           height: 14.px,
                           child: controller.isPasswordVisible
                           ? Icon(CupertinoIcons.eye_slash,size: 16.px,)
                           : Center(
                              child: CW.imageView(
                                image: 'assets/icons/open_eye_ic.png',
                                isAssetImage: true,
                                width: 18.px,
                                height: 14.px,
                              ),
                            ),
                          ),
                         ),
                        ),
                        SizedBox(height: 24.px),
                        CW.commonTextButtonView(
                          context: context,
                          buttonText: 'Forget Password?',
                          onTap: () => controller.clickOnForgetPasswordButton(),
                        ),
                        SizedBox(height: 48.px),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            commonButtonView(
                              imgPath: 'assets/icons/google_ic.png',
                              onTap: () => controller.clickOnGoogleButton(),
                            ),
                            SizedBox(width: 10.px),
                            commonButtonView(
                              imgPath: 'assets/icons/apple_ic.png',
                              onTap: () => controller.clickOnAppleButton(),
                            ),
                            // SizedBox(width: 10.px),
                            // commonButtonView(
                            //   imgPath: 'assets/icons/facebook_ic.png',
                            //   onTap: () => controller.clickOnFacebookButton(),
                            // ),
                            SizedBox(width: 16.px),
                            Expanded(
                              child: CW.commonElevatedButtonView(
                                  context: context,
                                  buttonText: 'Log In',
                                  isBlackBg: controller.userNameAndEmailController.text.trim().isEmpty || controller.passwordController.text.trim().isEmpty,
                                  onTap: () => controller.clickOnLogInButton(context: context),
                                  buttonTextColor: controller.userNameAndEmailController.text.trim()                                 .isEmpty || controller.passwordController.text.trim().isEmpty
                                      ? Theme.of(context).colorScheme.onSecondary
                                      : Theme.of(context).colorScheme.secondary),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.px),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '''Don't have any account?''',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w500,color: Colors.white),
                            ),
                            CW.commonTextButtonView(
                              context: context,
                              buttonText: 'Register Now',
                              onTap: () => controller.clickOnRegisterNowButton(context: context),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget commonButtonView({
    required String imgPath,
    required GestureTapCallback onTap,
  }) {
    return CW.commonElevatedButtonView(
      context: context,
      isBlackBg: true,
      width: 48.px,
      height: 48.px,
      onTap: onTap,
      buttonWidget: Center(
        child: CW.imageView(
          image: imgPath,
          isAssetImage: true,
          width: 24.px,
          height: 24.px,
        ),
      ),
    );
  }
}
