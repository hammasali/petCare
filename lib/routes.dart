import 'package:flutter/material.dart';
import 'package:pet_care/screens/login_screen.dart';
import 'package:pet_care/screens/register_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
};
