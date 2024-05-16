import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/auth_controller.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/enums.dart';
import 'package:life_link/utils/exceptions.dart';

class DeletionAlert extends StatelessWidget {
  const DeletionAlert({
    super.key,
    required this.uid,
    required this.userType,
  });
  final String uid;
  final UserType userType;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceBetween,
      title: const Text(
        "Delete data",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
      ),
      content: const SingleChildScrollView(
        child: Center(
          child: Text(
            "*Delete data can not be retrieved again*",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: redColor,
            ),
          ),
        ),
      ),
      actions: [
        MaterialButton(
          color: greyColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "CANCEL",
            style: TextStyle(
              color: whiteColor,
              fontSize: SizeConfig.font12(context),
            ),
          ),
        ),
        MaterialButton(
          color: redColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
          onPressed: () => _deleteAccount(
            uid,
            context,
          ),
          child: Text(
            "DELETE",
            style: TextStyle(
              color: whiteColor,
              fontSize: SizeConfig.font12(context),
            ),
          ),
        ),
      ],
    );
  }

  void _deleteAccount(
    String id,
    BuildContext context,
  ) {
    try {
      FirestoreController firestoreController = FirestoreController();
      AuthController authController = AuthController();
      userType == UserType.driver
          ? firestoreController.deleteDriverData(id)
          : userType == UserType.patient
              ? firestoreController.deletePatientData()
              : userType == UserType.hospital
                  ? firestoreController.deleteHospitalData()
                  : firestoreController.deleteDoctorData(id);

      authController.deleteUserAccountAndData();
      Fluttertoast.showToast(msg: 'Data deletion completed');
      Navigator.of(context).pop();
    } on UnknownException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      Fluttertoast.showToast(msg: 'Data deletion Failed');
    }
  }
}
