import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_link/repositories/firestore_repository.dart';
import 'package:life_link/utils/collection_names.dart';
import 'package:life_link/utils/exceptions.dart';
import 'package:life_link/utils/strings.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signUp(
    String email,
    String password,
  ) async {
    UserCredential? userCredential;
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.emailInUse) {
        throw EmailAlreadyExistException('Email already in use');
      } else {
        throw UnknownException('${AppStrings.wentWrong}${e.code} ${e.message}');
      }
    }
    return userCredential;
  }

  Future<UserCredential?> signIn(
    String email,
    String password,
  ) async {
    UserCredential? userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' ||
          e.code == 'user-not-found' ||
          e.code == 'invalid-credential') {
        throw IncorrectPasswordOrUserNotFound(AppStrings.enteredWrongPassword);
      } else if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException('Something went wrong ${e.code} ${e.message}');
      }
    }
    return userCredential;
  }

  void deleteUserAccount() {
    FirestoreRepository firestoreRepository = FirestoreRepository();
    CollectionsNames.firebaseAuth.currentUser?.delete();
    firestoreRepository.deleteUserData();
  }

  static bool userLoginStatus() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    } else {
      return true;
    }
  }

  void resetPassword(String email) async {
    try {
      await CollectionsNames.firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.userNotFound) {
        throw UserNotFoundException('User not found');
      } else if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException('Something went wrong ${e.code} ${e.message}');
      }
    }
  }
}
