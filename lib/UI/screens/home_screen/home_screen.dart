import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/home_screen/components/info_card.dart';
import 'package:life_link/UI/screens/home_screen/components/option_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/user_model/user_model.dart';
import 'package:life_link/repositories/firestore_repository.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/enums.dart';

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
                          ? const Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    OptionWidget(
                                      title: "Ride History",
                                      icon: Assets.historyIcon,
                                    ),
                                    OptionWidget(
                                      title: "Available hospitals",
                                      icon: Assets.hospitalBedIcon,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : _userModel!.userType == UserType.hospital.name
                              ? Column(
                                  children: [
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        OptionWidget(
                                          title: "Incoming Patients",
                                          icon: Assets.hospitalBedIcon,
                                        ),
                                        OptionWidget(
                                          title: "Available Beds",
                                          icon: Assets.patientBedIcon,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.height20(context),
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        OptionWidget(
                                          title: "History",
                                          icon: Assets.historyIcon,
                                        ),
                                        OptionWidget(
                                          title: "Discharged Patients",
                                          icon: Assets.patientCuredIcon,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    GestureDetector(
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
                                          child: Text(
                                            "SOS",
                                            style: TextStyle(
                                              color: whiteColor,
                                              fontSize:
                                                  SizeConfig.font28(context) +
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
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        OptionWidget(
                                          title: "Ride History",
                                          icon: Assets.historyIcon,
                                        ),
                                        OptionWidget(
                                          title: "Old Reports",
                                          icon: Assets.listIcon,
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
    _driverModel = await _firestoreController.getDriverData();
    if (_driverModel != null) {
      _email = _driverModel!.email;
      _userName = _driverModel!.name;
      _isLoading = false;
      setState(() {});
    }
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
}
