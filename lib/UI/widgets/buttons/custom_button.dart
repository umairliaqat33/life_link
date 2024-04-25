import 'package:flutter/material.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.buttonColor,
    required this.title,
    required this.onPressed,
  });
  final Color? buttonColor;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: buttonColor ?? primaryColor,
      borderRadius: BorderRadius.circular(10.0),
      elevation: 5.0,
      child: MaterialButton(
        onPressed: () => onPressed(),
        minWidth: SizeConfig.width20(context) * 10,
        height: SizeConfig.height20(context) * 1.5,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: SizeConfig.font18(context),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
