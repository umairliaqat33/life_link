import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/incoming_patients_screen/components/incoming_patients_card_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/no_data_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/request_model/request_model.dart';

class IncomingPatientsScreen extends StatelessWidget {
  IncomingPatientsScreen({super.key});
  final FirestoreController _firestoreController = FirestoreController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        title: "Incoming Patients",
        context: context,
        backButton: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder<List<RequestModel>>(
                  stream: _firestoreController.getInProgressRequestStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularLoaderWidget();
                    }
                    if (snapshot.data == null) {
                      return Center(
                        child: Text(
                          "Something went wrong please try again",
                          style: TextStyle(
                            fontSize: SizeConfig.font20(context),
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
                      shrinkWrap: true,
                      itemCount: requestList.length,
                      itemBuilder: (context, index) {
                        return IncomingPatientsCardWidget(
                          requestModel: requestList[index],
                        );
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
