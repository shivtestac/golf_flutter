import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/common/progress_bar.dart';
import 'package:golf_flutter/screens/login/login_controller.dart';
import 'package:golf_flutter/screens/reset_password/reset_password_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  @override
  void deactivate() {
    ResetPasswordController resetPasswordController =Provider.of<ResetPasswordController>(context);
    resetPasswordController.inAsyncCall = false;
    resetPasswordController.isPasswordVisible = false;
    resetPasswordController.passwordController.clear();
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var resetPassword = Provider.of<ResetPasswordController>(context);
    resetPassword.email=widget.email;
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ResetPasswordController>(
      builder: (context, ResetPasswordController controller, child) {
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
                          'Enter New Password',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white),
                        ),
                        SizedBox(height: 24.px),
                        CW.commonTextFieldForLoginSignUP(
                          context: context,
                          hintText: 'New password',
                          labelText: 'New password',
                          controller: controller.passwordController,
                          obscureText: !controller.isPasswordVisible,
                          onChanged: (value) => controller.onChangedUserField(value: value),
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
                        SizedBox(height: 16.px),
                        CW.commonTextFieldForLoginSignUP(
                          context: context,
                          hintText: 'Confirm password',
                          labelText: 'Confirm password',
                          controller: controller.cnfPasswordController,
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
                        SizedBox(height: 70.px),
                        CW.commonElevatedButtonView(
                            context: context,
                            buttonText: 'Confirm',
                            isBlackBg: controller.passwordController.text.trim().isEmpty || controller.cnfPasswordController.text.trim().isEmpty,
                            onTap: () => controller.clickOnConfirmButton(context: context),
                            buttonTextColor: controller.cnfPasswordController.text.trim() .isEmpty || controller.passwordController.text.trim().isEmpty
                                ? Theme.of(context).colorScheme.onSecondary
                                : Theme.of(context).colorScheme.onSecondary),
                        SizedBox(height: 24.px),

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

}
