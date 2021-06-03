part of 'reg_bloc.dart';

abstract class RegState {}

class RegInitial extends RegState {}

class RegLoadingState extends RegState {}

class RegSuccessfulState extends RegState {
  User? user;

  RegSuccessfulState({this.user});
}

class RegUnsuccessfulState extends RegState {
  String? message;

  RegUnsuccessfulState({this.message});
}
