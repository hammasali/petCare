import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:pet_care/core/shared_prefrences.dart';
import 'package:pet_care/service/model/user_info_model.dart';
import 'package:pet_care/service/repo/firebase_repo.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    try {
      if (event is UpdateProfileEvent) {
        yield ProfileLoading();

        UserInfoModel _userInfoModel;
        if (event.file!.path == null)
          _userInfoModel = UserInfoModel(
              name: event.name,
              email: event.email,
              phoneNo: event.phone,
              description: event.description,
              gender: event.gender);
        else
          _userInfoModel = UserInfoModel.file(
              name: event.name,
              email: event.email,
              phoneNo: event.phone,
              description: event.description,
              gender: event.gender,
              file: event.file);

        await FirebaseRepo.instance
            .updateUserData(_userInfoModel)
            .whenComplete(() {
          SharedPref.saveToPreferences(SharedPref.USERNAME, event.name);
          SharedPref.saveToPreferences(SharedPref.EMAIL, event.email);
          SharedPref.saveToPreferences(SharedPref.PHONE, event.phone);
          SharedPref.saveToPreferences(
              SharedPref.DESCRIPTION, event.description);
          SharedPref.saveToPreferences(SharedPref.GENDER, event.gender);

          emit(ProfileSuccessfulState());
        });
      }
    } on PlatformException catch (e) {
      print(e.toString());
      yield ProfileUnSuccessfulState(message: e.message.toString());
    } on FirebaseException catch (e) {
      yield ProfileUnSuccessfulState(message: e.message.toString());
    }
  }
}
