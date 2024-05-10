import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/ride_history/components/patient_ride_history_alert.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/utils/enums.dart';

class PatientRideHistorCardWidget extends StatefulWidget {
  const PatientRideHistorCardWidget({
    super.key,
    required this.requestModel,
    required this.userType,
  });

  final RequestModel requestModel;
  final UserType userType;

  @override
  State<PatientRideHistorCardWidget> createState() =>
      _PatientRideHistorCardWidgetState();
}

class _PatientRideHistorCardWidgetState
    extends State<PatientRideHistorCardWidget> {
  DriverModel? _driverModel;

  HospitalModel? _hospitalModel;

  PatientModel? _patientModel;
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
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userType == UserType.patient
                        ? "${_hospitalModel?.name}"
                        : widget.userType == UserType.driver
                            ? "${_patientModel?.name}"
                            : "${_patientModel?.name}",
                    style: TextStyle(
                      fontSize: SizeConfig.font18(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.height10(context),
                  ),
                  Text(
                    widget.userType == UserType.patient
                        ? 'Driver: ${_driverModel?.name}'
                        : widget.userType == UserType.driver
                            ? "Hospital: ${_hospitalModel?.name}"
                            : "Driver: ${_driverModel?.name}",
                    style: TextStyle(
                      fontSize: SizeConfig.font12(context) + 1,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.requestModel.requestTime,
                    style: TextStyle(
                      fontSize: SizeConfig.font12(context) + 1,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  ElevatedButton(
                    onPressed: () => _showPatientCardButton(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: const Text(
                      'View',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getRequiredModels() async {
    _driverModel = await _firestoreController.getSpecificDriver(
        widget.requestModel.hospitalToBeTakeAtId,
        widget.requestModel.ambulanceDriverId);
    _hospitalModel = await _firestoreController
        .getSpecificHospital(widget.requestModel.hospitalToBeTakeAtId);
    _patientModel ??= await _firestoreController
        .getSpecificPatientData(widget.requestModel.patientId);
    setState(() {});
  }

  void _showPatientCardButton() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return widget.userType == UserType.patient
            ? RideDetailsAlert(
                item1: widget.requestModel.requestTime,
                item5: widget.requestModel.bedAssigned,
                item3: _patientModel?.disease ?? '',
                item4: _driverModel?.ambulanceRegistrationNo ?? '',
                item2: widget.requestModel.requestCompletionTime,
                title: _hospitalModel?.name ?? "",
                subtitle: _hospitalModel?.address ?? '',
                item1Title: 'Pickup Time:',
                item2Title: 'Drop-off time',
                item3Title: 'Disease',
                item4Title: 'Ambulance No:',
                item5Title: 'Bed Number:',
              )
            : widget.userType == UserType.driver
                ? RideDetailsAlert(
                    item1: widget.requestModel.requestTime,
                    item5: _patientModel?.age.toString() ?? "",
                    item3: _patientModel?.disease ?? '',
                    item4: widget.requestModel.customerReview,
                    item2: widget.requestModel.requestCompletionTime,
                    title: _patientModel?.name ?? "",
                    subtitle: _patientModel?.phoneNumber ?? '',
                    item1Title: 'Pickup Time',
                    item2Title: 'Drop-off time',
                    item3Title: 'Disease',
                    item4Title: 'Feedback',
                    item5Title: 'Patient Age',
                  )
                : RideDetailsAlert(
                    item1: widget.requestModel.requestCompletionTime,
                    item5: _patientModel?.age.toString() ?? "",
                    item3: _patientModel?.disease ?? '',
                    item4: widget.requestModel.customerReview,
                    item2: _driverModel?.name ?? "",
                    title: _patientModel?.name ?? "",
                    subtitle: _patientModel?.phoneNumber ?? '',
                    item1Title: 'Patient coming time',
                    item2Title: 'Driver name',
                    item3Title: 'Disease',
                    item4Title: 'Feedback',
                    item5Title: 'Patient Age',
                  );
      },
    );
  }
}
