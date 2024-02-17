import 'package:flutter/material.dart';
import 'package:life_link/utils/assets.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
    required this.alertText,
  });
  final String alertText;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            alertText,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: 200,
            child: Image.asset(
              Assets.emptyScreenImage,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
