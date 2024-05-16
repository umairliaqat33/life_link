// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:life_link/UI/widgets/buttons/custom_button.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/UI/widgets/text_fields/text_form_field_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/doctor_model/doctor_model.dart';
import 'package:life_link/models/notification_model/notification_model.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/report_model/report_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/services/date_and_time_service.dart';
import 'package:life_link/services/id_service.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/strings.dart';
import 'package:life_link/utils/utils.dart';

class DischargeSreen extends StatefulWidget {
  const DischargeSreen({
    super.key,
    required this.requestModel,
    required this.patientModel,
  });
  final RequestModel requestModel;
  final PatientModel patientModel;

  @override
  State<DischargeSreen> createState() => _DischargeSreenState();
}

class _DischargeSreenState extends State<DischargeSreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _doctorList = ["Select a doctor"];
  String _selectedDoctor = '';
  final FirestoreController _firestoreController = FirestoreController();
  final TextEditingController _prescriptionController = TextEditingController();
  final TextEditingController _treatedDiseaseController =
      TextEditingController();
  bool _isLoading = false;
  List<DoctorModel> _doctorModelList = [];
  bool _doctorNotSelected = false;
  @override
  void initState() {
    super.initState();
    _getAndSetDoctorList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        title: "Discharge Screen",
        context: context,
        backButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.width15(context) + 1,
          right: SizeConfig.width15(context) + 1,
          top: SizeConfig.width15(context) + 1,
        ),
        child: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        "Please select a doctor who operated the patient"),
                    SizedBox(
                      height: SizeConfig.width5(context),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: _doctorNotSelected & _isLoading
                                  ? redColor
                                  : primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<String>(
                            underline: Container(
                              color: primaryColor,
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: primaryColor,
                            ),
                            value: _doctorList.first,
                            onChanged: (String? value) =>
                                _dropDownButtonOnTap(value),
                            items: _doctorList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    color: primaryColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Visibility(
                          visible: _selectedDoctor.isNotEmpty,
                          child: Container(
                            padding: EdgeInsets.all(
                              SizeConfig.height5(context),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: greyColor,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Selected doctor: ",
                                  style: TextStyle(
                                    fontSize: SizeConfig.font12(context),
                                    color: greyColor,
                                  ),
                                ),
                                Text(
                                  _selectedDoctor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.width5(context),
                    ),
                    TextFormFieldWidget(
                      controller: _prescriptionController,
                      validator: (value) => Utils.prescriptionValidator(value),
                      label: "Prescription and prevention",
                      hintText:
                          "Prescriptions and preventions for this patient.",
                      inputType: TextInputType.multiline,
                      inputAction: TextInputAction.done,
                      maxLines: 20,
                      minLines: 1,
                    ),
                    SizedBox(
                      height: SizeConfig.width5(context),
                    ),
                    TextFormFieldWidget(
                      controller: _treatedDiseaseController,
                      validator: (value) => Utils.prescriptionValidator(value),
                      label: "Disease treated",
                      hintText: "Disease at this hospital",
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: (SizeConfig.height15(context) * 2),
                      ),
                      child: _isLoading
                          ? const CircularLoaderWidget()
                          : SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                buttonColor: primaryColor,
                                title: "SAVE",
                                onPressed: () => _saveReportButton(),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _dropDownButtonOnTap(String? value) async {
    FocusScope.of(context).unfocus();
    setState(() {
      _selectedDoctor = value!;
    });

    log(_selectedDoctor);
  }

  Future<void> _getAndSetDoctorList() async {
    _doctorModelList = await _firestoreController.getDoctorList();
    for (int i = 0; i < _doctorModelList.length; i++) {
      log(_doctorModelList[i].name);
      _doctorList.add(_doctorModelList[i].name);
    }
    setState(() {});
  }

  Future<void> _saveReportButton() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        if (_selectedDoctor.isEmpty) {
          _doctorNotSelected = true;
          setState(() {});
          return;
        }
        String dischargeTime = DateAndTimeService.timeToString(
            timeOfDay: TimeOfDay.now(), isDateRequired: true);

        String reportId = await IdService.createID();
        String doctorID = '';
        for (int i = 0; i < _doctorModelList.length; i++) {
          if (_selectedDoctor == _doctorModelList[i].name) {
            doctorID = _doctorModelList[i].doctorId;
          }
        }
        RequestModel requestModel = RequestModel(
          requestId: widget.requestModel.requestId,
          requestTime: widget.requestModel.requestTime,
          patientId: widget.requestModel.patientId,
          patientLat: widget.requestModel.patientLat,
          patientLon: widget.requestModel.patientLon,
          ambulanceDriverId: widget.requestModel.ambulanceDriverId,
          bedAssigned: widget.requestModel.bedAssigned,
          customerReview: widget.requestModel.customerReview,
          hospitalToBeTakeAtId: widget.requestModel.hospitalToBeTakeAtId,
          patientArrivingTime: widget.requestModel.patientArrivingTime,
          reportId: reportId,
        );
        _uploadNotification();
        _firestoreController.uploadReportOnDischarge(
          ReportModel(
            reportId: reportId,
            patientID: widget.requestModel.patientId,
            hospitalId: widget.requestModel.hospitalToBeTakeAtId,
            doctorID: doctorID,
            prevention: _prescriptionController.text,
            dischargeTime: dischargeTime,
            diseaseTreated: _treatedDiseaseController.text,
            requestId: requestModel.requestId,
          ),
        );
        _firestoreController.addCompleteRequest(requestModel);
        _firestoreController.deleteCompletedRequest(requestModel.requestId);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const BottomNavBar(),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      log("Exception at saveReportButton: ${e.toString()}");
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _uploadNotification() async {
    try {
      String notificationtId = await IdService.createID();
      String time = DateAndTimeService.timeToString(
        timeOfDay: TimeOfDay.now(),
        isDateRequired: true,
      );
      _firestoreController.uploadNotification(
        NotificationModel(
          notificationId: notificationtId,
          fromId: widget.requestModel.hospitalToBeTakeAtId,
          toId: widget.requestModel.patientId,
          message: AppStrings.patientDischargedText,
          title: 'Discharged !!!',
          notificationTime: time,
        ),
      );
    } catch (e) {
      log("Exception at uploadNotification in discharge screen: ${e.toString()}");
    }
  }
}
