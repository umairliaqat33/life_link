import 'package:flutter/material.dart';
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
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: whiteColor,
          ),
        ),
      ],
    );
  }
}
