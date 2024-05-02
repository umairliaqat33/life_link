import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_link/models/doctor_model/doctor_model.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/models/user_model/user_model.dart';
import 'package:life_link/repositories/firestore_repository.dart';
import 'package:life_link/utils/exceptions.dart';
import 'package:life_link/utils/strings.dart';

class FirestoreController {
  final FirestoreRepository _firestoreRepository = FirestoreRepository();

  void uploadUserInformation(UserModel userModel) {
    try {
      _firestoreRepository.uploadUserInfo(userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  void uploadDriverInformation(DriverModel driverModel) {
    try {
      _firestoreRepository.uploadDriverData(driverModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  void uploadPatientInformation(PatientModel patientModel) {
    try {
      _firestoreRepository.uploadPatientData(patientModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  void uploadHospitalInformation(HospitalModel hospitalModel) {
    try {
      _firestoreRepository.uploadHospitalData(hospitalModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  Future<UserModel> getUserData() {
    return _firestoreRepository.getUserData();
  }

  Future<DriverModel?> getAvailableDriverDataAHospital(
    String hId,
  ) {
    return _firestoreRepository.getAvailableDriverDataForSpecificHospital(hId);
  }

  Future<HospitalModel> getHospitalData() {
    return _firestoreRepository.getHospitalData();
  }

  Future<PatientModel> getPatientData() {
    return _firestoreRepository.getPatientData();
  }

  void updateUserData(
    UserModel userModel,
  ) async {
    try {
      _firestoreRepository.updateUserData(
        userModel,
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

  void uploadDoctor(
    DoctorModel doctorModel,
  ) async {
    try {
      _firestoreRepository.uploadDoctor(doctorModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  void updateDoctorData(
    DoctorModel doctorModel,
  ) async {
    try {
      _firestoreRepository.updateDoctor(doctorModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  void updateDriverData(
    DriverModel driverModel,
  ) async {
    try {
      _firestoreRepository.updateDriver(driverModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  void deleteDoctorData(
    String docId,
  ) async {
    try {
      _firestoreRepository.deleteDoctor(docId);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  void deleteDriverData(
    String driverId,
  ) async {
    try {
      _firestoreRepository.deleteDoctor(driverId);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  Stream<List<DoctorModel?>> getDoctorSearchedStreamList(String searchValue) {
    return _firestoreRepository.getDoctorSearchedStream(searchValue);
  }

  Stream<List<DriverModel?>> getDriverSearchedStreamList(String searchValue) {
    return _firestoreRepository.getDriverSearchedStream(searchValue);
  }

  void createAmbulanceRequest(RequestModel requestModel) {
    try {
      _firestoreRepository.createAmbulanceRequest(requestModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  void updateAmbulanceRequestFields(RequestModel requestModel) {
    try {
      _firestoreRepository.updateAmbulanceRequest(requestModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  Stream<RequestModel?> getUserAmbulanceRequestStream() {
    return _firestoreRepository.getRequestStream();
  }

  Future<List<HospitalModel>> getFutureHospitaList() {
    return _firestoreRepository.getHospitalStreamList();
  }
}
