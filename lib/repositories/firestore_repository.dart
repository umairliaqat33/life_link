import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_link/models/beds_model/bed_model.dart';
import 'package:life_link/models/doctor_model/doctor_model.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/models/uid_model/uid_model.dart';
import 'package:life_link/models/user_model/user_model.dart';
import 'package:life_link/utils/collection_names.dart';
import 'package:life_link/utils/enums.dart';
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
          .collection(CollectionsNames.hospitalCollection)
          .doc(FirestoreRepository.checkUser()!.uid)
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

  Future<DriverModel?> getAvailableDriverDataForSpecificHospital(
      String hospitalId) async {
    return CollectionsNames.firestoreCollection
        .collection(CollectionsNames.hospitalCollection)
        .doc(hospitalId)
        .collection(CollectionsNames.driverCollection)
        .where('isAvailable', isEqualTo: true)
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.size > 0) {
        Map<String, dynamic> data =
            snapshot.docs.first.data() as Map<String, dynamic>;

        DriverModel driverModel = DriverModel.fromJson(data);
        // Use the driverModel as needed
        return driverModel;
      } else {
        log('No available driver found.');
        return null; // Return null when no driver is found
      }
    });
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

  Future<PatientModel> getSpecificPatientData(String patientId) async {
    return CollectionsNames.firestoreCollection
        .collection(CollectionsNames.patientCollection)
        .doc(patientId)
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

  void updateDriver(
    DriverModel driverModel,
  ) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.hospitalCollection)
          .doc(FirestoreRepository.checkUser()!.uid)
          .collection(CollectionsNames.driverCollection)
          .doc(driverModel.uid)
          .update(
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

  void deleteDriver(
    String driverId,
  ) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.hospitalCollection)
          .doc(FirestoreRepository.checkUser()!.uid)
          .collection(CollectionsNames.driverCollection)
          .doc(driverId)
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

  Stream<List<DriverModel?>> getDriverSearchedStream(String searchValue) {
    return searchValue.isEmpty
        ? CollectionsNames.firestoreCollection
            .collection(CollectionsNames.hospitalCollection)
            .doc(FirestoreRepository.checkUser()!.uid)
            .collection(CollectionsNames.driverCollection)
            .snapshots()
            .map(
              (snapshot) => snapshot.docs
                  .map(
                    (doc) => DriverModel.fromJson(
                      doc.data(),
                    ),
                  )
                  .toList(),
            )
        : CollectionsNames.firestoreCollection
            .collection(CollectionsNames.hospitalCollection)
            .doc(FirestoreRepository.checkUser()!.uid)
            .collection(CollectionsNames.driverCollection)
            .snapshots()
            .map(
              (snapshot) => snapshot.docs
                  .map(
                    (doc) => DriverModel.fromJson(
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
    List<HospitalModel> hospitalModels = [];
    try {
      QuerySnapshot querySnapshot = await CollectionsNames.firestoreCollection
          .collection(CollectionsNames.hospitalCollection)
          .get();
      hospitalModels = querySnapshot.docs.map(
        (doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return HospitalModel.fromJson(data);
        },
      ).toList();
    } catch (e) {
      log(e.toString());
    }
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
          .collection(CollectionsNames.requestInProgressCollection)
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
          .collection(CollectionsNames.requestInProgressCollection)
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
        .collection(CollectionsNames.requestInProgressCollection)
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

  Future<HospitalModel> getSpecificHospitalData(String uid) async {
    var doc = await CollectionsNames.firestoreCollection
        .collection(CollectionsNames.hospitalCollection)
        .doc(uid)
        .get();

    return HospitalModel.fromJson(doc.data()!);
  }

  Future<DriverModel> getSpecificDriverData(
    String hId,
    String driverId,
  ) async {
    var doc = await CollectionsNames.firestoreCollection
        .collection(CollectionsNames.hospitalCollection)
        .doc(hId)
        .collection(CollectionsNames.driverCollection)
        .doc(driverId)
        .get();

    return DriverModel.fromJson(doc.data()!);
  }

  Future<DriverModel?> getDriverData() async {
    DriverModel? driverModel;
    QuerySnapshot hospitalSnapshot =
        await FirebaseFirestore.instance.collection('hospitals').get();

    for (QueryDocumentSnapshot hospitalDoc in hospitalSnapshot.docs) {
      QuerySnapshot driversSnapshot = await hospitalDoc.reference
          .collection('drivers')
          .where('uid', isEqualTo: FirestoreRepository.checkUser()!.uid)
          .get();

      if (driversSnapshot.docs.isNotEmpty) {
        // Driver found in this hospital
        QueryDocumentSnapshot driverDoc = driversSnapshot.docs.first;
        Map<String, dynamic> driverData =
            driverDoc.data() as Map<String, dynamic>;
        driverModel = DriverModel.fromJson(driverData);
        log('Driver found in hospital: ${hospitalDoc.id}');
        log('Driver data: $driverData');
        // You can use the driver data here
        break; // Exit the loop once the driver is found
      }
    }
    return driverModel;
  }

  void updatePatientFCMToken({
    required String id,
    required String fcmToken,
  }) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.patientCollection)
          .doc(id)
          .set(
        {"fcmToken": fcmToken},
        SetOptions(
          merge: true,
        ),
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

  void updateHospitalOrDriverFCMToken({
    required UserType userType,
    required String hId,
    required String dId,
    required String fcmToken,
  }) {
    try {
      userType == UserType.hospital
          ? CollectionsNames.firestoreCollection
              .collection(CollectionsNames.hospitalCollection)
              .doc(hId)
              .set(
              {"fcmToken": fcmToken},
              SetOptions(
                merge: true,
              ),
            )
          : CollectionsNames.firestoreCollection
              .collection(CollectionsNames.hospitalCollection)
              .doc(hId)
              .collection(CollectionsNames.driverCollection)
              .doc(dId)
              .set(
              {"fcmToken": fcmToken},
              SetOptions(
                merge: true,
              ),
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

  Future<String> getFCMToken() async {
    UserModel userModel = await getUserData();
    String fcmToken = '';
    if (userModel.userType == UserType.patient.name) {
      PatientModel patientModel = await getPatientData();
      fcmToken = patientModel.fcmToken;
    } else if (userModel.userType == UserType.hospital.name) {
      HospitalModel hospitalModel = await getHospitalData();
      fcmToken = hospitalModel.fcmToken;
    } else if (userModel.userType == UserType.driver.name) {
      DriverModel? driverModel = await getDriverData();
      if (driverModel != null) {
        fcmToken = driverModel.fcmToken;
      }
    }
    return fcmToken;
  }

  Future<PatientModel> getSpecificPatientModel(String uid) async {
    var docSnapshot = await CollectionsNames.firestoreCollection
        .collection(CollectionsNames.patientCollection)
        .doc(uid)
        .get();
    return PatientModel.fromJson(docSnapshot.data()!);
  }

  Future<String> getReceiverFCMToken(
    String receiverUid,
    UserType userType,
  ) async {
    String fcmToken = '';
    if (userType == UserType.patient) {
      PatientModel patientModel = await getSpecificPatientModel(receiverUid);
      fcmToken = patientModel.fcmToken;
    } else if (userType == UserType.hospital) {
      HospitalModel hospitalModel = await getSpecificHospitalData(receiverUid);
      fcmToken = hospitalModel.fcmToken;
    }
    //  else if (userType == UserType.driver) {
    //   DriverModel? driverModel = await getDriverData();
    //   if (driverModel != null) {
    //     fcmToken = driverModel.fcmToken;
    //   }
    // }
    return fcmToken;
  }

  void changeBedAvailability(
    BedModel bed,
  ) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.hospitalCollection)
          .doc(FirestoreRepository.checkUser()!.uid)
          .collection(CollectionsNames.bedsCollection)
          .doc(bed.bedId.toString())
          .update(
            bed.toJson(),
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

  void addBed(BedModel bedModel) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.hospitalCollection)
          .doc(FirestoreRepository.checkUser()!.uid)
          .collection(CollectionsNames.bedsCollection)
          .doc(bedModel.bedId.toString())
          .set(bedModel.toJson());
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  Stream<List<BedModel>> getBedStreamList() {
    return CollectionsNames.firestoreCollection
        .collection(CollectionsNames.hospitalCollection)
        .doc(FirestoreRepository.checkUser()!.uid)
        .collection(CollectionsNames.bedsCollection)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => BedModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  Future<BedModel?> isBedAvailableInSpecificHospital(String hospitalId) async {
    return await CollectionsNames.firestoreCollection
        .collection(CollectionsNames.hospitalCollection)
        .doc(hospitalId)
        .collection(CollectionsNames.bedsCollection)
        .where('isAvailable', isEqualTo: true)
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.size > 0) {
        Map<String, dynamic> data =
            snapshot.docs.first.data() as Map<String, dynamic>;
        BedModel bedModel = BedModel.fromJson(data);
        return bedModel;
      } else {
        log('No available driver found.');
        return null;
      }
    });
  }

  void addCompletedRequests(RequestModel requestModel) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.completedRequestCollection)
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

  void deleteCompletedRequestFromInProgress(String requestId) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.requestInProgressCollection)
          .doc(requestId)
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
}
