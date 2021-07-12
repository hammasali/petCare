part of 'appointment_bloc.dart';

@immutable
abstract class AppointmentState {}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentSuccess extends AppointmentState {}

class AppointmentUnSuccess extends AppointmentState {
  final String message;

  AppointmentUnSuccess(this.message);
}
