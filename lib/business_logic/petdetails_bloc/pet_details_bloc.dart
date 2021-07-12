import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:pet_care/service/model/pet_details_model.dart';
import 'package:pet_care/service/repo/firebase_repo.dart';

part 'pet_details_event.dart';
part 'pet_details_state.dart';

class PetDetailsBloc extends Bloc<PetDetailsEvent, PetDetailsState> {
  PetDetailsBloc() : super(PetDetailsInitial());

  @override
  Stream<PetDetailsState> mapEventToState(
    PetDetailsEvent event,
  ) async* {

    try{
      if(event is AddPetDetailsEvent){
        yield PetDetailsLoading();
        await FirebaseRepo.instance
            .addPetDetails(event.petDetailsModel)
            .whenComplete(() => emit(PetDetailsSuccessful()));

      }
    } on PlatformException catch (e) {
      print(e.toString());
      emit(PetDetailsUnSuccessful(e.message));
    } on FirebaseException catch (e) {
      emit(PetDetailsUnSuccessful(e.message));
    }
  }
}
