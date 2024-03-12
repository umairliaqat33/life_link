import 'package:flutter/material.dart';
import 'package:life_link/config/size_config.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonColor,
    required this.title,
    required this.onPressed,
  });
  final Color buttonColor;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: buttonColor,
      borderRadius: BorderRadius.circular(10.0),
      elevation: 5.0,
      child: MaterialButton(
        onPressed: () => onPressed(),
        minWidth: 200.0,
        height: 60.0,
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
