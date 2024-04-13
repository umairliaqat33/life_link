import 'package:flutter/material.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          title: "Manage Doctors",
          context: context,
          backButton: true,
        ),
        body: const Center(
          child: Text(
            "I am Doctors screen",
          ),
        ),
      ),
    );
  }
}
