import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/patient_ride_history/components/patient_ride_history_alert.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/request_model/request_model.dart';

class PatientRideHistorCardWidget extends StatefulWidget {
  const PatientRideHistorCardWidget({
    super.key,
    required this.requestModel,
  });

  final RequestModel requestModel;

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
                    "${_hospitalModel?.name}",
                    style: TextStyle(
                      fontSize: SizeConfig.font18(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.height10(context),
                  ),
                  Text(
                    'Driver: ${_driverModel?.name}',
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
        return RideDetailsAlert(
          pickupTime: widget.requestModel.requestTime,
          bedNumber: widget.requestModel.bedAssigned,
          disease: _patientModel?.disease ?? '',
          ambulanceNumber: _driverModel?.ambulanceRegistrationNo ?? '',
          dropOffTime: widget.requestModel.requestCompletionTime,
          hospitalName: _hospitalModel?.name ?? "",
          hospitalAddress: _hospitalModel?.address ?? '',
        );
      },
    );
  }
}
