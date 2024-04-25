import 'package:flutter/material.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/models/request_model/request_model.dart';

class RideWaitingScreen extends StatelessWidget {
  const RideWaitingScreen({
    super.key,
    required this.requestModel,
  });
  final RequestModel requestModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          title: "Waiting",
          context: context,
          backButton: true,
        ),
        body: Center(
          child: Column(
            children: [
              Text("Patient Id: ${requestModel.patientId}"),
              Text("Patient Latitude: ${requestModel.patientLat}"),
              Text("Patient Longitude: ${requestModel.patientLon}"),
              Text("Request Id: ${requestModel.requestId}"),
              Text("Request time: ${requestModel.requestTime}"),
            ],
          ),
        ),
      ),
    );
  }
}
