import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/patient_screen/component/report_info_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/models/report_model/report_model.dart';
import 'package:life_link/utils/colors.dart';

class ReportViewingAlert extends StatelessWidget {
  const ReportViewingAlert({
    super.key,
    required this.reportModel,
    required this.name,
    required this.email,
    required this.arrivingDateTime,
    required this.dischargeDateTime,
    required this.bedNumber,
    required this.driverName,
    required this.disease,
    required this.doctorName,
    required this.hospitalName,
  });
  final ReportModel reportModel;
  final String name;
  final String email;
  final String arrivingDateTime;
  final String dischargeDateTime;
  final String bedNumber;
  final String driverName;
  final String disease;
  final String doctorName;
  final String hospitalName;
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
                    fontSize: SizeConfig.font12(context) + 1,
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
            ReportInfo(
              bedno: bedNumber,
              admitDate: arrivingDateTime,
              dischargeDate: dischargeDateTime,
              checkby: doctorName,
              disease: disease,
              driver: driverName,
              hospital: hospitalName,
              prescription: reportModel.prevention,
            )
          ],
        ),
      ),
    );
  }
}
