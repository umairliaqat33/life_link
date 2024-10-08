import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:life_link/UI/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:life_link/UI/screens/map_screen/map_screen.dart';
import 'package:life_link/UI/screens/review_screen/review_screen.dart';
import 'package:life_link/UI/widgets/buttons/custom_button.dart';
import 'package:life_link/UI/widgets/cards/info_card_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/notification_model/notification_model.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/services/app_shifter_service.dart';
import 'package:life_link/services/date_and_time_service.dart';
import 'package:life_link/services/id_service.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/enums.dart';

class RideCompletetionScreen extends StatefulWidget {
  const RideCompletetionScreen({
    super.key,
    required this.requestModel,
    required this.hospitalName,
  });
  final RequestModel requestModel;
  final String hospitalName;

  @override
  State<RideCompletetionScreen> createState() => _RideCompletetionScreenState();
}

class _RideCompletetionScreenState extends State<RideCompletetionScreen> {
  final FirestoreController _firestoreController = FirestoreController();
  PatientModel? _patientModel;
  String _patientName = '';
  final TextEditingController _reviewController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _getSetPatientModel();
  }

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
              userType: UserType.patient,
            ),
            Container(
              height: SizeConfig.height(context),
              width: SizeConfig.width(context),
              decoration: BoxDecoration(
                color: lightGreyColor.withOpacity(0.7),
              ),
              child: TextButton(
                onPressed: () {
                  AppShifterServices.launchGoogleMaps(
                    widget.requestModel.patientLat,
                    widget.requestModel.patientLon,
                  );
                },
                child: Row(
                  children: [
                    Image.asset(
                      Assets.googleMapsImage,
                      height: SizeConfig.height20(context) * 4,
                      width: SizeConfig.width20(context) * 4,
                    ),
                    Text(
                      "Go to google maps",
                      style: TextStyle(
                        fontSize: SizeConfig.font24(context) + 1,
                        color: blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(SizeConfig.height15(context)),
              child: BottomSheet(
                enableDrag: false,
                elevation: 100,
                onClosing: () {},
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.all(SizeConfig.height8(context)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(Assets.doneIcon),
                              Text(
                                "RideCompleted",
                                style: TextStyle(
                                  fontSize: SizeConfig.font18(context),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          InfoCardWidget(
                            item1Title: "Patient Name",
                            item2Title: "Request Time",
                            item3Title: "Request Completion Time",
                            item4Title: "Hospital Name",
                            item5Title: "Bed Number",
                            item1: _patientName,
                            item2: widget.requestModel.requestTime,
                            item3: widget.requestModel.patientArrivingTime,
                            item4: widget.hospitalName,
                            item5: widget.requestModel.bedAssigned,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              title: "Give Review",
                              onPressed: () => _giveReview(),
                            ),
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

  Future<void> _getSetPatientModel() async {
    _patientModel = await _firestoreController
        .getSpecificPatientData(widget.requestModel.patientId);
    _patientName = _patientModel?.name ?? '';
    setState(() {});
  }

  Future<void> _giveReview() async {
    await Get.dialog(
      barrierDismissible: true,
      ReviewScreen(
        reviewController: _reviewController,
      ),
    );
    _manipulateRequestData();
  }

  void _cancelButton() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const BottomNavBar(),
      ),
      (route) => false,
    );
  }

  void _manipulateRequestData() {
    RequestModel updatedWithReviewRequest = RequestModel(
      requestId: widget.requestModel.requestId,
      requestTime: widget.requestModel.requestTime,
      patientId: widget.requestModel.patientId,
      patientLat: widget.requestModel.patientLat,
      patientLon: widget.requestModel.patientLon,
      hospitalToBeTakeAtId: widget.requestModel.hospitalToBeTakeAtId,
      ambulanceDriverId: widget.requestModel.ambulanceDriverId,
      bedAssigned: widget.requestModel.bedAssigned,
      patientArrivingTime: widget.requestModel.patientArrivingTime,
      customerReview: _reviewController.text,
    );
    _uploadNotification(
      updatedWithReviewRequest,
      "Your feedback was: ${_reviewController.text}",
      "Feedback",
    );
    _firestoreController.updateAmbulanceRequestFields(
      updatedWithReviewRequest,
    );

    _cancelButton();
  }

  Future<void> _uploadNotification(
    RequestModel requestModel,
    String message,
    String title,
  ) async {
    try {
      String notificationtId = await IdService.createID();
      String time = DateAndTimeService.timeToString(
        timeOfDay: TimeOfDay.now(),
        isDateRequired: true,
      );
      _firestoreController.uploadNotification(
        NotificationModel(
          notificationId: notificationtId,
          fromId: requestModel.patientId,
          toId: requestModel.ambulanceDriverId,
          message: message,
          title: title,
          notificationTime: time,
        ),
      );
    } catch (e) {
      log("Exception at uploadNotification in discharge screen: ${e.toString()}");
    }
  }
}
