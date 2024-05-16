import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/patient_screen/component/oldreports_card.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/no_data_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/report_model/report_model.dart';
import 'package:life_link/utils/colors.dart';

class OldReports extends StatelessWidget {
  OldReports({super.key});

  final FirestoreController _firestoreController = FirestoreController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          title: "Old Reports", context: context, backButton: true),
      body: StreamBuilder<List<ReportModel>>(
        stream: _firestoreController.getReportStreamList(),
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

          List<ReportModel> reportModelList = snapshot.data!;
          return Stack(
            children: [
              Container(
                  color: appBarColor,
                  width: SizeConfig.width(context),
                  height: SizeConfig.height(context) / 4,
                  child: null),
              Center(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.height(context) / 20),
                  child: Column(
                    children: [
                      Text(
                        reportModelList.length.toString(),
                        style: TextStyle(
                            fontSize: SizeConfig.font28(context),
                            fontWeight: FontWeight.bold,
                            color: whiteColor),
                      ),
                      Text(
                        "Total Reports",
                        style: TextStyle(
                            fontSize: SizeConfig.font14(context),
                            fontWeight: FontWeight.bold,
                            color: whiteColor),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.height(context) / 15,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.height(context) / 6,
                ),
                child: ListView.builder(
                  itemCount: reportModelList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return OldReportsCard(
                      reportModel: reportModelList[index],
                      reportIndex: index,
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
