import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/history_screen/component/history_card.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(
          title: "History",
          context: context,
          backButton: true,
        ),
        body: Stack(
          children: [
            Container(
                color: appBarColor,
                width: SizeConfig.width(context),
                height: SizeConfig.height(context) / 5,
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
                      "Total Records",
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      HistoryCard(),
                      HistoryCard(),
                      HistoryCard(),
                      HistoryCard(),
                      HistoryCard(),
                      HistoryCard(),
                      HistoryCard(),
                      HistoryCard(),
                      HistoryCard(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
