import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/utils/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RideWaitingScreen extends StatefulWidget {
  RideWaitingScreen({
    super.key,
    required this.requestModel,
  });
  RequestModel requestModel;

  @override
  State<RideWaitingScreen> createState() => _RideWaitingScreenState();
}

class _RideWaitingScreenState extends State<RideWaitingScreen> {
  final bool _isDriverAssigned = false;

  final bool _isHospitalAssigned = true;

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
          child: FutureBuilder<List<HospitalModel>>(
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
              return Column(
                children: [
                  LoadingAnimationWidget.staggeredDotsWave(
                    color: primaryColor,
                    size: SizeConfig.height20(context) * 5,
                  ),
                  Container(
                    width: double.infinity,
                    height: SizeConfig.height20(context) * 5,
                    decoration: _changeDecoration(_isDriverAssigned),
                    child: Center(
                      child: Text(
                        "I am Driver Widget",
                        style: TextStyle(
                          color: _isDriverAssigned ? primaryColor : greyColor,
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
                    decoration: _changeDecoration(_isHospitalAssigned),
                    child: Center(
                      child: Text(
                        "I am Hospital Widget",
                        style: TextStyle(
                          color: _isHospitalAssigned ? primaryColor : greyColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.height8(context),
                  ),
                  Text("Patient Id: ${widget.requestModel.patientId}"),
                  Text("Patient Latitude: ${widget.requestModel.patientLat}"),
                  Text("Patient Longitude: ${widget.requestModel.patientLon}"),
                  Text("Request Id: ${widget.requestModel.requestId}"),
                  Text("Request time: ${widget.requestModel.requestTime}"),
                  Text(
                      "Hospital to be taken at: ${widget.requestModel.hospitalToBeTakeAtId}"),
                  Text(
                      "Ambulance Driver Id: ${widget.requestModel.ambulanceDriverId}"),
                  Text(
                      "Assigned bed number: ${widget.requestModel.assignedBedNumber}"),
                ],
              );
            },
          ),
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
    String id = _checkDistanceBetweenTwoLocations(
      patientLat: widget.requestModel.patientLat,
      patientLon: widget.requestModel.patientLon,
      hList: hList,
    );
    log(id);
    _updateRequest(id);
    bool isBedAvailable = _checkIsBedAvailable(hList, id);
    if (!isBedAvailable) {
      hList.removeWhere((element) => element.uid == id);
      if (hList.isNotEmpty) {
        _processAmbulanceRequest(hList);
      }
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

  void _updateRequest(
    String hospitalId,
  ) {
    // if (hospitalId.isNotEmpty) {
    widget.requestModel = RequestModel(
      requestId: widget.requestModel.requestId,
      requestTime: widget.requestModel.requestTime,
      patientId: widget.requestModel.patientId,
      patientLat: widget.requestModel.patientLat,
      patientLon: widget.requestModel.patientLon,
      hospitalToBeTakeAtId: hospitalId,
    );
    _firestoreController.updateAmbulanceRequestFields(
      widget.requestModel,
    );
    // if (!mounted) return;
    // setState(() {});
    // }
  }
}
