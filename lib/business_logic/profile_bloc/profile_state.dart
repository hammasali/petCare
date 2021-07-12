part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}

class ProfileSuccessfulState extends ProfileState {
  // User? user;
  //
  // ProfileSuccessfulState({this.user});
}

class ProfileUnSuccessfulState extends ProfileState {
  final String? message;

  ProfileUnSuccessfulState({this.message});
}