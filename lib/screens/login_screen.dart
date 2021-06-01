import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_care/constants.dart';
import 'package:pet_care/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 38.0,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'Welcome \nto ',
                    ),
                    TextSpan(
                      style: TextStyle(
                        color: Color(0xFF4379DD),
                      ),
                      text: 'Pet Care',
                    ),
                  ],
                ),
              ),
              SizedBox(height: kDefaultPadding * 3),
              GestureDetector(
                onTap: () {
                  print('Tapped');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  decoration: BoxDecoration(
                    color: Color(0xFF000000),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.facebookF,
                          color: Color(0xFF5764D6),
                          size: 24,
                        ),
                        SizedBox(
                          width: kDefaultPadding,
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Color(0xFFebebeb),
                            ),
                            children: [
                              TextSpan(
                                text: 'Continue with ',
                              ),
                              TextSpan(
                                text: 'Facebook',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding * 2),
              GestureDetector(
                onTap: () {
                  print('Tapped');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  decoration: BoxDecoration(
                    color: Color(0xFF000000),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.google,
                          color: Color(0xFFF7392E),
                          size: 24,
                        ),
                        SizedBox(
                          width: kDefaultPadding,
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Color(0xFFebebeb),
                            ),
                            children: [
                              TextSpan(
                                text: 'Continue with ',
                              ),
                              TextSpan(
                                text: 'Google',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding * 3),
              GestureDetector(
                onTap: () {
                  print('Tapped');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                  decoration: BoxDecoration(
                    color: Color(0xFFA73131),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Center(
                    child: Text(
                      'Register with Email',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding * 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? '),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
