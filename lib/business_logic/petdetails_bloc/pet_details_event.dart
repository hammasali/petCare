part of 'pet_details_bloc.dart';

@immutable
abstract class PetDetailsEvent {}

class AddPetDetailsEvent extends PetDetailsEvent {
  final PetDetailsModel petDetailsModel;

  AddPetDetailsEvent(this.petDetailsModel);
}
