import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_link/models/beds_model/bed_model.dart';
import 'package:life_link/models/doctor_model/doctor_model.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/notification_model/notification_model.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/report_model/report_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/models/user_model/user_model.dart';
import 'package:life_link/repositories/firestore_repository.dart';
import 'package:life_link/utils/enums.dart';
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

  Future<UserModel> getSpecificUserModel(String uid) {
    return _firestoreRepository.getSpecificUserData(uid);
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

  Future<PatientModel> getSpecificPatientData(String pID) {
    return _firestoreRepository.getSpecificPatientData(pID);
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

  Future<RequestModel?> getSpecificUserRequest() {
    try {
      return _firestoreRepository.getSpecificUserAmbulanceRequest();
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

  Future<HospitalModel> getSpecificHospital(String id) {
    return _firestoreRepository.getSpecificHospitalData(id);
  }

  Future<DriverModel> getSpecificDriver(
    String hId,
    String driverID,
  ) {
    return _firestoreRepository.getSpecificDriverData(
      hId,
      driverID,
    );
  }

  void changePatientFCM({
    required String id,
    required String token,
  }) {
    try {
      _firestoreRepository.updatePatientFCMToken(
        id: id,
        fcmToken: token,
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

  void changeHospitalOrDriverFCM({
    required UserType userType,
    required String hospitalUid,
    required String token,
  }) {
    try {
      _firestoreRepository.updateHospitalOrDriverFCMToken(
        userType: userType,
        hId: hospitalUid,
        fcmToken: token,
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

  Future<String> getReceiverFCMTokenViaUid(
    String receiverUid,
    UserType userType,
  ) {
    return _firestoreRepository.getReceiverFCMToken(receiverUid, userType);
  }

  void changeBedAvailability(BedModel bedModel) {
    try {
      _firestoreRepository.changeBedAvailability(bedModel);
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
      _firestoreRepository.addBed(bedModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  Stream<List<BedModel>> getBedsStreamList() {
    return _firestoreRepository.getBedStreamList();
  }

  Future<BedModel?> isBedAvailablInRequestedHospital(String uid) async {
    return await _firestoreRepository.isBedAvailableInSpecificHospital(uid);
  }

  void addCompleteRequest(RequestModel requestModel) {
    try {
      _firestoreRepository.addCompletedRequests(requestModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  void deleteCompletedRequest(String reqId) {
    try {
      _firestoreRepository.deleteCompletedRequestFromInProgress(reqId);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  void deleteInCompletedRequest(String reqId) {
    try {
      _firestoreRepository.deleteInCompletedRequestFromInProgress(reqId);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  Stream<List<RequestModel>> getCompletedRequestStream() {
    return _firestoreRepository.getCompletedRequestsStream();
  }

  Future<DriverModel?> getCurrentDriverData() async {
    return await _firestoreRepository.getDriverData();
  }

  Future<String> getDriverFCMViaDriverID(String driverId) {
    return _firestoreRepository.getDriverFCM(driverId);
  }

  Stream<List<RequestModel>> getInProgressRequestStream() {
    return _firestoreRepository.getInProgressRequestsStream();
  }

  Stream<List<RequestModel>> getInProgressCurrentUserRequestStream() {
    return _firestoreRepository.getInTreatmentCurrentUserRequestsStream();
  }

  Stream<List<RequestModel>> getInTreatmentRequestStream() {
    return _firestoreRepository.getInTreatmentRequestsStream();
  }

  Future<List<DoctorModel>> getDoctorList() {
    return _firestoreRepository.getDoctorlist();
  }

  void uploadReportOnDischarge(ReportModel reportModel) {
    try {
      _firestoreRepository.uploadReport(reportModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  Future<ReportModel> getSpecificRequestReport(String requestId) {
    return _firestoreRepository.getSpecificReport(requestId);
  }

  Stream<List<ReportModel>> getReportStreamList() {
    return _firestoreRepository.getReportStreamList();
  }

  Future<DoctorModel?> getSpecificDoctor(String doctorId) {
    return _firestoreRepository.getSpecificDoctor(doctorId);
  }

  Future<RequestModel> getSpecificRequestById(String requestId) {
    return _firestoreRepository.getSpecificCompletedRequest(requestId);
  }

  void uploadNotification(NotificationModel notificationModel) {
    try {
      _firestoreRepository.uploadNotification(notificationModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  Stream<List<NotificationModel>> getNotificationModelStreamList() {
    return _firestoreRepository.getNotificationModelStreamList();
  }

  void deleteNotification(String notificationId) {
    _firestoreRepository.deleteNotificationByNotificationId(notificationId);
  }

  void updatePatient(PatientModel patientModel) {
    _firestoreRepository.updatePatientData(patientModel);
  }

  void updateHospital(HospitalModel hospitalModel) {
    _firestoreRepository.updatehospitalData(hospitalModel);
  }

  void deletePatientData() {
    _firestoreRepository.deletePatientData();
  }

  void deleteHospitalData() {
    _firestoreRepository.deleteHospitalData();
  }
}
