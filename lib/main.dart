import 'package:flutter/material.dart';
import 'package:pet_care/routes.dart';
import 'package:pet_care/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      routes: routes,
      initialRoute: LoginScreen.routeName,
    );
  }
}
