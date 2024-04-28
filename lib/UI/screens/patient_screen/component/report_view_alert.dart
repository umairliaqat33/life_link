import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/patient_screen/component/report_info_widget.dart';
import 'package:life_link/utils/colors.dart';

class ReportViewingAlert extends StatelessWidget {
  const ReportViewingAlert({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      backgroundColor: scaffoldColor,
      title: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Syed Moasib",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "syedmoasib@gmail.com",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
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
              bedno: "Bd-25",
              admitDate: "10-04-2024",
              dischargeDate: "10-05-2024",
              checkby: "Dr.Moasib",
              disease: "Fever",
              driver: "Ahmed",
              hospital: "Shalimar",
            )
          ],
        ),
      ),
    );
  }
}
