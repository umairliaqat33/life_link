import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/history_screen/component/history_info_widget.dart';
import 'package:life_link/utils/colors.dart';

class HistoryViewingAlert extends StatelessWidget {
  const HistoryViewingAlert({
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
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          HistoryInfo(
              bedno: "BD-25",
              comingDate: "12-04-2024",
              dischargeDate: "12-05-2024",
              checkby: "DR.Moasib",
              disease: "Fever")
        ]),
      ),
    );
  }
}
