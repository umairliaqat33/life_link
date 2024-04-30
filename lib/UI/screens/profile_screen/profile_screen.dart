import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/authentication/forgot_password_screen.dart/forgot_password_screen.dart';

import 'package:life_link/UI/screens/profile_screen/components/profile_text.dart';
import 'package:life_link/UI/screens/profile_screen/components/tile_widget.dart';
import 'package:life_link/UI/screens/settings_screen/settings_screen.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
// import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/user_model/user_model.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/enums.dart';
import 'package:life_link/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // var userData;
  String? imageLink;
  String _name = "";
  String _email = "";
  int _age = 0;
  String _gender = '';
  String _phoneNumber = '';
  String _disease = '';
  // String _address = '';
  // String _empid = '';
  // String _license = "";
  PatientModel? _patientModel;
  HospitalModel? _hospitalModel;
  // DriverModel? _driverModel;
  UserModel? _userModel;
  final FirestoreController _firestoreController = FirestoreController();

  @override
  void initState() {
    super.initState();
    _checkUserType();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          title: "Profile",
          context: context,
          backButton: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                //_userModel!.userType == UserType.patient.name?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: SizeConfig.height8(context) * 2,
                    ),
                    Center(
                      child: Stack(children: [
                        const CircleAvatar(
                          backgroundImage: null,
                          radius: 75.0,
                        ),
                        Positioned(
                          left: 80,
                          bottom: -10,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                          ),
                        )
                      ]),
                    ),
                    SizedBox(
                      height: SizeConfig.height12(context),
                    ),
                    const Divider(),
                    Container(
                        padding: EdgeInsets.all(SizeConfig.pad12(context)),
                        decoration: const BoxDecoration(
                            color: whiteColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "PROFILE INFORMATION",
                                style: TextStyle(
                                  color: blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.font16(context),
                                ),
                              ),
                              TextButton(
                                onPressed: () => edit_profile_data(),
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(color: redColor),
                                ),
                              )
                            ],
                          ),
                          profile_text(
                            text: "UserName",
                            value: _name,
                          ),
                          profile_text(
                            text: "Email",
                            value: _email,
                          )
                        ])),
                    const Divider(),
                    Container(
                      padding: EdgeInsets.all(SizeConfig.pad12(context)),
                      decoration: const BoxDecoration(
                          color: whiteColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "PROFILE INFORMATION",
                                style: TextStyle(
                                  color: blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.font16(context),
                                ),
                              ),
                              TextButton(
                                onPressed: () => edit_personal_data(),
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(color: redColor),
                                ),
                              )
                            ],
                          ),
                          profile_text(
                            text: "Name",
                            value: _name,
                          ),
                          profile_text(
                            text: "Age",
                            value: _age.toString(),
                          ),
                          profile_text(
                            text: "Gender",
                            value: _gender,
                          ),
                          profile_text(
                            text: "Diease",
                            value: _disease,
                          ),
                          profile_text(
                            text: "Phone Number",
                            value: _phoneNumber,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                //: _userModel!.userType == UserType.hospital.name ?
                ,
                TileWidget(
                  text: "Settings",
                  trailingImg: Assets.arrowForwardHead,
                  onTap: () => settingsButton(),
                  cardColor: backgroundColor,
                  leadingImg: Assets.settingsIcon,
                  titleTextColor: appTextColor,
                ),
              ])),
        ),
      ),
    );
  }

  Future<void> _getAndSetPatientData() async {
    try {
      _patientModel = await _firestoreController.getPatientData();
      if (_patientModel != null) {
        _name = _patientModel!.name;
        _age = _patientModel!.age;
        _disease = _patientModel!.disease;
        _phoneNumber = _patientModel!.phoneNumber;
        _gender = _patientModel!.gender;
        _email = _patientModel!.email;
      }
    } catch (e) {
      log(e.toString());
    }
    setState(() {});
  }

  Future<void> _getAndSetHospitalData() async {
    try {
      _hospitalModel = await _firestoreController.getHospitalData();
      if (_hospitalModel != null) {
        _name = _hospitalModel!.name;
        _phoneNumber = _hospitalModel!.phoneNumber;
        _email = _hospitalModel!.email;
        // _address = _hospitalModel!.address;
      }
    } catch (e) {
      log(e.toString());
    }
    setState(() {});
  }

  Future<void> _getAndSetDriverData() async {
    // try {
    //   _driverModel =
    //       await _firestoreController.getAvailableDriverDataAHospital();
    //   if (_driverModel != null) {
    //     _email = _driverModel!.email;
    //     _name = _driverModel!.name;
    //     _license = _driverModel!.licenseNumber;
    //   }
    // } catch (e) {
    //   log(e.toString());
    // }
    // setState(() {});
  }

  Future<void> _checkUserType() async {
    try {
      _userModel = await _firestoreController.getUserData();
      if (_userModel != null) {
        if (_userModel!.userType == UserType.patient.name) {
          _getAndSetPatientData();
        } else if (_userModel!.userType == UserType.hospital.name) {
          _getAndSetHospitalData();
        } else {
          _getAndSetDriverData();
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void settingsButton() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> edit_profile_data() async {
    // String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: whiteColor,
              title: const Text("Edit Profile Details"),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text("Are you Sure you want to Reset Password!")
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () => resetpassword,
                    child: const Text("Confirm"))
              ],
            ));
  }

  // ignore: non_constant_identifier_names
  Future<void> edit_personal_data() async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: whiteColor,
              title: const Text("Edit Personal Details"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (value) => Utils.nameValidator(value),
                    decoration: const InputDecoration(
                      hintText: "Enter Name",
                    ),
                    onChanged: (value) {
                      newValue = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      validator: (value) => Utils.ageValidator(value),
                      decoration: const InputDecoration(
                        hintText: "Enter Age",
                      ),
                      onChanged: (value) {
                        newValue = value;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                      decoration: const InputDecoration(
                        hintText: "Enter Gender",
                      ),
                      onChanged: (value) {
                        newValue = value;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      validator: (value) => Utils.diseaseValidator(value),
                      decoration: const InputDecoration(
                        hintText: "Enter Disease",
                      ),
                      onChanged: (value) {
                        newValue = value;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Enter Phone Number",
                      ),
                      onChanged: (value) {
                        newValue = value;
                      }),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(newValue),
                    child: const Text("Save"))
              ],
            ));
  }

  void resetpassword() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
  }
}
