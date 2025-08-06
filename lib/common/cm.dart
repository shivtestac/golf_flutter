import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../api/api_constants/api_key_constants.dart';
import 'package:http/http.dart' as http;

import 'package:geolocator/geolocator.dart';

class CM {
  static void unFocsKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<bool> internetConnectionCheckerMethod() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com/'));
      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  ///For Check Get Api Response
  static Future<bool> responseCheckForGetMethod({
    http.Response? response,
    bool wantSuccessToast = false,
    bool wantErrorToast = true,
  }) async {
    Map<String, dynamic> responseMap = jsonDecode(response?.body ?? "");
    if (response != null &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      return true;
    } else if (response != null && response.statusCode == 401) {
      return false;
    } else {
      return false;
    }
  }

  ///For Check Post Api Response
  static Future<bool> responseCheckForPostMethod(
      {http.Response? response, bool wantSnackBar = true}) async {
    Map<String, dynamic> responseMap = jsonDecode(response?.body ?? "");
    if (wantSnackBar) {
      if (responseMap[ApiKeyConstants.message] != null) {
        showMyToastMessage(responseMap[ApiKeyConstants.message]);
      }
      if (responseMap[ApiKeyConstants.error] != null) {
        showMyToastMessage(responseMap[ApiKeyConstants.error]);
      }
    }
    if (response != null &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      return true;
    } else if (response != null && response.statusCode == 401) {
      return false;
    } else {
      return false;
    }
  }

  static void showMyToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Future<Position?> getLatLong() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Error: Location services are disabled.');
        return null;
      }

      // Check and request location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Error: Location permissions are denied.');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print(
            'Error: Location permissions are permanently denied. Please enable them in settings.');
        return null;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return position;
    } on PermissionDeniedException {
      print('Error: Location permission is denied.');
      return null;
    } on LocationServiceDisabledException {
      print('Error: Location services are disabled.');
      return null;
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }
}
