// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:life_link/UI/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:life_link/UI/screens/ride_in_progress_screen/ride_in_progress_screen.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/no_data_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/beds_model/bed_model.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/notification_model/notification_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/services/date_and_time_service.dart';
import 'package:life_link/services/id_service.dart';
import 'package:life_link/services/notification_service.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/enums.dart';
import 'package:life_link/utils/strings.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RideWaitingScreen extends StatefulWidget {
  const RideWaitingScreen({
    super.key,
    required this.requestModel,
  });
  final RequestModel requestModel;

  @override
  State<RideWaitingScreen> createState() => _RideWaitingScreenState();
}

class _RideWaitingScreenState extends State<RideWaitingScreen> {
  RequestModel? _requestModel;
  final FirestoreController _firestoreController = FirestoreController();
  List<HospitalModel> hospitalList = [];
  bool _isLoading = false;
  bool _isHospitalWithBedAndDriverAvailable = true;

  @override
  void initState() {
    super.initState();
    if (widget.requestModel != null) {
      _requestModel = widget.requestModel;
    }
    _firestoreController
        .getFutureHospitaList()
        .then((List<HospitalModel> models) {
      hospitalList = models;
      _processAmbulanceRequest(hospitalList);
      _isLoading = false;
      setState(() {});
    }).catchError((error) {
      log('Error fetching hospital models: $error');
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          title: "Waiting",
          context: context,
          backButton: true,
        ),
        body: _isLoading
            ? const CircularLoaderWidget()
            : Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.height15(context),
                  right: SizeConfig.height15(context),
                ),
                child: StreamBuilder<RequestModel?>(
                    stream:
                        _firestoreController.getUserAmbulanceRequestStream(),
                    builder: (context, requestSnapshot) {
                      if (requestSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularLoaderWidget();
                      }
                      if (requestSnapshot.hasData) {
                        _requestModel = requestSnapshot.data;
                      }
                      if (_isHospitalWithBedAndDriverAvailable &&
                          _requestModel!.ambulanceDriverId.isNotEmpty &&
                          _requestModel!.hospitalToBeTakeAtId.isNotEmpty) {
                        Future.delayed(Duration.zero, () {
                          final notificationService = NotificationService();
                          notificationService.sendNotification(
                            body: AppStrings.incomingPatientText,
                            receiverUid: _requestModel!.hospitalToBeTakeAtId,
                            userType: UserType.hospital,
                          );
                          notificationService.sendNotification(
                            body: AppStrings.incomingPatientText,
                            receiverUid: _requestModel!.ambulanceDriverId,
                            userType: UserType.driver,
                          );
                          _uploadNotification(
                            _requestModel!,
                            UserType.patient,
                            "Ambulance request was created at ${_requestModel!.requestTime}",
                            "Request Created",
                          );
                          _goToMapScreen();
                        });
                      }
                      return !_isHospitalWithBedAndDriverAvailable &&
                              _requestModel!.ambulanceDriverId.isEmpty &&
                              _requestModel!.hospitalToBeTakeAtId.isEmpty
                          ? const Center(
                              child:
                                  NoDataWidget(alertText: "No Hospital Found"))
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  LoadingAnimationWidget.staggeredDotsWave(
                                    color: primaryColor,
                                    size: SizeConfig.height20(context) * 5,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: SizeConfig.height20(context) * 5,
                                    decoration: _changeDecoration(
                                        _isDriverAssigned(_requestModel!)),
                                    child: Center(
                                      child: Text(
                                        "I am Driver Widget",
                                        style: TextStyle(
                                          color:
                                              _isDriverAssigned(_requestModel!)
                                                  ? primaryColor
                                                  : greyColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.height8(context),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: SizeConfig.height20(context) * 5,
                                    decoration: _changeDecoration(
                                        _isHospitalAssigned(_requestModel!)),
                                    child: Center(
                                      child: Text(
                                        "I am Hospital Widget",
                                        style: TextStyle(
                                          color: _isHospitalAssigned(
                                                  _requestModel!)
                                              ? primaryColor
                                              : greyColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.height8(context),
                                  ),
                                  Text(
                                      "Patient Id: ${_requestModel!.patientId}"),
                                  Text(
                                      "Patient Latitude: ${_requestModel!.patientLat}"),
                                  Text(
                                      "Patient Longitude: ${_requestModel!.patientLon}"),
                                  Text(
                                      "Request Id: ${_requestModel!.requestId}"),
                                  Text(
                                      "Request time: ${_requestModel!.requestTime}"),
                                  Text(
                                      "Hospital to be taken at: ${_requestModel!.hospitalToBeTakeAtId}"),
                                  Text(
                                      "Ambulance Driver Id: ${_requestModel!.ambulanceDriverId}"),
                                  Text(
                                      "Bed number: ${_requestModel!.bedAssigned}"),
                                ],
                              ),
                            );
                    }),
              ),
      ),
    );
  }

