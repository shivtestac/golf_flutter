import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golf_flutter/api/api_constants/api_key_constants.dart';
import 'package:golf_flutter/api/api_constants/api_url_constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class CW {
  static Widget commonElevatedButtonView({
    GestureTapCallback? onTap,
    double? height,
    double? width,
    bool isBlackBg = false,
    String? buttonText,
    double? buttonTextFontSize,
    Widget? buttonWidget,
    required BuildContext context,
    Color? buttonTextColor,
    double? borderRadius,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 48.px,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.px),
          image: DecorationImage(
            image: AssetImage(
              isBlackBg
                  ? 'assets/background_img/black_button_bg.png'
                  : 'assets/background_img/red_button_bg.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: buttonWidget ??
              Text(
                buttonText ?? '',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: buttonTextFontSize,
                      color: buttonTextColor,
                    ),
              ),
        ),
      ),
    );
  }

  static Widget commonTextButtonView(
      {GestureTapCallback? onTap,
      double? height,
      double? width,
      bool isBlackBg = false,
      required String buttonText,
      double? buttonTextFontSize,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: buttonTextFontSize,
              color: Theme.of(context).colorScheme.error,
            ),
      ),
    );
  }

  static Widget commonTextFieldForLoginSignUP({
    double? elevation,
    String? hintText,
    String? labelText,
    String? errorText,
    String? title,
    TextStyle? titleStyle,
    EdgeInsetsGeometry? contentPadding,
    TextEditingController? controller,
    int? maxLines,
    double? cursorHeight,
    bool wantBorder = false,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    Color? fillColor,
    Color? initialBorderColor,
    double? initialBorderWidth,
    TextInputType? keyboardType,
    double? borderRadius,
    double? height,
    double? maxHeight,
    TextStyle? hintStyle,
    TextStyle? style,
    TextStyle? labelStyle,
    TextStyle? errorStyle,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool autofocus = false,
    bool readOnly = false,
    bool hintTextColor = false,
    Widget? suffixIcon,
    Widget? prefixIcon,
    AutovalidateMode? autoValidateMode,
    int? maxLength,
    GestureTapCallback? onTap,
    bool obscureText = false,
    FocusNode? focusNode,
    MaxLengthEnforcement? maxLengthEnforcement,
    bool? filled,
    bool isCard = false,
    bool isBorder = true,
    required BuildContext context,
  }) {
    return Container(
      height: height,
      margin: EdgeInsets.all(1.4.px),
      decoration: BoxDecoration(
        color: const Color(0xff0D0808),
        borderRadius: BorderRadius.circular(borderRadius ?? 6.px),
      ),
      child: TextFormField(
        focusNode: focusNode,
        maxLengthEnforcement: maxLengthEnforcement,
        obscureText: obscureText,
        onTap: onTap,
        maxLength: maxLength,
        cursorHeight: cursorHeight,
        cursorColor: Theme.of(context).primaryColor,
        autovalidateMode: autoValidateMode,
        controller: controller,
        onChanged: onChanged ??
            (value) {
              value = value.trim();
              if (value.isEmpty || value.replaceAll(" ", "").isEmpty) {
                controller?.text = "";
              }
            },
        validator: validator,
        keyboardType: keyboardType ?? TextInputType.streetAddress,
        readOnly: readOnly,
        autofocus: autofocus,
        inputFormatters: inputFormatters,
        textCapitalization: textCapitalization,
        style: style ??
            Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w400, fontSize: 14.px,
            color: Colors.white),
        decoration: InputDecoration(
          contentPadding: contentPadding,
          errorText: errorText,
          counterText: '',
          errorStyle: errorStyle ??
              Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.error),
          hintText: hintText,
          labelText: labelText,
          labelStyle: labelStyle ?? Theme.of(context).textTheme.titleMedium,
          fillColor: fillColor ?? const Color(0xff2E2525),
          filled: filled ?? false,
          hintStyle: hintStyle ?? Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white54),
          disabledBorder: isBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.px),
                  borderSide: BorderSide(
                    color: const Color(0xff2E2525),
                    width: 1.px,
                  ),
                )
              : InputBorder.none,
          border: isBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.px),
                  borderSide: BorderSide(
                    color: const Color(0xff2E2525),
                    width: 1.px,
                  ),
                )
              : InputBorder.none,
          errorBorder: isBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.px),
                  borderSide: BorderSide(
                    color: const Color(0xff2E2525),
                    width: 1.px,
                  ),
                )
              : InputBorder.none,
          enabledBorder: isBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.px),
                  borderSide: BorderSide(
                    color: const Color(0xff2E2525),
                    width: 1.px,
                  ),
                )
              : InputBorder.none,
          focusedErrorBorder: isBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.px),
                  borderSide: BorderSide(
                    color: const Color(0xff2E2525),
                    width: 1.px,
                  ),
                )
              : InputBorder.none,
          focusedBorder: isBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.px),
                  borderSide: BorderSide(
                    color: const Color(0xff2E2525),
                    width: 1.px,
                  ),
                )
              : InputBorder.none,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }

  static Widget commonOtpView({
    required BuildContext context,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    PinCodeFieldShape? shape,
    TextInputType keyboardType = TextInputType.number,
    List<TextInputFormatter>? inputFormatters,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onCompleted,
    int length = 4,
    double? height,
    double? width,
    double? borderRadius,
    double? borderWidth,
    bool readOnly = false,
    bool autoFocus = false,
    bool enableActiveFill = true,
    bool enablePinAutofill = true,
    bool autoDismissKeyboard = true,
    TextStyle? textStyle,
    Color? cursorColor,
    Color? inactiveColor,
    Color? inactiveFillColor,
    Color? activeColor,
    Color? activeFillColor,
    Color? selectedColor,
    Color? selectedFillColor,
  }) =>
      PinCodeTextField(
        length: length,
        mainAxisAlignment: mainAxisAlignment,
        appContext:context,
        cursorColor: cursorColor ?? Theme.of(context).primaryColor,
        autoFocus: autoFocus,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters ??
            <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
        readOnly: readOnly,
        textStyle: textStyle ??
            Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w400, fontSize: 14.px,
                color: Colors.white),
        autoDisposeControllers: false,
        enabled: true,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          inactiveColor: Colors.grey.withOpacity(0.8),
          inactiveFillColor: Colors.transparent,
          activeColor: Colors.grey.withOpacity(0.8),
          activeFillColor: Colors.transparent,
          selectedColor: Theme.of(context).primaryColor,
          selectedFillColor: Colors.transparent,
          shape: shape ?? PinCodeFieldShape.box,
          fieldWidth: width ?? 45.px,
          fieldHeight: height ?? 45.px,
          borderWidth: borderWidth ?? 1.px,
          borderRadius: BorderRadius.circular(
            borderRadius ?? 12.px,
          ),
        ),
        enableActiveFill: enableActiveFill,
        controller: controller,
        onChanged: onChanged,
        enablePinAutofill: enablePinAutofill,
        onCompleted: onCompleted,
        autoDismissKeyboard: autoDismissKeyboard,
      );

  static imageView({
    double? width,
    double? height,
    double? radius,
    required String image,
    String? defaultNetworkImage,
    BoxFit? fit,
    BorderRadiusGeometry? borderRadius,
    bool isAssetImage = false,
    Color? color,
  }) {
    if (isAssetImage) {
      return SizedBox(
        height: height ?? double.infinity,
        width: width ?? double.infinity,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 8.px),
          child: Image.asset(
            image,
            fit: fit ?? BoxFit.contain,
            height: height ?? double.infinity,
            width: width ?? double.infinity,
            color: color,
          ),
        ),
      );
    } else {
      return SizedBox(
        height: height ?? 64.px,
        width: width ?? double.infinity,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 8.px),
          child: CachedNetworkImage(
            imageUrl: ApiUrlConstants.baseUrlForImages + image,
            fit: fit ?? BoxFit.cover,
            errorWidget: (context, error, stackTrace) {
              return Container(
                height: height ?? 64.px,
                width: width ?? double.infinity,
                color: Theme.of(context)
                    .colorScheme
                    .onSecondary
                    .withOpacity(.2.px),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius ?? 8.px),
                    child: Image.network(
                      'https://media.istockphoto.com/id/1396814518/vector/image-coming-soon-no-photo-no-thumbnail-image-available-vector-illustration.jpg?s=612x612&w=0&k=20&c=hnh2OZgQGhf0b46-J2z7aHbIWwq8HNlSDaNp2wn_iko=',
                      fit: BoxFit.cover,
                    )),
              );
            },
            progressIndicatorBuilder: (context, url, downloadProgress) {
              return SizedBox(
                height: height ?? 64.px,
                width: width ?? double.infinity,
                child: Shimmer.fromColors(
                  baseColor: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(.4.px),
                  highlightColor: Theme.of(context).colorScheme.onSecondary,
                  child: Container(
                    color: Theme.of(context)
                        .colorScheme
                        .onSecondary
                        .withOpacity(.4.px),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }

  static Widget commonGradiantDividerView({
    double? height,
    double? width,
  }) {
    return Container(
      height: height ?? 1.px,
      width: width ?? double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff1A0F0F),
            Color(0xff332929),
            Color(0xff1A0F0F),
          ],
        ),
      ),
    );
  }

  static Widget commonBlackCardView(
      {required BuildContext context,
      required Widget widget,
      GestureTapCallback? onTap,
      double? height,
      double? width,
      double? borderWidth,
      double? borderRadius,
      EdgeInsetsGeometry? padding,
      Color? borderColor,
      bool isBlackBg = true,
      bool isGradient = true,
      Color? cardColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          color: cardColor,
          gradient: isGradient
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    if (isBlackBg) const Color(0xff1A1717),
                    if (isBlackBg) const Color(0xff080606),
                    if (!isBlackBg) const Color(0xffFF0023),
                    if (!isBlackBg) const Color(0xffB50005),
                  ],
                )
              : LinearGradient(
                  colors: [
                    cardColor ?? Colors.transparent,
                    cardColor ?? Colors.transparent,
                  ],
                ),
          borderRadius: BorderRadius.circular(borderRadius ?? 8.px),
          border: Border.all(
            color: borderColor ?? Theme.of(context).colorScheme.onSecondary,
            width: borderWidth ?? .5.px,
          ),
        ),
        child: widget,
      ),
    );
  }

  static Widget commonSwitchButton({
    required BuildContext context,
    required bool value,
    required ValueChanged<bool> onChanged,
    double? width,
    double? height,
  }) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: width ?? 40.px,
        height: height ?? 24.px,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular((height ?? 24.px) / 2),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  if (!value) const Color(0xff2E2525),
                  if (!value) const Color(0xff141010),
                  if (value) const Color(0xffFF0023),
                  if (value) const Color(0xffB50005),
                ])),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(4.px),
                child: Container(
                  width: 16.px,
                  height: 16.px,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: value
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
