import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String IMAGE = "IMAGE_KEY";
  static const String PETIMAGE = "PETIMAGE_KEY";
  static const String NAME = "name";
  static const String USERNAME = "userName";
  static const String EMAIL = "userEmail";
  static const String PHONE = "userPhone";
  static const String DESCRIPTION = "userDescription";
  static const String GENDER = "userGender";

  static Future<void> saveToPreferences(String key, String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value!);
  }

  // static String getToPreferences(String value) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(value);
  // }

  static Future<dynamic> getImageFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(IMAGE);
  }

  static Future<dynamic> getPetImageFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PETIMAGE);
  }

  static Image imageFromBase64String(String? base64String) {
    return Image.memory(
      base64Decode(base64String!),
      //fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
