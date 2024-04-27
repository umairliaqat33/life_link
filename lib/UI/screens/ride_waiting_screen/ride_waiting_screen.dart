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

class RideWaitingScreen extends StatelessWidget {
  RideWaitingScreen({
    super.key,
  });
  final bool _isDriverAssigned = false;
  final bool _isHospitalAssigned = true;
  final FirestoreController _firestoreController = FirestoreController();
  RequestModel? _requestModel;

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
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularLoaderWidget();
              }
              _requestModel = snapshot.data;
              Future<List<HospitalModel?>> _hospitalList =
                  _firestoreController.getHospitaList();
              String nearestHospitaId;
              _iterateHospitalList(_hospitalList, _requestModel!.patientLat,
                  _requestModel!.patientLon);
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
                  Text("Patient Id: ${_requestModel!.patientId}"),
                  Text("Patient Latitude: ${_requestModel!.patientLat}"),
                  Text("Patient Longitude: ${_requestModel!.patientLon}"),
                  Text("Request Id: ${_requestModel!.requestId}"),
                  Text("Request time: ${_requestModel!.requestTime}"),
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

  String _iterateHospitalList(
    Future<List<HospitalModel?>> _hospitalList,
    double patientLat,
    double patientLon,
  ) {
    double d1 = 0;
    String uid = '';
    _hospitalList.then((list) {
      for (int i = 0; i < list.length; i++) {
        double d = _checkDistanceBetweenTwoLocations(
          p1Lat: patientLat,
          p1Lon: patientLon,
          p2Lat: list[i]!.hospitalLat,
          p2Lon: list[i]!.hospitalLat,
        );
        if (d > d1) {
          d1 = d;
          uid = list[i]!.uid;
        }
      }
    });
    log(uid);
    return uid;
  }

  double _checkDistanceBetweenTwoLocations({
    required double p1Lat,
    required double p1Lon,
    required double p2Lat,
    required double p2Lon,
  }) {
    double distanceInMeters = Geolocator.distanceBetween(
      p1Lat,
      p1Lon,
      p2Lat,
      p2Lon,
    );
    return distanceInMeters;
  }
}
