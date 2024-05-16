import 'package:flutter/material.dart';
import 'package:life_link/config/size_config.dart';

class InfoCardTile extends StatelessWidget {
  const InfoCardTile({
    super.key,
    required this.title,
    required this.valueText,
  });

  final String title;
  final String valueText;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: SizeConfig.font14(context),
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        valueText,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: SizeConfig.font12(context) + 1,
        ),
      ),
    );
  }
}
