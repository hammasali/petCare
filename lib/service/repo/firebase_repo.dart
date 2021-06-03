import 'package:firebase_auth/firebase_auth.dart';
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
}
