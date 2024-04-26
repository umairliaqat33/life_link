import 'dart:developer';

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:life_link/UI/screens/profile_screen/components/profile_text.dart';
// import 'package:life_link/UI/screens/profile_screen/components/info_card.dart';
import 'package:life_link/UI/screens/profile_screen/components/tile_widget.dart';
import 'package:life_link/UI/screens/settings_screen/settings_screen.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
// import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
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
  PatientModel? _patientModel;
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.height8(context) * 2,
                ),
                Center(
                  child: Stack(children: [
                    CircleAvatar(
                      backgroundImage: null,
                      radius: 75.0,
                    ),
                    Positioned(
                      left: 80,
                      bottom: -10,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit),
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
                TileWidget(
                  text: "Settings",
                  trailingImg: Assets.arrowForwardHead,
                  onTap: () => settingsButton(),
                  cardColor: backgroundColor,
                  leadingImg: Assets.settingsIcon,
                  titleTextColor: appTextColor,
                ),
                // TileWidget(
                //   text: getUserType() == UserType.driver.name
                //       ? AppStrings.favoriteBusinesses
                //       : AppStrings.favoriteDrivers,
                //   trailingImg: Assets.arrowForwardHead,
                //   onTap: null,
                //   cardColor: backgroundColor,
                //   leadingImg: Assets.favoriteIcon,
                //   titleTextColor: appTextColor,
                // ),
                // const TileWidget(
                //   text: "Help",
                //   trailingImg: Assets.arrowForwardHead,
                //   onTap: null,
                //   cardColor: backgroundColor,
                //   leadingImg: Assets.helpIcon,
                //   titleTextColor: appTextColor,
                // ),
              ],
            ),
          ),
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

  Future<void> _checkUserType() async {
    try {
      _userModel = await _firestoreController.getUserData();
      if (_userModel != null) {
        if (_userModel!.userType == UserType.patient.name) {
          _getAndSetPatientData();
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // ProgressCard _createProgressCard(String userRole, int position) {
  //   String image;
  //   String data;
  //   if (userRole == AppStrings.roleBusiness) {
  //     if (position == 0) {
  //       image = Assets.iconParkSolid;
  //       data = AppStrings.roleBusiness;
  //     } else {
  //       image = Assets.iconBoldTruck;
  //       data = AppStrings.subscription;
  //     }
  //   } else {
  //     if (position == 0) {
  //       image = Assets.smallTickMark;
  //       data =
  //           //  userData.data == null ? "0 Jobs done" :
  //           "83 jobs";
  //     } else {
  //       image = Assets.smallStar;
  //       data =
  //           //  userData.data == null ? "0/0" :
  //           "4.5/5";
  //     }
  //   }
  //   return ProgressCard(
  //     imageLink: image,
  //     text: data,
  //   );
  // }
  void settingsButton() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> edit_profile_data() async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: whiteColor,
              title: const Text("Edit Profile Details"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (value) => Utils.emailValidator(value),
                    decoration: const InputDecoration(
                      hintText: "Enter New Email",
                    ),
                    onChanged: (value) {
                      newValue = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      validator: (value) => Utils.passwordValidator(value),
                      decoration: const InputDecoration(
                        hintText: "Enter New Password",
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
}
