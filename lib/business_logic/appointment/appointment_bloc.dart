import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:pet_care/service/model/appointment.dart';
import 'package:pet_care/service/repo/firebase_repo.dart';

part 'appointment_event.dart';

part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc() : super(AppointmentInitial());

  @override
  Stream<AppointmentState> mapEventToState(
    AppointmentEvent event,
  ) async* {
    try {
      if (event is AddAppointmentEvent) {
        yield AppointmentLoading();
        AppointmentModel _appointment = AppointmentModel(
            uid: event.uid,
            name: event.name,
            profilePhoto: event.profilePic,
            time: event.time,
            data: event.date);

        FirebaseRepo.instance
            .addAppointment(_appointment)
            .whenComplete(() => emit(AppointmentSuccess()));
      } else if (event is UpdateAppointmentEvent) {
        yield AppointmentLoading();

        AppointmentUpdateModel _appointment;
        if (event.date == null) {
          _appointment = AppointmentUpdateModel(
            time: event.time,
            uid: event.uid,
          );
        } else {
          _appointment = AppointmentUpdateModel(
            data: event.date,
            time: event.time,
            uid: event.uid,
          );
        }

        FirebaseRepo.instance
            .updateAppointment(_appointment)
            .whenComplete(() => emit(AppointmentSuccess()));
      }
    } on PlatformException catch (e) {
      print(e.toString());
      yield AppointmentUnSuccess(e.message.toString());
    } on FirebaseException catch (e) {
      yield AppointmentUnSuccess(e.message.toString());
    } catch (e) {
      yield AppointmentUnSuccess(e.toString());
    }
  }
}
