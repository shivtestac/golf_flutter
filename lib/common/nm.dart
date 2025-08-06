import 'package:flutter/material.dart';

class NM {
  static pushAndRemoveUntilMethod(
      {required BuildContext context, required Widget screen}) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    ); // This removes all previous routes
  }

  static pushMethod({required BuildContext context, required Widget screen}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static pushReplacementMethod(
      {required BuildContext context, required Widget screen}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static popMethod({required BuildContext context}) {
    Navigator.pop(context);
  }
}
