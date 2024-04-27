import 'package:flutter/material.dart';
import 'package:life_link/utils/colors.dart';

class CircularLoaderWidget extends StatelessWidget {
  const CircularLoaderWidget({
    super.key,
    this.loaderColor = primaryColor,
  });
  final Color loaderColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(loaderColor),
      ),
    );
  }
}
