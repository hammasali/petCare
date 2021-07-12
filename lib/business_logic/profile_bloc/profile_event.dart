part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String name, email, phone, description, gender;
  final PickedFile? file;

  UpdateProfileEvent(
      {required this.name,
      required this.email,
      required this.phone,
      required this.gender,
      required this.description,
      this.file});
}
