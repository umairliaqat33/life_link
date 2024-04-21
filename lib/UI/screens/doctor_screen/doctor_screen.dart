import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_link/UI/screens/doctor_adding_screen/doctor_adding_screen.dart';
import 'package:life_link/UI/screens/doctor_screen/components/doctor_card_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/no_data_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/doctor_model/doctor_model.dart';
import 'package:life_link/utils/colors.dart';

class DoctorScreen extends StatelessWidget {
  DoctorScreen({super.key});
  final FirestoreController _firestoreController = FirestoreController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          title: "Manage Doctors",
          context: context,
          backButton: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const DoctorAddingScreen(),
              ),
            );
          },
          child: const Icon(
            Icons.add,
            color: whiteColor,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.width10(context),
            right: SizeConfig.width10(context),
          ),
          child: StreamBuilder<List<DoctorModel?>>(
              stream: _firestoreController.getDoctorStreamList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularLoaderWidget();
                }
                if (snapshot.data!.isEmpty) {
                  return const NoDataWidget(alertText: "No Doctors Found");
                }
                if (snapshot.hasError) {
                  return const Text(
                    "Something went wrong please try again",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }

                List<DoctorModel?>? doctorList = snapshot.data;
                return ListView.builder(
                  itemCount: doctorList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DoctorCardWidget(
                      doctorModel: doctorList[index]!,
                      isAvailable:
                          _checkAvailability(doctorList[index]!.leavingTime),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }

  bool _checkAvailability(String closingTime) {
    // Get current time
    DateTime currentTime = DateTime.now();

    DateFormat format = DateFormat("hh:mm a");
    DateTime closingDateTime = format.parse(closingTime);
    bool isAvailable = currentTime.hour < closingDateTime.hour ||
        (currentTime.hour == closingDateTime.hour &&
            currentTime.minute < closingDateTime.minute) ||
        (currentTime.hour == closingDateTime.hour &&
            currentTime.minute == closingDateTime.minute);
    log(isAvailable.toString());

    return isAvailable;
  }
}
