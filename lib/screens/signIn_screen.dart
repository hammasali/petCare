import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_care/constants.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = "/signIn_screen";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: kDefaultPadding,
            right: kDefaultPadding,
            top: kDefaultPadding * 2,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Icon(
                    FontAwesomeIcons.arrowLeft,
                    size: 24,
                  ),
                ),
                SizedBox(height: kDefaultPadding * 3),
                Padding(
                  padding: EdgeInsets.only(left: kDefaultPadding / 2),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                    ),
                  ),
                ),
                SizedBox(height: kDefaultPadding * 2),
                Container(
                  padding: EdgeInsets.all(kDefaultPadding * 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 14,
                          ),
                          labelText: 'Email',
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 14,
                          ),
                          labelText: 'Password',
                        ),
                      ),
                      SizedBox(height: kDefaultPadding - 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              print("Tapped");
                            },
                            child: Text(
                              "Do not remember the password?",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: kDefaultPadding * 2),
                      GestureDetector(
                        onTap: () {
                          print('Tapped');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: kDefaultPadding * 0.8),
                          decoration: BoxDecoration(
                            color: Color(0xFF000000),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: kDefaultPadding * 4),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Or continue with'),
                      SizedBox(height: kDefaultPadding),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.facebook,
                              size: 48,
                              color: Colors.blue,
                            ),
                            SizedBox(width: kDefaultPadding * 2),
                            Icon(
                              FontAwesomeIcons.google,
                              size: 45,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: kDefaultPadding * 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have account yet? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/register_screen");
                            },
                            child: Text(
                              'Registration',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
