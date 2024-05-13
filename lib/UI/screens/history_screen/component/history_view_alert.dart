import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/patient_screen/component/report_view_alert.dart';
import 'package:life_link/UI/widgets/cards/info_card_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/models/report_model/report_model.dart';
import 'package:life_link/utils/colors.dart';

class HistoryViewingAlert extends StatelessWidget {
  const HistoryViewingAlert({
    super.key,
    required this.name,
    required this.email,
    required this.arrivingDateTime,
    required this.dischargeDateTime,
    required this.bedNumber,
    required this.driverName,
    required this.disease,
    required this.reportModel,
    required this.doctorName,
    required this.hospitalName,
  });
  final String name;
  final String email;
  final String arrivingDateTime;
  final String dischargeDateTime;
  final String bedNumber;
  final String driverName;
  final String disease;
  final String doctorName;
  final String hospitalName;
  final ReportModel reportModel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: scaffoldColor,
      title: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: SizeConfig.font14(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: SizeConfig.font14(context) - 1,
                    color: greyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InfoCardWidget(
              item1: "BD-$bedNumber",
              item2: arrivingDateTime,
              item3: dischargeDateTime,
              item4: driverName,
              item5: disease,
              item1Title: 'Bed No',
              item2Title: 'Arriving Date',
              item3Title: 'Discharge Date',
              item4Title: 'Driver',
              item5Title: 'Disease',
            ),
            TextButton(
              onPressed: () => _viewReportButton(context),
              child: const Text(
                "View Report",
                style: TextStyle(color: primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _viewReportButton(BuildContext context) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReportViewingAlert(
          reportModel: reportModel,
          name: name,
          email: email,
          arrivingDateTime: arrivingDateTime,
          dischargeDateTime: dischargeDateTime,
          bedNumber: bedNumber,
          driverName: driverName,
          disease: disease,
          doctorName: doctorName,
          hospitalName: hospitalName,
        );
      },
    );
  }
}
