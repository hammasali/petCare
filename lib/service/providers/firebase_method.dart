import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pet_care/service/model/appointment.dart';
import 'package:pet_care/service/model/chat_model.dart';
import 'package:pet_care/service/model/pet_details_model.dart';
import 'package:pet_care/service/model/user_info_model.dart';

class FirebaseMethod {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //==============================Authentication State====================

  Future<bool> isSignedIn() async => _firebaseAuth.currentUser != null;

  User? getCurrentUser() => _firebaseAuth.currentUser;

  Future<void> resetPassword(String email) async =>
      await _firebaseAuth.sendPasswordResetEmail(email: email);

  Future<bool> authenticateNewUser(String? email) async {
    final result = await Future.value(
        _firestore.collection('users').where('email', isEqualTo: email).get());

    return result.docs.isEmpty ? true : false;
  }

  //===========================Registration ================================

  Future<User?> createUser(String email, String password) async {
    var result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return result.user;
  }

  Future<UserCredential> signUpWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    print('This is credential $credential');
    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<UserCredential?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      // Create a credential from the access token
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }

  //==========================Sign In========================================

  Future<User?> signInUser(String email, String password) async {
    var result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return result.user;
  }

  //==========================Sign out=======================================
  Future<void> signOutUser() async => await FirebaseAuth.instance.signOut();

//================Add Authenticated Data To DB=============================
  Future<void> addNewUserData(var model) async => await _firestore
      .collection('users')
      .doc(getCurrentUser()!.uid)
      .set(model);

  Future<void> updateUserData(UserInfoModel userInfoModel) async {
    if (userInfoModel.file!.path == null) {
      await _firestore
          .collection('users')
          .doc(getCurrentUser()!.uid)
          .update(userInfoModel.toMap());
    } else {
      // Create your custom metadata.
      // Pass metadata to any file upload method e.g putFile.
      firebase_storage.SettableMetadata metadata =
          firebase_storage.SettableMetadata(
        customMetadata: <String, String>{
          'userId': getCurrentUser()!.uid,
        },
      );
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('profile/${getCurrentUser()!.uid}')
          .putFile(File(userInfoModel.file!.path), metadata)
          .whenComplete(() async => await _firestore
              .collection('users')
              .doc(getCurrentUser()!.uid)
              .update(userInfoModel.toMapFile()));
    }
  }

  Future<void> addPetDetails(PetDetailsModel petDetailsModel) async {
    //TODO: REMOVE DOC NAME 'PET DATA' IF MORE PETS TO ADD

    if (petDetailsModel.file == null) {
      await _firestore
          .collection('users')
          .doc(getCurrentUser()!.uid)
          .collection('pet')
          .doc('petData')
          .set(petDetailsModel.toMap());
    } else {
      // Create your custom metadata.
      // Pass metadata to any file upload method e.g putFile.
      firebase_storage.SettableMetadata metadata =
          firebase_storage.SettableMetadata(
        customMetadata: <String, String>{
          'userId': getCurrentUser()!.uid,
        },
      );
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('petPhoto/${getCurrentUser()!.uid}')
          .putFile(File(petDetailsModel.file!.path), metadata)
          .whenComplete(() async => await _firestore
              .collection('users')
              .doc(getCurrentUser()!.uid)
              .collection('pet')
              .doc('petData')
              .set(petDetailsModel.toMap()));
    }
  }

  DocumentReference getPetDetails() => _firestore
      .collection('users')
      .doc(getCurrentUser()!.uid)
      .collection('pet')
      .doc('petData');

  Future<void> addAppointment(AppointmentModel _appointment) async {
    print(_appointment.profilePhoto);
    Uint8List file = await _getImageFileFromAssets(_appointment.profilePhoto);
    print("FILE NAME $file");

    // Create your custom metadata.
    // Pass metadata to any file upload method e.g putFile.
    firebase_storage.SettableMetadata metadata =
        firebase_storage.SettableMetadata(
      customMetadata: <String, String>{
        'userId': getCurrentUser()!.uid,
      },
    );

    //TODO: TO DYNAMICALLY ADD MORE APPOINTMENTS REMOVE DOC.
    //For the uniqueness I add Profile Photo from assets in doc.
    await firebase_storage.FirebaseStorage.instance
        .ref('appointments/${getCurrentUser()!.uid}')
        .child(_appointment.profilePhoto)
        .putData(file)
        .whenComplete(() async => await _firestore
            .collection('users')
            .doc(getCurrentUser()!.uid)
            .collection('appointments')
            .doc(_appointment.uid)
            .set(_appointment.toMap()));
  }

  Future<void> updateAppointment(AppointmentUpdateModel updateModel) async =>
      await _firestore
          .collection('users')
          .doc(getCurrentUser()!.uid)
          .collection('appointments')
          .doc(updateModel.uid)
          .update(updateModel.toMap());

  Query getAppointment() => _firestore
      .collection('users')
      .doc(getCurrentUser()!.uid)
      .collection('appointments');

  Query getRecommendedDogs() {
    String? breed;
    _firestore
        .collection('users')
        .doc(getCurrentUser()!.uid)
        .collection('pet')
        .doc('petData')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        breed = data['breed'];
        print('This is breed: $breed');
        print('Document exists on the database');
      }
    });
    // return _firestore
    //     .collection('users')
    //     .doc(getCurrentUser()!.uid)
    //     .collection('pet')
    //     .where('breed', isEqualTo: breed);

    return breed == null
        ? _firestore.collectionGroup('pet')
        : _firestore.collectionGroup('pet').where('breed', isEqualTo: breed);
  }

  Future<String> downloadURL(String id) async {
    var downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('petPhoto/$id')
        .getDownloadURL()
        .catchError((onError) {
      print(onError);
    });

    return downloadURL;
  }


  // ========================== MESSAGES ===============
  Future<void> addMessageToDB(
      String? message, String? receiverId, String? name) async {
    //TODO: Just a dummy text message remove later
    //TODO: Add the screen to invite button and submit button
    //TODO: and let the user send message

    String _currentUser = getCurrentUser()!.uid;
    Timestamp _timestamp = Timestamp.now();
    String _time = DateFormat('h:mm a').format(DateTime.now());

    ChatModel chatModel = ChatModel(
        name: name,
        time: _time,
        timestamp: _timestamp,
        message: message,
        receiverId: receiverId,
        senderId: _currentUser);

    /// ================= ADDING TO CHAT ROOM =================
    await _firestore
        .collection('chats')
        .doc(_currentUser)
        .collection('chatUsers')
        .doc(receiverId)
        .set(chatModel.toMap())
        .then((value) => _firestore
            .collection('chats')
            .doc(receiverId)
            .collection('chatUsers')
            .doc(_currentUser)
            .set(chatModel.toMap()));

    ///  ================  ADDING MESSAGE TO DB  ================

    await _firestore
        .collection('chats')
        .doc(_currentUser)
        .collection(receiverId!)
        .add(chatModel.toMap())
        .then((value) => _firestore
            .collection('chats')
            .doc(receiverId)
            .collection(_currentUser)
            .add(chatModel.toMap()));
  }

  Query fetchUserChatRoom() => _firestore
      .collection('chats')
      .doc(getCurrentUser()!.uid)
      .collection('chatUsers')
      .orderBy('timestamp', descending: true);

  Query fetchUserChat(String? uid) => _firestore
      .collection('chats')
      .doc(getCurrentUser()!.uid)
      .collection(uid!)
      .orderBy('timestamp');

  Future<Uint8List> _getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load(path);
    return byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    // await file.writeAsBytes(byteData.buffer
    //     .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    //return file;
  }
}
