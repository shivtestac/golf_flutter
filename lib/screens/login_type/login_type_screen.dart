import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/screens/login_type/login_type_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginTypeScreen extends StatefulWidget {
  const LoginTypeScreen({super.key});

  @override
  State<LoginTypeScreen> createState() => _LoginTypeScreenState();
}

class _LoginTypeScreenState extends State<LoginTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginTypeController>(
      builder: (context, LoginTypeController controller, child) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CW.imageView(
                  image: 'assets/img/login_img.png',
                  isAssetImage: true,
                  height: 484.px,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  borderRadius: BorderRadius.circular(0.px),
                ),
                Padding(
                  padding: EdgeInsets.all(24.px),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.px),
                      CW.commonElevatedButtonView(
                        context: context,
                        buttonText: 'Create an Account',
                        onTap: () => controller.clickOnCreateAnAccountButton(context: context),
                      ),
                      SizedBox(height: 16.px),
                      Row(
                        children: [
                          Expanded(
                            child: CW.commonGradiantDividerView(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.px),
                            child: Text(
                              'Or Continue With',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          Expanded(
                            child: CW.commonGradiantDividerView(),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.px),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          commonButtonView(
                            imgPath: 'assets/icons/google_ic.png',
                            onTap: () => controller.clickOnGoogleButton(context: context),
                          ),
                          SizedBox(width: 10.px),
                          commonButtonView(
                            imgPath: 'assets/icons/apple_ic.png',
                            onTap: () => controller.clickOnAppleButton(context: context),
                          ),
                          // SizedBox(width: 10.px),
                          // commonButtonView(
                          //   imgPath: 'assets/icons/facebook_ic.png',
                          //   onTap: () => controller.clickOnFacebookButton(context: context),
                          // ),
                          SizedBox(width: 10.px),
                        ],
                      ),
                      SizedBox(height: 40.px),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Already have an account?',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          CW.commonTextButtonView(
                            context: context,
                            buttonText: 'Log In',
                            onTap: () => controller.clickOnLogInButton(context: context),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
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