  BoxDecoration _changeDecoration(bool value) {
    return BoxDecoration(
      border: Border.all(
        color: value ? primaryColor : greyColor,
        width: 3,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      color: value ? primaryColor.withOpacity(0.1) : greyColor.withOpacity(0.3),
    );
  }

  Future<void> _processAmbulanceRequest(List<HospitalModel> hList) async {
    try {
      String id = _checkDistanceBetweenTwoLocations(
        patientLat: _requestModel!.patientLat,
        patientLon: _requestModel!.patientLon,
        hList: hList,
      );
      log(id);
      HospitalModel? hospitalModel;
      for (int i = 0; i < hList.length; i++) {
        if (hList[i].uid == id) {
          hospitalModel = hList[i];
        }
      }
      if (hospitalModel!.isApproved) {
        BedModel? bedModel = await _firestoreController
            .isBedAvailablInRequestedHospital(hospitalModel.uid);
        bool isBedAvailable = bedModel?.isAvailable ?? false;

        if (!isBedAvailable) {
          _isHospitalWithBedAndDriverAvailable = false;
          _requestModel = null;
          log("Made _isHospitalWithBedAndDriverAvailable==false;");
          Fluttertoast.showToast(
              msg: "No Hospitals with beds and driver are available");
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const BottomNavBar(),
            ),
            (route) => false,
          );
        }
        if (!isBedAvailable) {
          hList.removeWhere((element) => element.uid == id);
          if (hList.isNotEmpty) {
            _processAmbulanceRequest(hList);
          }
        } else {
          _updateRequest(
            hospitalId: id,
            bedNumber: bedModel?.bedId.toString(),
            driverId: "",
          );
          log("Bed & hospital are available");
          bool isDriverPresent = await _isDriverAvailable(
            id,
            hList,
            bedModel!.bedId.toString(),
          );
          if (!isDriverPresent && hList.length <= 1) {
            _isHospitalWithBedAndDriverAvailable = false;
            log("No Hospitals available with beds and drivers");
            _updateRequest(
              driverId: '',
              hospitalId: '',
            );
            setState(() {});
          }
          return;
          // log(isDriverAvailable.toString());
        }
      } else {
        hList.removeWhere((element) => element.uid == id);
        if (hList.isNotEmpty) {
          _processAmbulanceRequest(hList);
        }
        Future.delayed(const Duration(seconds: 2), () {
          _isHospitalWithBedAndDriverAvailable = false;
          _requestModel = null;
          log("Made _isHospitalWithBedAndDriverAvailable==false;");
          Fluttertoast.showToast(
              msg: "No Hospitals with beds and driver are available");
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const BottomNavBar(),
            ),
            (route) => false,
          );
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  String _checkDistanceBetweenTwoLocations({
    required double patientLat,
    required double patientLon,
    required List<HospitalModel> hList,
  }) {
    String hospitalId = '';
    double newDistance = 0;
    double oldDistance = 0;
    for (int i = 0; i < hList.length; i++) {
      if (oldDistance == 0) {
        oldDistance = Geolocator.distanceBetween(
          patientLat,
          patientLon,
          hList[i].hospitalLat,
          hList[i].hospitalLon,
        );
      } else {
        newDistance = Geolocator.distanceBetween(
          patientLat,
          patientLon,
          hList[i].hospitalLat,
          hList[i].hospitalLon,
        );
      }
      if (newDistance > oldDistance) {
        log(oldDistance.toString());
        hospitalId = hList[i].uid;
      } else {
        if (newDistance != 0 || hList.length == 1) {
          oldDistance = newDistance;
          log(oldDistance.toString());
          hospitalId = hList[i].uid;
        }
        log(newDistance.toString());
      }
    }
    return hospitalId;
  }

  void _updateRequest({
    String? hospitalId,
    String? driverId,
    String? bedNumber,
  }) {
    _firestoreController.updateAmbulanceRequestFields(
      RequestModel(
        requestId: _requestModel!.requestId,
        requestTime: _requestModel!.requestTime,
        patientId: _requestModel!.patientId,
        patientLat: _requestModel!.patientLat,
        patientLon: _requestModel!.patientLon,
        hospitalToBeTakeAtId: hospitalId ?? "",
        ambulanceDriverId: driverId ?? "",
        bedAssigned: bedNumber ?? "",
        patientArrivingTime: "",
        customerReview: "",
      ),
    );
  }

  Future<bool> _isDriverAvailable(
    String id,
    List<HospitalModel> hList,
    String bedNumber,
  ) async {
    DriverModel? driverModel =
        await _firestoreController.getAvailableDriverDataAHospital(id);
    if (driverModel != null &&
        driverModel.isAvailable &&
        driverModel.isApproved) {
      _updateRequest(
        hospitalId: id,
        driverId: driverModel.uid,
        bedNumber: bedNumber,
      );

      return true;
    } else {
      hList.removeWhere((element) => element.uid == id);
      if (hList.isNotEmpty) {
        _processAmbulanceRequest(hList);
      }
      return false;
    }
  }

  bool _isDriverAssigned(RequestModel requestModel) {
    return _requestModel?.ambulanceDriverId != null &&
            _requestModel!.ambulanceDriverId.isNotEmpty
        ? true
        : false;
  }

  bool _isHospitalAssigned(RequestModel requestModel) {
    return _requestModel?.hospitalToBeTakeAtId != null &&
            _requestModel!.hospitalToBeTakeAtId.isNotEmpty
        ? true
        : false;
  }

  Future<void> _goToMapScreen() async {
    HospitalModel hospitalModel = await _firestoreController
        .getSpecificHospital(_requestModel!.hospitalToBeTakeAtId);
    DriverModel driverModel = await _firestoreController.getSpecificDriver(
        _requestModel!.hospitalToBeTakeAtId, _requestModel!.ambulanceDriverId);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => RideInProgressScreen(
          requestModel: _requestModel!,
          hospitalModel: hospitalModel,
          driverModel: driverModel,
        ),
      ),
    );
  }

  Future<void> _uploadNotification(
    RequestModel requestModel,
    UserType userType,
    String message,
    String title,
  ) async {
    try {
      String notificationtId = await IdService.createID();
      String time = DateAndTimeService.timeToString(
        timeOfDay: TimeOfDay.now(),
        isDateRequired: true,
      );
      _firestoreController.uploadNotification(
        NotificationModel(
          notificationId: notificationtId,
          fromId: userType == UserType.patient
              ? requestModel.patientId
              : requestModel.hospitalToBeTakeAtId,
          toId: userType == UserType.patient
              ? requestModel.hospitalToBeTakeAtId
              : requestModel.patientId,
          message: message,
          title: title,
          notificationTime: time,
        ),
      );
    } catch (e) {
      log("Exception at uploadNotification in ride waiting screen: ${e.toString()}");
    }
  }
}
