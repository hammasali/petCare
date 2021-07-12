import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_care/business_logic/reg_bloc/reg_bloc.dart';
import 'package:pet_care/core/constants.dart';
import 'package:pet_care/core/global_variables.dart';
import 'package:pet_care/screens/main_screen/bottomNavTab.dart';
import 'package:pet_care/screens/main_screen/search/home.dart';
import 'package:pet_care/screens/auth_screens/register_screen.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = "/signIn_screen";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _email, _password;

  bool _isValidEmail = false;
  bool _isValidPassword = false;
  bool _isForgetPasswordPressed = false;

  @override
  void initState() {
    _email = '';
    _password = '';
    super.initState();
  }

  bool validatePassword(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  String get _invalidPass => ' 1 Upper case, 1 lowercase, 1 digit';

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
                  onTap: () => Navigator.pop(context),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            bool check = EmailValidator.validate(value);
                            setState(() {
                              _isValidEmail = check;
                            });
                          },
                          onSaved: (value) {
                            _email = value!;
                          },
                          validator: (value) =>
                              (value!.trim().isEmpty || !_isValidEmail)
                                  ? 'Invalid email'
                                  : null,
                          decoration: InputDecoration(
                            suffixIcon: _isValidEmail
                                ? Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 14,
                                  )
                                : null,
                            labelText: 'Email',
                          ),
                        ),

                        //=======================PASSWORD FIELD===================
                        Visibility(
                          visible: !_isForgetPasswordPressed,
                          child: TextFormField(
                            onChanged: (value) {
                              bool check = validatePassword(value);
                              setState(() {
                                _isValidPassword = check;
                              });
                            },
                            onSaved: (value) {
                              _password = value!;
                            },
                            validator: (value) =>
                                (value!.trim().isEmpty || !_isValidPassword)
                                    ? _invalidPass
                                    : null,
                            obscureText: true,
                            decoration: InputDecoration(
                              suffixIcon: _isValidPassword
                                  ? Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 14,
                                    )
                                  : null,
                              labelText: 'Password',
                            ),
                          ),
                        ),
                        SizedBox(height: kDefaultPadding - 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //===================FORGET PASSWORD================
                            Visibility(
                              visible: !_isForgetPasswordPressed,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isForgetPasswordPressed = true;
                                  });
                                },
                                child: Text(
                                  "Do not remember the password?",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: kDefaultPadding * 2),

                        //========================BLOC==========================

                        BlocConsumer<RegBloc, RegState>(
                            builder: (context, state) {
                          if (state is RegLoadingState)
                            return Padding(
                              padding: const EdgeInsets.all(kDefaultPadding),
                              child: CircularProgressIndicator.adaptive(
                                strokeWidth: 1.1,
                              ),
                            );

                          return Container();
                        }, listener: (context, state) {
                          if (state is RegSuccessfulState)
                            Navigator.pushNamedAndRemoveUntil<dynamic>(
                              context,
                              BottomNavBar.routeName,
                                  (route) => false,
                              arguments: Arguments(
                                  false), //if you want to disable back feature set to false
                            );
                          else if (state is RegUnsuccessfulState)
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(state.message.toString())));
                        }),

                        //======================SIGNIN BUTTON===================

                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              _isForgetPasswordPressed
                                  ? BlocProvider.of<RegBloc>(context).add(
                                      ForgetPasswordButtonPressedEvent(
                                          email: _email.trim()))
                                  : BlocProvider.of<RegBloc>(context).add(
                                      SignInButtonPressedEvent(
                                          email: _email, password: _password));
                            }
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
                                _isForgetPasswordPressed ? 'Verify' : 'Sign In',
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
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.facebook,
                                size: 48,
                                color: Colors.blue,
                              ),
                              onPressed: () => BlocProvider.of<RegBloc>(context)
                                  .add(FacebookSignUpEvent()),
                            ),
                            SizedBox(width: kDefaultPadding * 2),
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.google,
                                size: 45,
                                color: Colors.red,
                              ),
                              onPressed: () => BlocProvider.of<RegBloc>(context)
                                  .add(GoogleSignUpEvent()),
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
                              Navigator.pushNamed(
                                  context, RegisterScreen.routeName);
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

