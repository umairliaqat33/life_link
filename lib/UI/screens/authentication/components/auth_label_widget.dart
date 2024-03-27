import 'package:flutter/material.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/colors.dart';

class AuthLabelWidget extends StatelessWidget {
  const AuthLabelWidget({
    super.key,
    required this.authLabel,
  });
  final String authLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          authLabel,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.font20(context),
            color: whiteColor,
          ),
        ),
      ],
    );
  }
}
