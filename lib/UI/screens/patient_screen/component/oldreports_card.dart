import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/patient_screen/component/report_view_alert.dart';
import 'package:life_link/UI/widgets/buttons/custom_button.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/doctor_model/doctor_model.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/report_model/report_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/services/date_and_time_service.dart';
import 'package:life_link/utils/colors.dart';

class OldReportsCard extends StatefulWidget {
  const OldReportsCard({
    super.key,
    required this.reportModel,
    required this.reportIndex,
  });
  final ReportModel reportModel;
  final int reportIndex;

  @override
  State<OldReportsCard> createState() => _OldReportsCardState();
}

class _OldReportsCardState extends State<OldReportsCard> {
  DriverModel? _driverModel;

  PatientModel? _patientModel;

  RequestModel? _requestModel;

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
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: _isLoading
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: CircularLoaderWidget(),
                ),
              )
            : Padding(
                padding: EdgeInsets.all(SizeConfig.width20(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Report no: ${widget.reportIndex + 1}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.font18(context),
                            color: appTextColor,
                          ),
                        ),
                        Text(date),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _driverModel?.hospitalName ?? "",
                          style: TextStyle(
                            fontSize: SizeConfig.font12(context),
                            color: appTextColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        title: "View Report",
                        onPressed: () => _viewReportButton(context),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _getRequiredModels() async {
    _requestModel = await _firestoreController
        .getSpecificRequestById(widget.reportModel.requestId);
    _driverModel = await _firestoreController.getSpecificDriver(
        _requestModel!.hospitalToBeTakeAtId, _requestModel!.ambulanceDriverId);
    _patientModel ??= await _firestoreController
        .getSpecificPatientData(_requestModel!.patientId);
    _doctorModel = await _firestoreController
        .getSpecificDoctor(widget.reportModel.doctorID);
    date = DateAndTimeService.extractDateFromStringDateTime(
      widget.reportModel.dischargeTime,
    );
    setState(() {
      _isLoading = false;
    });
  }

  void _viewReportButton(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReportViewingAlert(
          reportModel: widget.reportModel,
          name: _patientModel?.name ?? "",
          email: _patientModel?.email ?? "",
          arrivingDateTime: _requestModel?.patientArrivingTime ?? "",
          dischargeDateTime: widget.reportModel.dischargeTime,
          bedNumber: _requestModel?.bedAssigned ?? "",
          driverName: _driverModel?.name ?? "",
          disease: _patientModel?.disease ?? "",
          doctorName: _doctorModel?.name ?? "",
          hospitalName: _driverModel?.hospitalName ?? "",
        );
      },
    );
  }
}
