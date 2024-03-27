import 'package:flutter/cupertino.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/colors.dart';

class LayerOne extends StatelessWidget {
  const LayerOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.width(context),
      height: SizeConfig.height(context),
      decoration: const BoxDecoration(
        color: greyColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.0),
          topRight: Radius.circular(60.0),
        ),
      ),
    );
  }
}
