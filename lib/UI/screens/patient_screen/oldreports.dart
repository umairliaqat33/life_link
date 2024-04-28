import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/patient_screen/component/oldreports_card.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/colors.dart';

class OldReports extends StatefulWidget {
  const OldReports({super.key});

  @override
  State<OldReports> createState() => _OldReportsState();
}

class _OldReportsState extends State<OldReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(
            title: "Old Reports", context: context, backButton: true),
        body: Stack(children: [
          Container(
              color: appBarColor,
              width: SizeConfig.width(context),
              height: SizeConfig.height(context) / 4,
              child: null),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: SizeConfig.height(context) / 20),
              child: Column(
                children: [
                  Text(
                    "10",
                    style: TextStyle(
                        fontSize: SizeConfig.font28(context),
                        fontWeight: FontWeight.bold,
                        color: whiteColor),
                  ),
                  Text(
                    "Total Reports",
                    style: TextStyle(
                        fontSize: SizeConfig.font14(context),
                        fontWeight: FontWeight.bold,
                        color: whiteColor),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.height(context) / 15,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.height(context) / 6,
            ),
            child: const SingleChildScrollView(
              child: Column(
                children: [
                  OldReportsCard(),
                  OldReportsCard(),
                  OldReportsCard(),
                  OldReportsCard(),
                  OldReportsCard(),
                  OldReportsCard()
                ],
              ),
            ),
          )
        ]));
  }
}
