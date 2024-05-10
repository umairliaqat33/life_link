import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/patient_ride_history/components/patient_ride_history_card_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/no_data_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/request_model/request_model.dart';

class RideHistory extends StatefulWidget {
  const RideHistory({super.key});

  @override
  State<RideHistory> createState() => _RideHistoryState();
}

class _RideHistoryState extends State<RideHistory> {
  final FirestoreController _firestoreController = FirestoreController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        title: "Ride History",
        context: context,
        backButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.width15(context) + 1,
          right: SizeConfig.width15(context) + 1,
        ),
        child: StreamBuilder<List<RequestModel>>(
          stream: _firestoreController.getCompletedRequestStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularLoaderWidget();
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text(
                  "Something went wrong please try again",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
            if (snapshot.data != null && snapshot.data!.isEmpty) {
              return const Center(
                child: NoDataWidget(alertText: "No requests yet"),
              );
            }
            List<RequestModel> requestList = snapshot.data!;
            return ListView.builder(
              itemCount: requestList.length,
              itemBuilder: (context, index) {
                return PatientRideHistorCardWidget(
                  requestModel: requestList[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
