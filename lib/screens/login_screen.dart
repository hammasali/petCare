import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_care/business_logic/reg_bloc/reg_bloc.dart';
import 'package:pet_care/core/constants.dart';

import '../home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegBloc, RegState>(
      listener: (context, state) {
        if (state is RegSuccessfulState)
          Navigator.pushNamedAndRemoveUntil<dynamic>(
            context,
            HomeScreen.routeName,
            (route) => false, //if you want to disable back feature set to false
          );
        else if (state is RegUnsuccessfulState)
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message.toString().trim())));
      },
      child: Scaffold(
        backgroundColor: kDefaultBackgroundColor,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
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

                    //==================FACEBOOK BUTTON==========================
                    GestureDetector(
                      onTap: () => BlocProvider.of<RegBloc>(context)
                          .add(FacebookSignUpEvent()),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
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

                    //====================GOOGLE BUTTON==========================

                    GestureDetector(
                      onTap: () => BlocProvider.of<RegBloc>(context)
                          .add(GoogleSignUpEvent()),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
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

                    //===========================REGISTER========================
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/register_screen");
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: kDefaultPadding),
                        decoration: BoxDecoration(
                          color: kDefaultBackgroundColor,
                          border: Border.all(color: Colors.black45),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Center(
                          child: Text(
                            'Register with Email',
                            style: TextStyle(
                              color: Colors.black,
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
