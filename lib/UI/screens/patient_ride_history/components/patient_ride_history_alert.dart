import 'package:flutter/material.dart';
import 'package:life_link/UI/widgets/cards/info_card_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/colors.dart';

class RideDetailsAlert extends StatelessWidget {
  const RideDetailsAlert({
    super.key,
    required this.pickupTime,
    required this.bedNumber,
    required this.disease,
    required this.ambulanceNumber,
    required this.dropOffTime,
    required this.hospitalName,
    required this.hospitalAddress,
  });
  final String pickupTime;
  final String bedNumber;
  final String disease;
  final String ambulanceNumber;
  final String dropOffTime;
  final String hospitalName;
  final String hospitalAddress;
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
                  hospitalName,
                  style: TextStyle(
                    fontSize: SizeConfig.font14(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  hospitalAddress,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: SizeConfig.font12(context),
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
            item1: pickupTime,
            item2: dropOffTime,
            item3: disease,
            item4: ambulanceNumber,
            item5: bedNumber,
            item1Title: 'Pickup Time:',
            item2Title: 'Drop-off time',
            item3Title: 'Disease',
            item4Title: 'Ambulance No:',
            item5Title: 'Bed Number:',
          )
        ]),
      ),
    );
  }
}
