part of 'pet_details_bloc.dart';

@immutable
abstract class PetDetailsState {}

class PetDetailsInitial extends PetDetailsState {}

class PetDetailsLoading extends PetDetailsState {}

class PetDetailsSuccessful extends PetDetailsState {}

class PetDetailsUnSuccessful extends PetDetailsState {
  final String? message;

  PetDetailsUnSuccessful(this.message);
}
