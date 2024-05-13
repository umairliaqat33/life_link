import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/discharge_screen/discharge_screen.dart';
import 'package:life_link/UI/screens/treatment_ni_process_screen/component/treatment_in_process_viewing_alert.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/utils/colors.dart';

class TreatmentInProcessCard extends StatefulWidget {
  const TreatmentInProcessCard({
    super.key,
    required this.requestModel,
  });
  final RequestModel requestModel;

  @override
  State<TreatmentInProcessCard> createState() => _TreatmentInProcessCardState();
}

class _TreatmentInProcessCardState extends State<TreatmentInProcessCard> {
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
    return Padding(
      padding: EdgeInsets.only(
          right: SizeConfig.width10(context),
          left: SizeConfig.width10(context),
          bottom: 2),
      child: Card(
        child: ListTile(
          title: Text(
            _patientModel?.name ?? "",
          ),
          leading: IconButton(
            onPressed: () => viewhistorydetail(context),
            icon: const Icon(Icons.visibility),
          ),
          subtitle: Text(
            _patientModel?.disease ?? "",
          ),
          trailing: TextButton(
            onPressed: () => _dischargeButton(),
            child: const Text(
              'Discharge',
              style: TextStyle(color: primaryColor),
            ),
          ),
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

  void viewhistorydetail(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TreatmentInProcessViewingAlert(
          name: _patientModel?.name ?? "",
          email: _patientModel?.email ?? "",
          arrivingDateTime: widget.requestModel.requestTime,
          age: _patientModel?.age.toString() ?? "",
          bedNumber: widget.requestModel.bedAssigned,
          driverName: _driverModel?.name ?? "",
          disease: _patientModel?.disease ?? "",
        );
      },
    );
  }

  void _dischargeButton() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DischargeSreen(
          requestModel: widget.requestModel,
          patientModel: _patientModel!,
        ),
      ),
    );
  }
}
