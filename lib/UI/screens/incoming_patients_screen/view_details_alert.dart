import 'package:flutter/material.dart';
import 'package:life_link/UI/widgets/cards/info_card_widget.dart';
import 'package:life_link/utils/colors.dart';

class ViewDetailsAlert extends StatelessWidget {
  const ViewDetailsAlert({
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
                  "Numan",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "numan123@gmail.com",
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
            item1: "Numan",
            item2: "Fever",
            item3: "Fever",
            item4: "DR.Moasib",
            item5: "Bacterial infections, Continuous fever, infections",
            item1Title: 'Patient Name:',
            item2Title: 'Hospital Name:',
            item3Title: 'Disease',
            item4Title: 'Checked By',
            item5Title: 'Old Reports',
          )
        ]),
      ),
    );
  }
}
