import 'package:flutter/material.dart';
import 'package:pet_care/screens/login_screen.dart';
import 'package:pet_care/screens/register_screen.dart';
import 'package:pet_care/screens/signIn_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
};
