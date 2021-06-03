part of 'reg_bloc.dart';

abstract class RegEvent {}

class SignUpButtonPressedEvent extends RegEvent {
  String name, email, password;

  SignUpButtonPressedEvent(
      {required this.name, required this.email, required this.password});
}

class SignInButtonPressedEvent extends RegEvent {
  String email, password;

  SignInButtonPressedEvent({required this.email, required this.password});
}

class ForgetPasswordButtonPressedEvent extends RegEvent {
  String email;

  ForgetPasswordButtonPressedEvent({required this.email});
}

class GoogleSignUpEvent extends RegEvent {}

class FacebookSignUpEvent extends RegEvent {}
