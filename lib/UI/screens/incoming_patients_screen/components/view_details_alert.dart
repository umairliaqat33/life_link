import 'package:flutter/material.dart';
import 'package:life_link/UI/widgets/cards/info_card_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/colors.dart';

class ViewIncomingPatientDetailsAlert extends StatelessWidget {
  const ViewIncomingPatientDetailsAlert({
    super.key,
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.disease,
    required this.bedAssigned,
    required this.oldReportsLink,
  });
  final String name;
  final String email;
  final String age;
  final String gender;
  final String disease;
  final String bedAssigned;
  final String oldReportsLink;
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
            item1: age,
            item2: gender,
            item3: disease,
            item4: "BD-$bedAssigned",
            item5: oldReportsLink,
            item1Title: 'Patient Age:',
            item2Title: 'Patient Gender:',
            item3Title: 'Disease',
            item4Title: 'Bed Assigned',
            item5Title: 'Old Reports',
          )
        ]),
      ),
    );
  }
}
