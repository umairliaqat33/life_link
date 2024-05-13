import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_link/UI/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:life_link/UI/screens/map_screen/map_screen.dart';
import 'package:life_link/UI/screens/review_screen/review_screen.dart';
import 'package:life_link/UI/widgets/buttons/custom_button.dart';
import 'package:life_link/UI/widgets/cards/info_card_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
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
                            item3: widget.requestModel.requestCompletionTime,
                            item4: widget.hospitalName,
                            item5: widget.requestModel.bedAssigned,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: SizeConfig.width15(context) * 10,
                                child: CustomButton(
                                  title: "Give Review",
                                  onPressed: () => _giveReview(),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.width15(context) * 10,
                                child: CustomButton(
                                  buttonColor: greyColor,
                                  title: "Later",
                                  onPressed: () => _cancelButton(),
                                ),
                              ),
                            ],
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
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReviewScreen(
          reviewController: _reviewController,
        );
      },
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
      patientArrivingTime: widget.requestModel.requestCompletionTime,
      customerReview: _reviewController.text,
    );
    _firestoreController.updateAmbulanceRequestFields(
      updatedWithReviewRequest,
    );
    _firestoreController.addCompleteRequest(updatedWithReviewRequest);
    _firestoreController
        .deleteCompletedRequest(updatedWithReviewRequest.requestId);
    _cancelButton();
  }
}
