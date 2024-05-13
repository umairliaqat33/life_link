// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:life_link/UI/screens/map_screen/map_screen.dart';
import 'package:life_link/UI/screens/patient_pick_up_screen/components/view_patient_to_pickup_details_alert.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/services/location_service.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/enums.dart';

class PatientToPickUpCardWidget extends StatefulWidget {
  const PatientToPickUpCardWidget({
    super.key,
    required this.requestModel,
  });
  final RequestModel requestModel;

  @override
  State<PatientToPickUpCardWidget> createState() =>
      _PatientToPickUpCardWidgetState();
}

class _PatientToPickUpCardWidgetState extends State<PatientToPickUpCardWidget> {
  PatientModel? _patientModel;
  HospitalModel? _hospitalModel;
  final FirestoreController _firestoreController = FirestoreController();

  @override
  void initState() {
    super.initState();
    _getRequiredModels();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.width8(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _patientModel?.name ?? "",
              style: TextStyle(
                fontSize: SizeConfig.font22(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Coming in: 10 minutes',
              style: TextStyle(fontSize: 13),
              textAlign: TextAlign.end,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.height10(context),
                ),
                Text(
                  'Hospital: ${_hospitalModel?.name ?? ""}',
                  style: TextStyle(
                    fontSize: SizeConfig.font12(context) + 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => _goToMapButton(),
                      child: const Text(
                        'Go To Map',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ViewPatientToPickupDetailsAlert(
                              name: _patientModel?.name ?? "",
                              email: _patientModel?.email ?? "",
                              age: _patientModel?.age.toString() ?? "",
                              gender: _patientModel?.gender ?? "",
                              disease: _patientModel?.disease ?? "",
                              bedAssigned: widget.requestModel.bedAssigned,
                              oldReportsLink: '',
                              imageLink: _patientModel?.profilePicture,
                            );
                          },
                        );
                      },
                      child: const Text(
                        'View',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getRequiredModels() async {
    _hospitalModel = await _firestoreController.getSpecificHospital(
      widget.requestModel.hospitalToBeTakeAtId,
    );
    _patientModel ??= await _firestoreController.getSpecificPatientData(
      widget.requestModel.patientId,
    );
    setState(() {});
  }

  Future<void> _goToMapButton() async {
    Position? position = await LocationService.getCurrentPosition();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MapScreen(
          marker1Longitude: widget.requestModel.patientLon,
          marker1Latitude: widget.requestModel.patientLat,
          marker2Longitude: position!.longitude,
          marker2Latitude: position.latitude,
          userType: UserType.driver,
        ),
      ),
    );
  }
}
