import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/authentication/login/login_screen.dart';
import 'package:life_link/UI/screens/home_screen/components/user_info_card.dart';
import 'package:life_link/UI/screens/profile_screen/components/edit_profile_screen.dart';

import 'package:life_link/UI/screens/profile_screen/components/tile_widget.dart';
import 'package:life_link/UI/screens/rules_and_terms_screen/rules_and_terms_screen.dart';
import 'package:life_link/UI/widgets/alerts/deletion_alert.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/user_model/user_model.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/enums.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // var userData;
  String? _imageLink;
  String _name = "";
  String _email = "";
  PatientModel? _patientModel;
  HospitalModel? _hospitalModel;
  UserModel? _userModel;
  final FirestoreController _firestoreController = FirestoreController();

  @override
  void initState() {
    super.initState();
    _checkUserType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: TextStyle(
            color: whiteColor,
            fontSize: SizeConfig.font18(context),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
            child: Text(
              "Edit Profile",
              style: TextStyle(
                color: whiteColor,
                fontSize: SizeConfig.font12(context) + 1,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.height12(context),
            ),
            child: Center(
              child: _userModel == null
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularLoaderWidget(),
                    )
                  : UserInfoCard(
                      name: _name,
                      email: _email,
                      imageLink: _imageLink,
                    ),
            ),
          ),
          SizedBox(
            height: SizeConfig.height8(context) * 2,
          ),
          TileWidget(
            text: "Rules and terms",
            trailingImg: Assets.arrowForwardHead,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const RulesAndTermsScreen(),
                ),
              );
            },
            cardColor: backgroundColor,
            titleTextColor: appTextColor,
            leadingImg: null,
          ),
          TileWidget(
            text: "Delete Account",
            trailingImg: Assets.arrowForwardHead,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DeletionAlert(
                    uid: _userModel!.uid,
                    userType: _userModel!.userType == UserType.hospital.name
                        ? UserType.hospital
                        : UserType.patient,
                  );
                },
              );
            },
            cardColor: backgroundColor,
            titleTextColor: appTextColor,
            leadingImg: null,
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.height12(context)),
            child: TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.font14(context),
                      color: redColor,
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Future<void> _getAndSetPatientData() async {
    try {
      _patientModel = await _firestoreController.getPatientData();
      if (_patientModel != null) {
        _name = _patientModel!.name;
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
        _email = _hospitalModel!.email;
        _imageLink = _hospitalModel!.profilePicture;
      }
    } catch (e) {
      log(e.toString());
    }
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _checkUserType() async {
    try {
      _userModel = await _firestoreController.getUserData();
      if (_userModel != null) {
        if (_userModel!.userType == UserType.patient.name) {
          _getAndSetPatientData();
        } else if (_userModel!.userType == UserType.hospital.name) {
          _getAndSetHospitalData();
        }
      }
      setState(() {});
    } catch (e) {
      log(e.toString());
    }
  }
}
