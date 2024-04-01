import 'package:flutter/material.dart';
import 'package:life_link/utils/colors.dart';

class CircularLoaderWidget extends StatelessWidget {
  const CircularLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
      ),
    );
  }
}
