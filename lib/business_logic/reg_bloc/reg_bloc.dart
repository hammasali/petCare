import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:pet_care/service/repo/firebase_repo.dart';

part 'reg_event.dart';

part 'reg_state.dart';

class RegBloc extends Bloc<RegEvent, RegState> {
  RegBloc() : super(RegInitial());

  @override
  Stream<RegState> mapEventToState(
    RegEvent event,
  ) async* {
    try {
      //======================SIGNUP EVENT============================
      if (event is SignUpButtonPressedEvent) {
        yield RegLoadingState();

        var user =
            await FirebaseRepo.instance.createUser(event.email, event.password);

        yield RegSuccessfulState(user: user);
      }

      //======================SIGNIN EVENT============================
      else if (event is SignInButtonPressedEvent) {
        yield RegLoadingState();

        var user =
            await FirebaseRepo.instance.signInUser(event.email, event.password);

        yield RegSuccessfulState(user: user);
      }

      //=====================GOOGLE SIGNUP EVENT=======================
      else if (event is GoogleSignUpEvent) {
        yield RegLoadingState();

        var userCredential = await FirebaseRepo.instance.signUpWithGoogle();

        if (userCredential.user != null) {
          yield RegSuccessfulState(user: userCredential.user);
        }
      }

      //=====================FACEBOOK SIGNUP EVENT=======================
      else if (event is FacebookSignUpEvent) {
        yield RegLoadingState();

        UserCredential? userCredential =
            await FirebaseRepo.instance.signInWithFacebook();

        if (userCredential!.user != null) {
          yield RegSuccessfulState(user: userCredential.user);
        }
      }

      //=====================FORGET PASSWORD EVENT=======================
      else if (event is ForgetPasswordButtonPressedEvent) {
        yield RegLoadingState();

        await FirebaseRepo.instance
            .resetPassword(event.email)
            .whenComplete(() => throw 'Check your email to reset the password');
      }
    }

    //==================Errors=======================
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        yield RegUnsuccessfulState(
            message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        yield RegUnsuccessfulState(
            message: 'The account already exists for that email.');
      } else if (e.code == 'user-not-found') {
        yield RegUnsuccessfulState(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        yield RegUnsuccessfulState(
            message: 'Wrong password provided for that user.');
      } else if (e.message == 'Given String is empty or null')
        yield RegUnsuccessfulState(message: 'Please provide credentials');
      else
        yield RegUnsuccessfulState(message: e.code);
    } on PlatformException catch (e) {
      yield RegUnsuccessfulState(message: e.code);
    } on String catch (e) {
      yield RegUnsuccessfulState(message: e);
    } catch (e) {
      yield RegUnsuccessfulState(message: e.toString());
    }
  }
}
