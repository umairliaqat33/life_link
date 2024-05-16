import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/treatment_ni_process_screen/component/treatment_in_process_card.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/no_data_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/utils/colors.dart';

class TreatmentInProcessScreen extends StatelessWidget {
  TreatmentInProcessScreen({super.key});
  final FirestoreController _firestoreController = FirestoreController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        title: "Treatment In Process",
        context: context,
        backButton: true,
      ),
      body: StreamBuilder<List<RequestModel>>(
        stream: _firestoreController.getInTreatmentRequestStream(),
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
              child: NoDataWidget(alertText: "No history yet"),
            );
          }
          List<RequestModel> requestList = snapshot.data!;
          return Stack(
            children: [
              Container(
                color: appBarColor,
                width: SizeConfig.width(context),
                height: SizeConfig.height(context) / 5,
                child: null,
              ),
              Center(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.height(context) / 20),
                  child: Column(
                    children: [
                      Text(
                        requestList.length.toString(),
                        style: TextStyle(
                            fontSize: SizeConfig.font28(context),
                            fontWeight: FontWeight.bold,
                            color: whiteColor),
                      ),
                      Text(
                        "Total Records",
                        style: TextStyle(
                            fontSize: SizeConfig.font14(context),
                            fontWeight: FontWeight.bold,
                            color: whiteColor),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.height(context) / 6,
                  ),
                  child: ListView.builder(
                    itemCount: requestList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TreatmentInProcessCard(
                        requestModel: requestList[index],
                      );
                    },
                  )),
            ],
          );
        },
      ),
    );
  }
}
