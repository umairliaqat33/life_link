// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:life_link/UI/screens/available_beds_screen/available_beds_screen.dart';
import 'package:life_link/UI/screens/doctor_screen/doctor_screen.dart';
import 'package:life_link/UI/screens/drivers_screen/drivers_screen.dart';
import 'package:life_link/UI/screens/history_screen/history_screen.dart';
import 'package:life_link/UI/screens/home_screen/components/info_card.dart';
import 'package:life_link/UI/screens/home_screen/components/option_widget.dart';
import 'package:life_link/UI/screens/incoming_patients_screen/incoming_patients_screen.dart';
import 'package:life_link/UI/screens/patient_screen/oldreports.dart';
import 'package:life_link/UI/screens/ride_waiting_screen/ride_waiting_screen.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/models/user_model/user_model.dart';
import 'package:life_link/repositories/firestore_repository.dart';
import 'package:life_link/services/date_and_time_service.dart';
import 'package:life_link/services/id_service.dart';
import 'package:life_link/services/location_service.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/enums.dart';
import 'package:life_link/utils/exceptions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? _userModel;
  DriverModel? _driverModel;
  PatientModel? _patientModel;
  HospitalModel? _hospitalModel;
  final FirestoreController _firestoreController = FirestoreController();
  bool _isLoading = true;
  bool _requestLoading = false;
  String _userName = '';
  String _email = '';
  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.height15(context),
            right: SizeConfig.height15(context),
          ),
          child: _isLoading
              ? const CircularLoaderWidget()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: SizeConfig.height20(context) * 3,
                        ),
                        child: InfoCard(
                          name: _userName,
                          email: _email,
                          imageLink: "",
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.height20(context) * 2,
                      ),
                      _userModel!.userType == UserType.driver.name
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    OptionWidget(
                                      title: "Ride History",
                                      icon: Assets.historyIcon,
                                      onTap: () => onRideHistoryTap(),
                                    ),
                                    OptionWidget(
                                      title: "Available hospitals",
                                      icon: Assets.hospitalBedIcon,
                                      onTap: () => onAvailableHospitalsTap(),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : _userModel!.userType == UserType.hospital.name
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        OptionWidget(
                                          title: "Incoming Patients",
                                          icon: Assets.hospitalBedIcon,
                                          onTap: () => onIncomingPatientsTap(),
                                        ),
                                        OptionWidget(
                                          title: "Available Beds",
                                          icon: Assets.patientBedIcon,
                                          onTap: () => onAvailableBeds(),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.height20(context),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        OptionWidget(
                                          title: "History",
                                          icon: Assets.historyIcon,
                                          onTap: () => onHistoryTap(),
                                        ),
                                        OptionWidget(
                                          title: "Manage Doctors",
                                          icon: Assets.patientCuredIcon,
                                          onTap: () => onManageDoctors(),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.height20(context),
                                    ),
                                    OptionWidget(
                                      title: "Manage Drivers",
                                      icon: Assets.patientCuredIcon,
                                      onTap: () => onManageDriver(),
                                    )
                                  ],
                                )
                              : Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () => _createAmbulanceRequest(),
                                      child: Container(
                                        width: SizeConfig.width20(context) * 10,
                                        height:
                                            SizeConfig.height20(context) * 10,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              primaryColor,
                                              primaryColor,
                                              whiteColor,
                                            ],
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                          ),
                                          shape: BoxShape.circle,
                                          color: primaryColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  primaryColor.withOpacity(0.4),
                                              spreadRadius: 15,
                                              blurRadius: 10,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: _requestLoading
                                              ? const CircularLoaderWidget(
                                                  loaderColor: whiteColor,
                                                )
                                              : Text(
                                                  "SOS",
                                                  style: TextStyle(
                                                    color: whiteColor,
                                                    fontSize: SizeConfig.font28(
                                                            context) +
                                                        2,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.height20(context) * 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        OptionWidget(
                                          title: "Ride History",
                                          icon: Assets.historyIcon,
                                          onTap: () => onRideHistoryTap(),
                                        ),
                                        OptionWidget(
                                          title: "Old Reports",
                                          icon: Assets.listIcon,
                                          onTap: () => onOldReports(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> _getUserData() async {
    if (FirestoreRepository.checkUser() != null) {
      _userModel = await _firestoreController.getUserData();
      if (_userModel!.userType == UserType.driver.name) {
        _getAndSetDriverData();
      } else if (_userModel!.userType == UserType.hospital.name) {
        _getAndSetHospitalData();
      } else {
        _getAndSetPatientData();
      }
      setState(() {});
    }
  }

  Future<void> _getAndSetDriverData() async {
    // _driverModel = await _firestoreController.getAvailableDriverDataAHospital();
    // if (_driverModel != null) {
    //   _email = _driverModel!.email;
    //   _userName = _driverModel!.name;
    //   _isLoading = false;
    //   setState(() {});
    // }
  }

  Future<void> _getAndSetHospitalData() async {
    _hospitalModel = await _firestoreController.getHospitalData();
    if (_hospitalModel != null) {
      _email = _hospitalModel!.email;
      _userName = _hospitalModel!.name;
      _isLoading = false;
      setState(() {});
    }
  }

  Future<void> _getAndSetPatientData() async {
    _patientModel = await _firestoreController.getPatientData();
    if (_patientModel != null) {
      _email = _patientModel!.email;
      _userName = _patientModel!.name;
      _isLoading = false;
      setState(() {});
    }
  }

  void onRideHistoryTap() {}
  void onAvailableHospitalsTap() {}
  void onIncomingPatientsTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const IncomingPatientsScreen(),
      ),
    );
  }

  void onAvailableBeds() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AvailableBedsScreen(),
      ),
    );
  }

  void onHistoryTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HistoryScreen(),
      ),
    );
  }

  void onManageDoctors() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DoctorScreen(),
      ),
    );
  }

  void onManageDriver() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DriverScreen(),
      ),
    );
  }

  void onOldReports() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const OldReports()));
  }

  Future<void> _createAmbulanceRequest() async {
    setState(() {
      _requestLoading = true;
    });
    try {
      String reqId = await IdService.createID();
      String time = DateAndTimeService.timeToString(TimeOfDay.now());
      PatientModel patientModel = await _firestoreController.getPatientData();
      Position? currentPosition = await LocationService.getCurrentPosition();
      RequestModel requestModel = RequestModel(
        requestId: reqId,
        requestTime: time,
        patientId: patientModel.uid,
        patientLat: currentPosition!.latitude,
        patientLon: currentPosition.longitude,
      );
      // _firestoreController.createAmbulanceRequest(
      //   requestModel,
      // );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RideWaitingScreen(
            requestModel: requestModel,
          ),
        ),
      );
    } on NoInternetException catch (e) {
      Fluttertoast.showToast(
        msg: e.message,
      );
    } on FormatParsingException catch (e) {
      Fluttertoast.showToast(
        msg: e.message,
      );
    } on UnknownException catch (e) {
      Fluttertoast.showToast(
        msg: e.message,
      );
    }
    setState(() {
      _requestLoading = false;
    });
  }
}
