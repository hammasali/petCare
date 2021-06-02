import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_care/constants.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "/register_screen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isAgreeWitRules = false;
  bool _isNewsLetter = false;
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
                    'Registration',
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
                          labelText: 'Full name',
                        ),
                      ),
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
                      SizedBox(height: kDefaultPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                              value: _isAgreeWitRules,
                              onChanged: (value) {
                                setState(() {
                                  _isAgreeWitRules = !_isAgreeWitRules;
                                });
                              }),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: 'I agree with ',
                                ),
                                TextSpan(
                                  text: 'the rules',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                              value: _isNewsLetter,
                              onChanged: (value) {
                                setState(() {
                                  _isNewsLetter = !_isNewsLetter;
                                });
                              }),
                          Text('I do not want to receive newsletter'),
                        ],
                      ),
                      SizedBox(height: kDefaultPadding),
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
                  margin: EdgeInsets.only(top: kDefaultPadding),
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
                              size: 32,
                              color: Colors.blue,
                            ),
                            SizedBox(width: kDefaultPadding * 2),
                            Icon(
                              FontAwesomeIcons.google,
                              size: 29,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: kDefaultPadding * 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/signIn_screen");
                            },
                            child: Text(
                              'Sign In',
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
