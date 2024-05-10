import 'package:flutter/material.dart';
import 'package:life_link/UI/widgets/cards/info_card_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/colors.dart';

class RideDetailsAlert extends StatelessWidget {
  const RideDetailsAlert({
    super.key,
    required this.item1,
    required this.item2,
    required this.item3,
    required this.item4,
    required this.item5,
    required this.item1Title,
    required this.item2Title,
    required this.item3Title,
    required this.item4Title,
    required this.item5Title,
    required this.title,
    required this.subtitle,
  });
  final String item1;
  final String item2;
  final String item3;
  final String item4;
  final String item5;
  final String item1Title;
  final String item2Title;
  final String item3Title;
  final String item4Title;
  final String item5Title;
  final String title;
  final String subtitle;
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
                  title,
                  style: TextStyle(
                    fontSize: SizeConfig.font14(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InfoCardWidget(
              item1: item1,
              item2: item2,
              item3: item3,
              item4: item4,
              item5: item5,
              item1Title: item1Title,
              item2Title: item2Title,
              item3Title: item3Title,
              item4Title: item4Title,
              item5Title: item5Title,
            ),
          ],
        ),
      ),
    );
  }
}
