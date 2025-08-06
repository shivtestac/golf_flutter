import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_flutter/screens/login/login_screen.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api_constants/api_key_constants.dart';
import '../../api/api_methods/api_methods.dart';
import '../../api/api_models/user_model.dart';
import '../../common/cm.dart';
import '../../common/nm.dart';
import '../your_dispersion/your_dispersion_screen.dart';

class SignUpController extends ChangeNotifier {
  final emailController = TextEditingController();
  final createUserNameController = TextEditingController();
  final fullNameController = TextEditingController();
  final dobController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool termsAndConditionValue = false;
  bool inAsyncCall = false;
  String selectedGender = '';
  DateTime? selectedDate;


  void onChangedEmailField({required String value}) {}

  void onChangedCreateUserNameField({required String value}) {}

  void onChangedFullNameField({required String value}) {}

  void onChangedDOBField({required String value}) {}

  // void clickOnDobTextFormFieldView({required BuildContext context}) {
  //   DatePickerView().datePickerView(
  //     color: Theme.of(context).colorScheme.primary,
  //     context: context,
  //   );
  // }


  clickOnRadioButton({required String selectedValue}) {
    selectedGender = selectedValue;
    notifyListeners();
  }

  void clickOnDobTextFormFieldView({
    required BuildContext context,
    required TextEditingController dobController,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                  color: const Color(0xff2E2525),
                  blurRadius: 1.px,
                  spreadRadius: 1.px)
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.px),
              topRight: Radius.circular(20.px),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16.px, top: 8.px),
                    child: TextButton(
                      onPressed: () {
                        if (selectedDate != null) {
                          dobController.text =
                              DateFormat('yyyy-MM-dd').format(selectedDate!);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.px,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16.px, top: 8.px),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Close",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.px,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        fontSize: 18.px,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: selectedDate ?? DateTime.now(),
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (DateTime newDate) {
                      selectedDate = newDate;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void onChangedPasswordField({required String value}) {}

  Widget commonCheckBoxView({required bool checkValue}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 16.px,
          width: 16.px,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.px),
              border: Border.all(
                width: 1.px,
                color: checkValue
                    ? const Color(0xffFF0023)
                    : const Color(0xff2E2525),
              ),
              color: checkValue ? const Color(0xffB50005) : Colors.transparent),
          /*child: checkValue
              ? Center(
            child: CW.imageView(
                image: 'assets/icons/check_ic.png',
                isAssetImage: true,
                height: 16.px,
                width: 16.px
            ),
          )
              : const SizedBox(),*/
        ),
      ],
    );
  }

  void clickOnPasswordFieldEyeButton() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void clickOnConfirmPasswordFieldEyeButton() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }

  Future<void> clickOnCreateAccountButton(
      {required BuildContext context}) async {
    if (!checkFormFieldIsEmptyOrNot()) {
      if (passwordController.text == confirmPasswordController.text) {
        Map<String, dynamic> bodyParams = {
          ApiKeyConstants.email: emailController.text,
          ApiKeyConstants.name: fullNameController.text,
          ApiKeyConstants.password: passwordController.text,
          ApiKeyConstants.username: createUserNameController.text,
          ApiKeyConstants.dob: dobController.text,
          ApiKeyConstants.gender: selectedGender,
        };
        inAsyncCall = true;
        notifyListeners();
        UserModel? userModel =
            await ApiMethods.register(bodyParams: bodyParams);
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
              context: context, screen: const YourDispersionScreen());
        }
      } else {
        CM.showMyToastMessage('Password mismatch!');
      }
    } else {
      CM.showMyToastMessage('All field required!');
    }
    inAsyncCall = false;
    notifyListeners();
  }

  void clickOnTermsAndConditionCheckBox() {
    termsAndConditionValue = !termsAndConditionValue;
    notifyListeners();
  }

  bool checkFormFieldIsEmptyOrNot() {
    return emailController.text.trim().isEmpty ||
        createUserNameController.text.trim().isEmpty ||
        fullNameController.text.trim().isEmpty ||
        dobController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty ||
        selectedGender.isEmpty ||
        !termsAndConditionValue;
  }

  void clickOnLogInButton({required BuildContext context}) {
    NM.pushAndRemoveUntilMethod(context: context, screen: const LoginScreen());
  }
}
