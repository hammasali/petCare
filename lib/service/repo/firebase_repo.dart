import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_care/service/model/appointment.dart';
import 'package:pet_care/service/model/pet_details_model.dart';
import 'package:pet_care/service/providers/firebase_method.dart';

class FirebaseRepo {
  static final FirebaseRepo instance = FirebaseRepo._instance();

  FirebaseRepo._instance();

  FirebaseMethod _firebaseMethod = FirebaseMethod();

  Future<bool> authSignIn() async => await _firebaseMethod.isSignedIn();

  Future<void> resetPassword(String email) async =>
      await _firebaseMethod.resetPassword(email);

  User? getCurrentUser() => _firebaseMethod.getCurrentUser();

  Future<User?> createUser(String email, String password) async =>
      await _firebaseMethod.createUser(email, password);

  Future<void> signOutUser() async => await _firebaseMethod.signOutUser();

  Future<UserCredential> signUpWithGoogle() async =>
      await _firebaseMethod.signUpWithGoogle();

  Future<UserCredential?> signInWithFacebook() async =>
      await _firebaseMethod.signInWithFacebook();

  Future<User?> signInUser(String email, String password) async =>
      await _firebaseMethod.signInUser(email, password);

  Future<void> addNewUserData(var model) async =>
      await _firebaseMethod.addNewUserData(model);

  Future<void> updateUserData(var model) async =>
      await _firebaseMethod.updateUserData(model);

  Future<bool> authenticateNewUser(String? email) async =>
      await _firebaseMethod.authenticateNewUser(email);

  Future<void> addPetDetails(PetDetailsModel petDetailsModel) async =>
      await _firebaseMethod.addPetDetails(petDetailsModel);

  Future<void> addAppointment(AppointmentModel _appointment) async =>
      await _firebaseMethod.addAppointment(_appointment);

  Future<void> updateAppointment(AppointmentUpdateModel updateModel) async =>
      await _firebaseMethod.updateAppointment(updateModel);

  Query getAppointment() => _firebaseMethod.getAppointment();

  Query getRecommendedDogs() => _firebaseMethod.getRecommendedDogs();

  Future<String> downloadURL(String id) async =>
      _firebaseMethod.downloadURL(id);

  DocumentReference getPetDetails() => _firebaseMethod.getPetDetails();

  Future<void> addMessageToDB(
          {String? message, String? receiverId, String? name}) async =>
      _firebaseMethod.addMessageToDB(message, receiverId, name);

  Query fetchUserChatRoom() => _firebaseMethod.fetchUserChatRoom();

  Query fetchUserChat(String? uid) => _firebaseMethod.fetchUserChat(uid);

}
