import 'package:flutter/material.dart';
import 'package:life_link/config/size_config.dart';
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
            height: SizeConfig.height20(context) * 10,
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
