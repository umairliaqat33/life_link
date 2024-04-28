import 'package:flutter/material.dart';
import 'package:life_link/UI/widgets/cards/info_card_widget.dart';
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
          InfoCardWidget(
            item1: "BD-25",
            item2: "12-04-2024",
            item3: "12-05-2024",
            item4: "DR.Moasib",
            item5: "Fever",
            item1Title: 'Bed No',
            item2Title: 'Arriving Date',
            item3Title: 'Arriving Date',
            item4Title: 'Checked By',
            item5Title: 'Disease',
          )
        ]),
      ),
    );
  }
}
