import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api_constants/api_key_constants.dart';
import '../../api/api_methods/api_methods.dart';
import '../../api/api_models/user_model.dart';
import '../../common/alert_dialog_view.dart';
import '../../common/app_singleton.dart';
import '../../common/cm.dart';
import '../../common/image_pick_and_crop.dart';
import '../../common/nm.dart';

class UpdateProfileController extends ChangeNotifier {
  final emailController = TextEditingController();
  final createUserNameController = TextEditingController();
  final fullNameController = TextEditingController();
  final dobController = TextEditingController();
  bool inAsyncCall = false;
  String selectedGender = '';
  DateTime? selectedDate;

  File? image;

  UserData? data;
  bool isInitCalled = false; // A flag to track if initMethod is called

  Future<void> initMethod() async {
    if (!isInitCalled) {
      isInitCalled = true;
      UserModel? userModel = await ApiMethods.getIn();
      if (userModel != null && userModel.data != null) {
        data = userModel.data!;
        emailController.text = data?.email ?? "";
        createUserNameController.text = data?.username ?? '';
        fullNameController.text = data?.name ?? '';
        dobController.text = data?.dob ?? '';
        selectedGender = data?.gender ?? '';
        AppSingleton.instance.userData = data;
        notifyListeners();
      }
    }
  }

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

  Future<void> clickOnUpdateProfileButton(
      {required BuildContext context}) async {
    if (!checkFormFieldIsEmptyOrNot()) {
      Map<String, dynamic> bodyParams = {
        ApiKeyConstants.email: emailController.text,
        ApiKeyConstants.name: fullNameController.text,
        ApiKeyConstants.username: createUserNameController.text,
        ApiKeyConstants.dob: dobController.text,
        ApiKeyConstants.gender: selectedGender,
      };
      Map<String, File>? imageMap;
      if (image != null && image!.path.isNotEmpty) {
        imageMap = {
          ApiKeyConstants.profileImage: image!,
        };
      }
      inAsyncCall = true;
      notifyListeners();
      UserModel? userModel =
          await ApiMethods.editUser(bodyParams: bodyParams, imageMap: imageMap);
      if (userModel != null && userModel.data != null) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
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
        AppSingleton.instance.userData = data;
        notifyListeners();
        NM.popMethod(context: context);
        isInitCalled = false; // A flag to track if initMethod is called
        initMethod();
      }
    } else {
      CM.showMyToastMessage('All field required!');
    }
    inAsyncCall = false;
    notifyListeners();
  }

  bool checkFormFieldIsEmptyOrNot() {
    return emailController.text.trim().isEmpty ||
        createUserNameController.text.trim().isEmpty ||
        fullNameController.text.trim().isEmpty ||
        dobController.text.trim().isEmpty ||
        selectedGender.isEmpty;
  }

  clickOnUploadButton({required BuildContext context}) {
    showAlertDialog();
  }

  void showAlertDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return MyAlertDialog(
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: cameraTextButtonView(),
              onPressed: () => clickCameraTextButtonView(),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: galleryTextButtonView(),
              onPressed: () => clickGalleryTextButtonView(),
            ),
          ],
          title: selectImageTextView(),
          content: contentTextView(),
        );
      },
    );
  }

  Widget selectImageTextView() => const Text("Select Image");

  Widget contentTextView() => const Text('Choose Image From The Options Below');

  Widget cameraTextButtonView() => const Text("Camera");

  Widget galleryTextButtonView() => const Text("Gallery");

  Future<void> clickGalleryTextButtonView() async {
    pickGallery();
    Get.back();
  }

  Future<void> clickCameraTextButtonView() async {
    pickCamera();
    Get.back();
  }

  Future<void> pickCamera() async {
    image = await ImagePickerAndCropper.pickImage(
      context: Get.context!,
      wantCropper: true,
      color: Theme.of(Get.context!).scaffoldBackgroundColor,
    );
    notifyListeners();
  }

  Future<void> pickGallery() async {
    image = await ImagePickerAndCropper.pickImage(
      pickImageFromGallery: true,
      context: Get.context!,
      wantCropper: true,
      color: Theme.of(Get.context!).scaffoldBackgroundColor,
    );
    notifyListeners();
  }

  void clickOnBackButton({required BuildContext context}) {
    NM.popMethod(context: context);
  }
}
