// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_link/UI/widgets/buttons/custom_button.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/UI/widgets/text_fields/password_text_field.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/auth_controller.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/exceptions.dart';

class HospitalReSignInAlert extends StatefulWidget {
  const HospitalReSignInAlert({
    super.key,
    required this.hospitalEmail,
    required this.drvierUid,
    required this.hospitalId,
    required this.hospitalName,
    required this.profileImage,
    required this.driverEmail,
    required this.driverName,
    required this.licenseNumber,
    required this.ambulanceRegistration,
    required this.driverPassword,
  });
  final String hospitalEmail;
  final String drvierUid;
  final String hospitalId;
  final String hospitalName;
  final String profileImage;
  final String driverEmail;
  final String driverName;
  final String licenseNumber;
  final String ambulanceRegistration;
  final String driverPassword;
  @override
  State<HospitalReSignInAlert> createState() => _HospitalReSignInAlertState();
}

class _HospitalReSignInAlertState extends State<HospitalReSignInAlert> {
  final TextEditingController _passwordController = TextEditingController();
  bool _showSpinner = false;
  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Icon(
        Icons.security,
        color: primaryColor,
        size: 15,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "sor Security purpose enter your password to verify your identity",
              style: TextStyle(
                color: redColor,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            PasswordTextField(
              controller: _passwordController,
            ),
            SizedBox(
              height: SizeConfig.height8(context),
            ),
            _showSpinner
                ? const CircularLoaderWidget()
                : SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      title: "Done",
                      onPressed: () => _signIn(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    setState(() {
      _showSpinner = true;
    });
    try {
      AuthController authController = AuthController();
      UserCredential? userCredential = await authController.signIn(
        'somehospital@hospital.com',
        _passwordController.text,
      );
      if (userCredential != null) {
        uploadDriver(
          drvierUid: widget.drvierUid,
          hospitalId: widget.hospitalId,
          hospitalName: widget.hospitalName,
          profileImage: widget.profileImage,
          driverEmail: widget.driverEmail,
          driverName: widget.driverName,
          licenseNumber: widget.licenseNumber,
          ambulanceRegistration: widget.ambulanceRegistration,
          driverPassword: widget.driverPassword,
        );
        setState(() {
          _showSpinner = false;
        });
        Navigator.pop(context);
      }
    } on IncorrectPasswordOrUserNotFound catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log(e.message);
    } on NoInternetException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log(e.message);
    } on UnknownException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log(e.message);
    }
    setState(() {
      _showSpinner = false;
    });
  }

  Future<void> uploadDriver({
    required String drvierUid,
    required String hospitalId,
    required String hospitalName,
    required String profileImage,
    required String driverEmail,
    required String driverName,
    required String licenseNumber,
    required String ambulanceRegistration,
    required String driverPassword,
  }) async {
    FirestoreController firestoreController = FirestoreController();

    firestoreController.uploadDriverInformation(
      DriverModel(
        email: driverEmail,
        name: driverName,
        uid: drvierUid,
        licenseNumber: licenseNumber,
        ambulanceRegistrationNo: ambulanceRegistration,
        hospitalId: hospitalId,
        hospitalName: hospitalName,
        profilePicture: profileImage,
        isAvailable: true,
        driverPassword: driverPassword,
        fcmToken: '',
      ),
    );
    Fluttertoast.showToast(msg: "Driver's data saved successfully");
  }
}
