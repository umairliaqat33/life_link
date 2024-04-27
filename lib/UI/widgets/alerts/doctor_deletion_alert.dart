import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/exceptions.dart';

class DoctorDeletionAlert extends StatelessWidget {
  const DoctorDeletionAlert({
    super.key,
    required this.uid,
  });
  final String uid;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceBetween,
      title: const Text(
        "Delete doctor data",
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
          onPressed: () => _deleteDoctor(
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

  void _deleteDoctor(
    String id,
    BuildContext context,
  ) {
    try {
      FirestoreController firestoreController = FirestoreController();
      firestoreController.deleteDoctorData(id);
      Fluttertoast.showToast(msg: 'Data deletion completed');
      Navigator.of(context).pop();
    } on UnknownException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      Fluttertoast.showToast(msg: 'Data deletion Failed');
    }
  }
}