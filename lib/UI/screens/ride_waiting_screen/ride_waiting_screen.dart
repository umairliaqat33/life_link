import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/utils/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RideWaitingScreen extends StatelessWidget {
  RideWaitingScreen({
    super.key,
  });
  RequestModel? _requestModel;

  final FirestoreController _firestoreController = FirestoreController();

  List<HospitalModel> hospitalList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          title: "Waiting",
          context: context,
          backButton: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.height15(context),
            right: SizeConfig.height15(context),
          ),
          child: StreamBuilder<RequestModel?>(
              stream: _firestoreController.getUserAmbulanceRequestStream(),
              builder: (context, requestSnapshot) {
                if (requestSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularLoaderWidget();
                }
                if (requestSnapshot.hasData) {
                  _requestModel = requestSnapshot.data;
                }
                return FutureBuilder<List<HospitalModel>>(
                  future: _firestoreController.getFutureHospitaList(),
                  builder: (BuildContext context, hospitalListFuturesnapshot) {
                    if (hospitalListFuturesnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularLoaderWidget();
                    }

                    if (hospitalListFuturesnapshot.hasData) {
                      hospitalList = hospitalListFuturesnapshot.data!;
                      _processAmbulanceRequest(hospitalList);
                    }
                    return SingleChildScrollView(
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
                                  color: _isDriverAssigned(_requestModel!)
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
                                  color: _isHospitalAssigned(_requestModel!)
                                      ? primaryColor
                                      : greyColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.height8(context),
                          ),
                          Text("Patient Id: ${_requestModel!.patientId}"),
                          Text(
                              "Patient Latitude: ${_requestModel!.patientLat}"),
                          Text(
                              "Patient Longitude: ${_requestModel!.patientLon}"),
                          Text("Request Id: ${_requestModel!.requestId}"),
                          Text("Request time: ${_requestModel!.requestTime}"),
                          Text(
                              "Hospital to be taken at: ${_requestModel!.hospitalToBeTakeAtId}"),
                          Text(
                              "Ambulance Driver Id: ${_requestModel!.ambulanceDriverId}"),
                          Text(
                              "Assigned bed number: ${_requestModel!.assignedBedNumber}"),
                        ],
                      ),
                    );
                  },
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

  void _processAmbulanceRequest(List<HospitalModel> hList) {
    try {
      String id = _checkDistanceBetweenTwoLocations(
        patientLat: _requestModel!.patientLat,
        patientLon: _requestModel!.patientLon,
        hList: hList,
      );
      log(id);
      bool isBedAvailable = _checkIsBedAvailable(hList, id);
      if (!isBedAvailable) {
        hList.removeWhere((element) => element.uid == id);
        if (hList.isNotEmpty) {
          _processAmbulanceRequest(hospitalList);
        }
      } else {
        _updateRequest(
          hospitalId: id,
          driverId: "",
        );
        log("Bed & hospital are available");
        // Future<bool> isDriverAvailable = _isDriverAvailable(id, hList);
        // log(isDriverAvailable.toString());
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
        if (newDistance != 0) {
          oldDistance = newDistance;
          log(oldDistance.toString());
          hospitalId = hList[i].uid;
        }
        log(newDistance.toString());
      }
    }
    return hospitalId;
  }

  bool _checkIsBedAvailable(
    List<HospitalModel> hList,
    String id,
  ) {
    HospitalModel? hospitalModel;
    for (int i = 0; i < hList.length; i++) {
      if (hList[i].uid == id) {
        hospitalModel = hList[i];
      }
    }
    if ((hospitalModel!.totalBeds - hospitalModel.availableBeds) <
        hospitalModel.totalBeds) {
      return true;
    } else {
      return false;
    }
  }

  void _updateRequest({
    String? hospitalId,
    String? driverId,
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
      ),
    );
  }

  Future<bool> _isDriverAvailable(
    String id,
    List<HospitalModel> hList,
  ) async {
    DriverModel? driverModel =
        await _firestoreController.getAvailableDriverDataAHospital(id);
    if (driverModel != null && driverModel.isAvailable) {
      _updateRequest(
        hospitalId: id,
        driverId: driverModel.uid,
      );
      return true;
    } else {
      hList.removeWhere((element) => element.uid == id);
      if (hList.isNotEmpty) {
        _processAmbulanceRequest(hospitalList);
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
}
