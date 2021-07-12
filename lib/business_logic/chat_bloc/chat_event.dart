part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String? message, uid, name;

  SendMessageEvent({this.message, this.uid, this.name});
}
