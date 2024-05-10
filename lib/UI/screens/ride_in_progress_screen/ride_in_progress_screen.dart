import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/map_screen/map_screen.dart';
import 'package:life_link/UI/screens/ride_completetion_screen/ride_completetion_screen.dart';
import 'package:life_link/UI/widgets/buttons/custom_button.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/services/date_and_time_service.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';

class RideInProgressScreen extends StatefulWidget {
  const RideInProgressScreen({
    super.key,
    required this.requestModel,
    required this.hospitalModel,
    required this.driverModel,
  });
  final RequestModel requestModel;
  final HospitalModel hospitalModel;
  final DriverModel driverModel;

  @override
  State<RideInProgressScreen> createState() => _RideInProgressScreenState();
}

class _RideInProgressScreenState extends State<RideInProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            MapScreen(
              marker1Longitude: widget.requestModel.patientLon,
              marker1Latitude: widget.requestModel.patientLat,
              marker2Longitude: 74.2901811,
              marker2Latitude: 31.5817799,
            ),
            Padding(
              padding: EdgeInsets.all(SizeConfig.height15(context)),
              child: BottomSheet(
                onClosing: () {},
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.all(SizeConfig.height8(context)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: SizeConfig.width10(context) * 8 / 2,
                                child: widget.driverModel.profilePicture.isEmpty
                                    ? Image.asset(
                                        Assets.blankProfilePicture,
                                        height:
                                            SizeConfig.height10(context) * 10,
                                        width: SizeConfig.width10(context) * 8,
                                      )
                                    : ClipOval(
                                        child: Image.network(
                                          widget.driverModel.profilePicture,
                                          height:
                                              SizeConfig.height10(context) * 10,
                                          width:
                                              SizeConfig.width10(context) * 8,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                              ),
                              SizedBox(
                                width: SizeConfig.width8(context),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.driverModel.name.toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "From : ${widget.hospitalModel.name}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: greyColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.height8(context),
                                  ),
                                  const Text(
                                    "Arriving in : 20 min",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: greyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          CustomButton(
                            title: "Complete Ride",
                            onPressed: () => _completeRideButton(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _completeRideButton() {
    FirestoreController firestoreController = FirestoreController();
    String completionTime = DateAndTimeService.timeToString(
      timeOfDay: TimeOfDay.now(),
      isDateRequired: true,
    );
    log(completionTime);
    RequestModel completedRequest = RequestModel(
      requestId: widget.requestModel.requestId,
      requestTime: widget.requestModel.requestTime,
      patientId: widget.requestModel.patientId,
      patientLat: widget.requestModel.patientLat,
      patientLon: widget.requestModel.patientLon,
      hospitalToBeTakeAtId: widget.requestModel.hospitalToBeTakeAtId,
      ambulanceDriverId: widget.requestModel.ambulanceDriverId,
      bedAssigned: widget.requestModel.bedAssigned,
      requestCompletionTime: completionTime,
      customerReview: "",
    );
    firestoreController.updateAmbulanceRequestFields(completedRequest);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => RideCompletetionScreen(
          requestModel: completedRequest,
          hospitalName: widget.hospitalModel.name,
        ),
      ),
    );
  }
}
