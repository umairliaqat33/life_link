import 'package:flutter/material.dart';
import 'package:life_link/UI/widgets/cards/info_card_widget.dart';
import 'package:life_link/utils/colors.dart';

class RideDetailsAlert extends StatelessWidget {
  const RideDetailsAlert({
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
            item1: "5:00PM",
            item2: "Mall Road",
            item3: "Fever",
            item4: "LE-444",
            item5: "0312515158",
            item1Title: 'Pickup Time:',
            item2Title: 'Pickup Location:',
            item3Title: 'Disease',
            item4Title: 'Ambulance No:',
            item5Title: 'Rider Phone No:',
          )
        ]),
      ),
    );
  }
}
