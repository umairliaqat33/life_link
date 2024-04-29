import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_link/models/doctor_model/doctor_model.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/models/uid_model/uid_model.dart';
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
          .doc(driverModel.uid)
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
          .doc(hospitalModel.uid)
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
          .doc(patientModel.uid)
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

  Future<DriverModel> getDriverData() async {
    return CollectionsNames.firestoreCollection
        .collection(CollectionsNames.driverCollection)
        .doc(_user!.uid)
        .get()
        .then(
          (value) => DriverModel.fromJson(value.data()!),
        );
  }

  Future<HospitalModel> getHospitalData() async {
    return CollectionsNames.firestoreCollection
        .collection(CollectionsNames.hospitalCollection)
        .doc(_user!.uid)
        .get()
        .then(
          (value) => HospitalModel.fromJson(value.data()!),
        );
  }

  Future<PatientModel> getPatientData() async {
    return CollectionsNames.firestoreCollection
        .collection(CollectionsNames.patientCollection)
        .doc(_user!.uid)
        .get()
        .then(
          (value) => PatientModel.fromJson(value.data()!),
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

  void uploadDoctor(DoctorModel doctorModel) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.hospitalCollection)
          .doc(FirestoreRepository.checkUser()!.uid)
          .collection(CollectionsNames.doctorCollection)
          .doc(doctorModel.doctorId)
          .set(
            doctorModel.toJson(),
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

  void updateDoctor(
    DoctorModel doctorModel,
  ) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.hospitalCollection)
          .doc(FirestoreRepository.checkUser()!.uid)
          .collection(CollectionsNames.doctorCollection)
          .doc(doctorModel.doctorId)
          .update(
            doctorModel.toJson(),
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

  void deleteDoctor(
    String docId,
  ) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.hospitalCollection)
          .doc(FirestoreRepository.checkUser()!.uid)
          .collection(CollectionsNames.doctorCollection)
          .doc(docId)
          .delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  Stream<List<DoctorModel?>> getDoctorSearchedStream(String searchValue) {
    return searchValue.isEmpty
        ? CollectionsNames.firestoreCollection
            .collection(CollectionsNames.hospitalCollection)
            .doc(FirestoreRepository.checkUser()!.uid)
            .collection(CollectionsNames.doctorCollection)
            .snapshots()
            .map(
              (snapshot) => snapshot.docs
                  .map(
                    (doc) => DoctorModel.fromJson(
                      doc.data(),
                    ),
                  )
                  .toList(),
            )
        : CollectionsNames.firestoreCollection
            .collection(CollectionsNames.hospitalCollection)
            .doc(FirestoreRepository.checkUser()!.uid)
            .collection(CollectionsNames.doctorCollection)
            .snapshots()
            .map(
              (snapshot) => snapshot.docs
                  .map(
                    (doc) => DoctorModel.fromJson(
                      doc.data(),
                    ),
                  )
                  .where(
                    (element) => element.name.toLowerCase().contains(
                          searchValue.toLowerCase(),
                        ),
                  )
                  .toList(),
            );
  }

  Future<List<HospitalModel>> getHospitalStreamList() async {
    QuerySnapshot querySnapshot = await CollectionsNames.firestoreCollection
        .collection(CollectionsNames.hospitalCollection)
        .get();
    List<HospitalModel> hospitalModels = querySnapshot.docs.map(
      (doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return HospitalModel.fromJson(data);
      },
    ).toList();
    return hospitalModels;
  }

  void uploadUID(UIDModel uidModel) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.usedID)
          .doc()
          .set(
            uidModel.toJson(),
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

  Future<bool> uidExist(String uid) async {
    var v = await CollectionsNames.firestoreCollection
        .collection(CollectionsNames.usedID)
        .where('uid', isEqualTo: uid)
        .get();
    if (v.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void createAmbulanceRequest(RequestModel requestModel) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.requestCollection)
          .doc(requestModel.requestId)
          .set(requestModel.toJson());
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  void updateAmbulanceRequest(RequestModel requestModel) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.requestCollection)
          .doc(requestModel.requestId)
          .update(requestModel.toJson());
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  Stream<RequestModel?> getRequestStream() {
    return CollectionsNames.firestoreCollection
        .collection(CollectionsNames.requestCollection)
        .where(
          'patientId',
          isEqualTo: FirestoreRepository.checkUser()!.uid,
        )
        .snapshots()
        .map(
          (snapshot) => RequestModel.fromJson(
            snapshot.docs.first.data(),
          ),
        );
  }
}
