import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/user_model/user_model.dart';
import 'package:life_link/utils/collection_names.dart';
import 'package:life_link/utils/exceptions.dart';
import 'package:life_link/utils/strings.dart';

class FirestoreRepository {
  final User? _user = FirebaseAuth.instance.currentUser;
  void uploadUserInfo(UserModel userModel) async {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.usersCollection)
          .doc(userModel.uid)
          .set(
            userModel.toJson(),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  Future<void> uploadDriverData(DriverModel driverModel) async {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.driverCollection)
          .doc(_user!.uid)
          .set(
            driverModel.toJson(),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  Future<void> uploadHospitalData(HospitalModel hospitalModel) async {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.hospitalCollection)
          .doc(_user!.uid)
          .set(
            hospitalModel.toJson(),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  Future<void> uploadPatientData(PatientModel patientModel) async {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.patientCollection)
          .doc(_user!.uid)
          .set(
            patientModel.toJson(),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  Future<UserModel> getUserData() async {
    return CollectionsNames.firestoreCollection
        .collection(CollectionsNames.usersCollection)
        .doc(_user!.uid)
        .get()
        .then(
          (value) => UserModel.fromJson(value.data()!),
        );
  }

  static User? checkUser() {
    User? user = CollectionsNames.firebaseAuth.currentUser;
    return user;
  }

  void updateUserData(UserModel userModel) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.usersCollection)
          .doc(_user!.uid)
          .update(
            userModel.toJson(),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  void deleteUserData() {
    CollectionsNames.firestoreCollection
        .collection(CollectionsNames.usersCollection)
        .doc(_user!.uid)
        .delete();
  }
}
