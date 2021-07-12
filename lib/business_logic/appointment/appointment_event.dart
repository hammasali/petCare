part of 'appointment_bloc.dart';

@immutable
abstract class AppointmentEvent {}

class AddAppointmentEvent extends AppointmentEvent {
  final String name, profilePic, time, date, uid;

  AddAppointmentEvent(
      {required this.name,
      required this.profilePic,
      required this.time,
      required this.date,
      required this.uid});
}

class UpdateAppointmentEvent extends AppointmentEvent {
  final String? date, time,uid;

  UpdateAppointmentEvent({this.date, this.time,this.uid});
}
