import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/incoming_patients_screen/components/view_details_alert.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/utils/colors.dart';

class IncomingPatientsCardWidget extends StatefulWidget {
  const IncomingPatientsCardWidget({
    super.key,
    required this.requestModel,
  });
  final RequestModel requestModel;

  @override
  State<IncomingPatientsCardWidget> createState() =>
      _IncomingPatientsCardWidgetState();
}

class _IncomingPatientsCardWidgetState
    extends State<IncomingPatientsCardWidget> {
  DriverModel? _driverModel;

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
        padding: EdgeInsets.all(SizeConfig.width15(context) + 1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
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
                  SizedBox(
                    height: SizeConfig.height10(context),
                  ),
                  Text(
                    'Driver: ${_driverModel?.name ?? ""}',
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
                  const Text(
                    'Coming in: 10 minutes',
                    style: TextStyle(fontSize: 13),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    height: SizeConfig.height5(context),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ViewIncomingPatientDetailsAlert(
                            name: _patientModel?.name ?? "",
                            email: _patientModel?.email ?? "",
                            age: _patientModel?.age.toString() ?? "",
                            gender: _patientModel?.gender ?? "",
                            disease: _patientModel?.disease ?? "",
                            bedAssigned: widget.requestModel.bedAssigned,
                            oldReportsLink: '',
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
    _patientModel ??= await _firestoreController
        .getSpecificPatientData(widget.requestModel.patientId);
    setState(() {});
  }
}
