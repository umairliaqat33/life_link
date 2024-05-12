import 'package:flutter/material.dart';
import 'package:life_link/UI/widgets/cards/info_card_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/colors.dart';

class HistoryViewingAlert extends StatelessWidget {
  const HistoryViewingAlert({
    super.key,
    required this.name,
    required this.email,
    required this.arrivingDateTime,
    required this.leavingDateTime,
    required this.bedNumber,
    required this.driverName,
    required this.disease,
  });
  final String name;
  final String email;
  final String arrivingDateTime;
  final String leavingDateTime;
  final String bedNumber;
  final String driverName;
  final String disease;

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
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          InfoCardWidget(
            item1: "BD-$bedNumber",
            item2: arrivingDateTime,
            item3: leavingDateTime,
            item4: driverName,
            item5: disease,
            item1Title: 'Bed No',
            item2Title: 'Arriving Date',
            item3Title: 'Leaving Date',
            item4Title: 'Driver',
            item5Title: 'Disease',
          )
        ]),
      ),
    );
  }
}
