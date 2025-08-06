
import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/common/progress_bar.dart';
import 'package:golf_flutter/screens/forgot_password/forgot_password_controller.dart';

import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  @override
  void deactivate() {
    ForgotPasswordController forgotPasswordController =Provider.of<ForgotPasswordController>(context);
    forgotPasswordController.inAsyncCall = false;
    forgotPasswordController.inAsyncCall = false;
    forgotPasswordController.emailController.clear();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordController>(
      builder: (context, ForgotPasswordController controller, child) {
        return ProgressBar(
          inAsyncCall: controller.inAsyncCall,
          child: SafeArea(
            child: Scaffold(
                backgroundColor: Colors.black ,
              body: Padding(
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
                      'Forgot Password',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(color:Colors.white ),
                    ),
                    SizedBox(height: 24.px),
                    CW.commonTextFieldForLoginSignUP(
                      context: context,
                      hintText: 'Enter email address',
                      labelText: 'Enter email address',
                      controller: controller.emailController,
                      onChanged: (value) => controller.onChangedUserField(value: value),
                    ),

                    SizedBox(height: 48.px),
                    const Spacer(),
                    CW.commonElevatedButtonView(
                        context: context,
                        buttonText: 'Send Otp',
                        isBlackBg: controller.emailController.text.trim().isEmpty ,
                        onTap: () => controller.clickOnSendOtpButton(context: context),
                        buttonTextColor: Theme.of(context).colorScheme.onSecondary),

                  ],
                ),
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
