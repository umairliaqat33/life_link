// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/authentication/registration/driver_registration.dart';
import 'package:life_link/UI/screens/authentication/registration/hospital_registration.dart';
import 'package:life_link/UI/screens/authentication/registration/patient_registration.dart';
import 'package:life_link/utils/enums.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({
    super.key,
    required this.userType,
  });
  final UserType userType;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: userType == UserType.driver
            ? const DriverRegistration()
            : userType == UserType.hospital
                ? const HospitalRegistration()
                : const PatientRegistration(),
      ),
    );
  }
}
