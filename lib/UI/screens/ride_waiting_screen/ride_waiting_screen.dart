// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:life_link/UI/screens/map_screen/map_screen.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/no_data_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/utils/colors.dart';
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
      setState(() {
        hospitalList = models;
        _processAmbulanceRequest(hospitalList);
        _isLoading = false;
      });
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
      bool isBedAvailable = _checkIsBedAvailable(hList, id);
      if (!isBedAvailable) {
        hList.removeWhere((element) => element.uid == id);
        if (hList.isNotEmpty) {
          _processAmbulanceRequest(hList);
        }
      } else {
        _updateRequest(
          hospitalId: id,
          driverId: "",
        );
        log("Bed & hospital are available");
        bool isDriverPresent = await _isDriverAvailable(id, hList);
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

  void _goToMapScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MapScreen(
          requestModel: _requestModel!,
        ),
      ),
    );
  }
}
