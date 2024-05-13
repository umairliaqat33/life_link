import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/history_screen/component/history_view_alert.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/doctor_model/doctor_model.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/report_model/report_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/services/date_and_time_service.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard({
    super.key,
    required this.requestModel,
  });
  final RequestModel requestModel;

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  DriverModel? _driverModel;

  PatientModel? _patientModel;
  ReportModel? _reportModel;
  DoctorModel? _doctorModel;
  final FirestoreController _firestoreController = FirestoreController();
  String date = '';
  bool _isLoading = true;

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
        child: _isLoading
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: CircularLoaderWidget(),
                ),
              )
            : ListTile(
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
                trailing: Text(
                  date,
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
    _reportModel = await _firestoreController
        .getSpecificRequestReport(widget.requestModel.requestId);
    _doctorModel =
        await _firestoreController.getSpecificDoctor(_reportModel!.doctorID);
    date = DateAndTimeService.extractDateFromStringDateTime(
      _reportModel!.dischargeTime,
    );
    setState(() {
      _isLoading = false;
    });
  }

  void viewhistorydetail(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return HistoryViewingAlert(
          name: _patientModel?.name ?? "",
          email: _patientModel?.email ?? "",
          arrivingDateTime: widget.requestModel.requestTime,
          dischargeDateTime: _reportModel?.dischargeTime ?? "",
          bedNumber: widget.requestModel.bedAssigned,
          driverName: _driverModel?.name ?? "",
          disease: _patientModel?.disease ?? "",
          reportModel: _reportModel!,
          doctorName: _doctorModel?.name ?? "",
          hospitalName: _driverModel?.hospitalName ?? "",
        );
      },
    );
  }
}
