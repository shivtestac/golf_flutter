
import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/common/progress_bar.dart';
import 'package:golf_flutter/screens/forgot_password/forgot_password_controller.dart';

import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'otp_controller.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  @override
  void deactivate() {
    OtpController otpController =Provider.of<OtpController>(context);
    otpController.inAsyncCall = false;
    otpController.pinController.clear();
    super.deactivate();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var otpController = Provider.of<OtpController>(context);
    otpController.email=widget.email;
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<OtpController>(
      builder: (context, OtpController controller, child) {
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
                      'Enter OTP',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(color:Colors.white ),
                    ),
                    SizedBox(height: 24.px),
                    CW.commonOtpView(
                      context: context,
                      controller: controller.pinController,
                      onChanged: (value) => controller.onChangedUserField(value: value),
                    ),

                    SizedBox(height: 48.px),
                    const Spacer(),
                    CW.commonElevatedButtonView(
                        context: context,
                        buttonText: 'Verify',
                        isBlackBg: controller.pinController.text.trim().isEmpty ,
                        onTap: () => controller.clickOnVerifyButton(context: context),
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


}
