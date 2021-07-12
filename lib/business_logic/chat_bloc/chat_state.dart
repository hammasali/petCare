part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState{}

class ChatSuccessful extends ChatState{}

class ChatUnSuccessful extends ChatState{
  final String? message;

  ChatUnSuccessful(this.message);
}
