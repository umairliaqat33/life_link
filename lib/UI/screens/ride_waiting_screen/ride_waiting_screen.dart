import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/utils/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RideWaitingScreen extends StatelessWidget {
  RideWaitingScreen({
    super.key,
  });
  final bool _isDriverAssigned = false;
  final bool _isHospitalAssigned = true;
  final FirestoreController _firestoreController = FirestoreController();
  RequestModel? _requestModel;
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
              if (requestSnapshot.connectionState == ConnectionState.waiting) {
                return const CircularLoaderWidget();
              }
              _requestModel = requestSnapshot.data;

              return StreamBuilder<List<HospitalModel>>(
                  stream: _firestoreController.getHospitaList(),
                  builder: (context, hosPitalSnapshot) {
                    if (hosPitalSnapshot.hasData) {
                      hospitalList = hosPitalSnapshot.data!;
                      String id = _checkDistanceBetweenTwoLocations(
                        patientLat: _requestModel!.patientLat,
                        patientLon: _requestModel!.patientLon,
                        hList: hospitalList,
                      );
                      log(id);
                      _updateRequest(id);
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
                                color: _isDriverAssigned
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
                          decoration: _changeDecoration(_isHospitalAssigned),
                          child: Center(
                            child: Text(
                              "I am Hospital Widget",
                              style: TextStyle(
                                color: _isHospitalAssigned
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
                        Text("Patient Latitude: ${_requestModel!.patientLat}"),
                        Text("Patient Longitude: ${_requestModel!.patientLon}"),
                        Text("Request Id: ${_requestModel!.requestId}"),
                        Text("Request time: ${_requestModel!.requestTime}"),
                        Text(
                            "Hospital to be taken at: ${_requestModel!.hospitalToBeTakeAtId}"),
                        Text(
                            "Ambulance Driver Id: ${_requestModel!.ambulanceDriverId}"),
                        Text(
                            "Assigned bed number: ${_requestModel!.assignedBedNumber}"),
                      ],
                    );
                  });
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

  void _updateRequest(
    String hospitalId,
  ) {
    // if (hospitalId.isNotEmpty) {
    _firestoreController.updateAmbulanceRequestFields(
      RequestModel(
        requestId: _requestModel!.requestId,
        requestTime: _requestModel!.requestTime,
        patientId: _requestModel!.patientId,
        patientLat: _requestModel!.patientLat,
        patientLon: _requestModel!.patientLon,
        hospitalToBeTakeAtId: hospitalId,
      ),
    );
    // }
  }
}
