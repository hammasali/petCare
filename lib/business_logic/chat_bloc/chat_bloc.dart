import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:pet_care/service/repo/firebase_repo.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial());

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    try {
      if (event is SendMessageEvent) {
        yield ChatLoading();
        await FirebaseRepo.instance
            .addMessageToDB(
                message: event.message, receiverId: event.uid, name: event.name)
            .whenComplete(() => emit(ChatSuccessful()));
      }
    } on PlatformException catch (e) {
      print(e.toString());
      emit(ChatUnSuccessful(e.message));
    } on FirebaseException catch (e) {
      emit(ChatUnSuccessful(e.message));
    }
  }
}
