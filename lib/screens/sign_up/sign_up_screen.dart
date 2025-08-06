import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/common/progress_bar.dart';
import 'package:golf_flutter/screens/sign_up/sign_up_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void deactivate() {
    SignUpController signUpController = Provider.of<SignUpController>(context);
    signUpController.inAsyncCall = false;
    signUpController.emailController.clear();
    signUpController.createUserNameController.clear();
    signUpController.fullNameController.clear();
    signUpController.dobController.clear();
    signUpController.passwordController.clear();
    signUpController.confirmPasswordController.clear();
    signUpController.isPasswordVisible = false;
    signUpController.isConfirmPasswordVisible = false;
    signUpController.termsAndConditionValue = false;
    signUpController.selectedGender = '';
    signUpController.selectedDate = null;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpController>(
      builder: (context, SignUpController controller, child) {
        return SafeArea(
          child: ProgressBar(
            inAsyncCall: controller.inAsyncCall,
            child: Scaffold(
              body: ListView(
                padding: EdgeInsets.all(24.px),
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: CW.imageView(
                      image: 'assets/img/red_img.png',
                      isAssetImage: true,
                      height: 48.px,
                      width: 100.px,
                      fit: BoxFit.fill,
                      borderRadius: BorderRadius.circular(0.px),
                    ),
                  ),
                  SizedBox(height: 36.px),
                  Text(
                    'Create account',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(height: 24.px),
                  CW.commonTextFieldForLoginSignUP(
                    context: context,
                    hintText: 'Enter email address',
                    labelText: 'Enter email address',
                    controller: controller.emailController,
                    onChanged: (value) =>
                        controller.onChangedEmailField(value: value),
                  ),
                  SizedBox(height: 16.px),
                  CW.commonTextFieldForLoginSignUP(
                    context: context,
                    hintText: 'Create username',
                    labelText: 'Create username',
                    controller: controller.createUserNameController,
                    onChanged: (value) =>
                        controller.onChangedCreateUserNameField(value: value),
                  ),
                  SizedBox(height: 16.px),
                  CW.commonTextFieldForLoginSignUP(
                    context: context,
                    hintText: 'Full name',
                    labelText: 'Full name',
                    controller: controller.fullNameController,
                    onChanged: (value) =>
                        controller.onChangedFullNameField(value: value),
                  ),
                  SizedBox(height: 16.px),
                  CW.commonTextFieldForLoginSignUP(
                    context: context,
                    hintText: 'Date of birth',
                    labelText: 'Date of birth',
                    controller: controller.dobController,
                    onChanged: (value) =>
                        controller.onChangedDOBField(value: value),
                    readOnly: true,
                    onTap: () => controller.clickOnDobTextFormFieldView(
                        context: context,
                        dobController: controller.dobController),
                    suffixIcon: SizedBox(
                      width: 18.px,
                      height: 14.px,
                      child: Center(
                        child: CW.imageView(
                          image: 'assets/icons/calendar_dob_ic.png',
                          isAssetImage: true,
                          width: 18.px,
                          height: 14.px,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.px),
                  CW.commonTextFieldForLoginSignUP(
                    context: context,
                    hintText: 'Create password',
                    labelText: 'Create password',
                    controller: controller.passwordController,
                    obscureText: !controller.isPasswordVisible,
                    onChanged: (value) =>
                        controller.onChangedPasswordField(value: value),
                    suffixIcon: GestureDetector(
                      onTap: () => controller.clickOnPasswordFieldEyeButton(),
                      child: SizedBox(
                        width: 18.px,
                        height: 14.px,
                        child: controller.isPasswordVisible
                            ? Icon(
                                CupertinoIcons.eye_slash,
                                size: 16.px,
                              )
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
                    controller: controller.confirmPasswordController,
                    obscureText: !controller.isConfirmPasswordVisible,
                    onChanged: (value) =>
                        controller.onChangedPasswordField(value: value),
                    suffixIcon: GestureDetector(
                      onTap: () =>
                          controller.clickOnConfirmPasswordFieldEyeButton(),
                      child: SizedBox(
                        width: 18.px,
                        height: 14.px,
                        child: controller.isConfirmPasswordVisible
                            ? Icon(
                                CupertinoIcons.eye_slash,
                                size: 16.px,
                              )
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
                  SizedBox(height: 18.px),
                  questionTextView(text: '''Select your gender'''),
                  SizedBox(height: 14.px),
                  GestureDetector(
                    onTap: () =>
                        controller.clickOnRadioButton(selectedValue: 'Male'),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        controller.commonCheckBoxView(
                            checkValue: controller.selectedGender == 'Male'),
                        SizedBox(width: 10.px),
                        Flexible(
                          child: Text(
                            'Male',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.px),
                  GestureDetector(
                    onTap: () =>
                        controller.clickOnRadioButton(selectedValue: 'Female'),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        controller.commonCheckBoxView(
                            checkValue: controller.selectedGender == 'Female'),
                        SizedBox(width: 10.px),
                        Flexible(
                          child: Text(
                            'Female',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.px),
                  GestureDetector(
                    onTap: () => controller.clickOnRadioButton(
                        selectedValue: 'Choose not to disclose'),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        controller.commonCheckBoxView(
                            checkValue: controller.selectedGender ==
                                'Choose not to disclose'),
                        SizedBox(width: 10.px),
                        Flexible(
                          child: Text(
                            'Choose not to disclose',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.px),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            controller.clickOnTermsAndConditionCheckBox(),
                        child: commonCheckBoxView(
                          checkValue: controller.termsAndConditionValue,
                        ),
                      ),
                      SizedBox(width: 10.px),
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                              text:
                                  'By creating a new account, you agree to the',
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                                TextSpan(
                                  text: '  Terms of Service',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                TextSpan(
                                  text: ' and ',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 48.px),
                  CW.commonElevatedButtonView(
                    context: context,
                    buttonText: 'Create Account',
                    isBlackBg: controller.checkFormFieldIsEmptyOrNot(),
                    onTap: () =>
                        controller.clickOnCreateAccountButton(context: context),
                    // buttonTextColor: controller.userNameAndEmailController.text.trim()                                 .isEmpty || controller.passwordController.text.trim().isEmpty
                    //  ? Theme.of(context).colorScheme.onSecondary
                    //  : Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(height: 24.px),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '''Already have an account?''',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      CW.commonTextButtonView(
                        context: context,
                        buttonText: 'Log In',
                        onTap: () =>
                            controller.clickOnLogInButton(context: context),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget commonCheckBoxView({required bool checkValue}) {
    return Container(
      height: 24.px,
      width: 24.px,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.px),
          border: Border.all(
            width: 1.px,
            color:
                checkValue ? const Color(0xffFF0023) : const Color(0xff2E2525),
          ),
          color: checkValue ? const Color(0xffB50005) : Colors.transparent),
      child: checkValue
          ? Center(
              child: CW.imageView(
                  image: 'assets/icons/check_ic.png',
                  isAssetImage: true,
                  height: 20.px,
                  width: 20.px),
            )
          : const SizedBox(),
    );
  }

  Widget questionTextView({required String text}) => Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.w700),
      );
}
