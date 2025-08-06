import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/common/progress_bar.dart';
import 'package:golf_flutter/screens/update_profile/update_profile_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../common/app_singleton.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var updateProfileController = Provider.of<UpdateProfileController>(context);
    updateProfileController.initMethod();
  }

  @override
  void deactivate() {
    UpdateProfileController updateProfileController =
        Provider.of<UpdateProfileController>(context);
    updateProfileController.inAsyncCall = false;
    updateProfileController.emailController.clear();
    updateProfileController.createUserNameController.clear();
    updateProfileController.fullNameController.clear();
    updateProfileController.dobController.clear();
    updateProfileController.selectedGender = '';
    updateProfileController.selectedDate = null;
    updateProfileController.isInitCalled = false;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateProfileController>(
      builder: (context, UpdateProfileController controller, child) {
        return SafeArea(
          child: ProgressBar(
            inAsyncCall: controller.inAsyncCall,
            child: Scaffold(
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: () => controller.clickOnBackButton(context: context),
                  child: Center(
                    child: CW.imageView(
                      image: 'assets/icons/left_arrow_ic.png',
                      isAssetImage: true,
                      height: 24.px,
                      width: 24.px,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              body: ListView(
                padding: EdgeInsets.all(24.px),
                children: [
                  SizedBox(height: 24.px),
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        controller.image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50.px),
                                child: Image.file(
                                  controller.image!,
                                  height: 100.px,
                                  width: 100.px,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : CW.imageView(
                                image: AppSingleton
                                        .instance.userData?.profilePhoto ??
                                    '',
                                height: 100.px,
                                width: 100.px,
                                fit: BoxFit.cover,
                                borderRadius: BorderRadius.circular(50.px),
                              ),
                        GestureDetector(
                          onTap: () =>
                              controller.clickOnUploadButton(context: context),
                          child: Container(
                            padding: EdgeInsets.all(2.px),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.px),
                              border: Border.all(color: Colors.white),
                            ),
                            child: CW.imageView(
                              image: 'assets/icons/edit_ic.png',
                              isAssetImage: true,
                              height: 20.px,
                              width: 20.px,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                  SizedBox(height: 48.px),
                  CW.commonElevatedButtonView(
                    context: context,
                    buttonText: 'Update Profile',
                    isBlackBg: controller.checkFormFieldIsEmptyOrNot(),
                    onTap: () =>
                        controller.clickOnUpdateProfileButton(context: context),
                  ),
                  SizedBox(height: 24.px),
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
