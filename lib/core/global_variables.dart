import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Style {
  static TextStyle globalTextStyle =
      new TextStyle(fontWeight: FontWeight.w900, fontSize: 10.0);
}

class Utils {
  static String getUserName(String? name) => '${name!.split(' ')[0]}';

  static String emailUserName(String? name) => '${name!.split('@')[0]}';

  static String getHour(String? time) => '${time!.split(':')[0]}';
  static String getMin(String? time) => '${time!.split(':')[1]}';


}

class Arguments {
  final bool isNewer;

  Arguments(this.isNewer);
}

class AppointmentArguments {
  static String time = '9:00 am';
  static String name = '';
  static DateTime date = DateTime.now();
  static String profilePhoto = '';
}




