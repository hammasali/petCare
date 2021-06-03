import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_care/service/repo/firebase_repo.dart';


part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    try {
      if (event is AuthAppStartedEvent) {
        var isSignIn = await FirebaseRepo.instance.authSignIn();
        if (isSignIn) {
          User? user = FirebaseRepo.instance.getCurrentUser();
          yield (AuthenticateUser(user: user));
        } else
          yield (UnAuthenticateUser());
      }
    }on FirebaseAuthException catch (e) {
      yield UnAuthenticateUser();
    } catch (e){
      yield UnAuthenticateUser();
    }
  }
}
