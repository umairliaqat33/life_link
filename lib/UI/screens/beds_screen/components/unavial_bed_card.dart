import 'package:flutter/material.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/colors.dart';

class UnAvailBedCard extends StatelessWidget {
  const UnAvailBedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: SizeConfig.width10(context),
          left: SizeConfig.width10(context),
          bottom: 2),
      child: Card(
        child: ListTile(
            title: Text(
              "BD-0001",
              style: TextStyle(fontSize: SizeConfig.font18(context)),
            ),
            leading: const Icon(Icons.bed_rounded),
            subtitle: const Text("Assigned to:"),
            trailing: Text(
              "UnAvailable",
              style: TextStyle(
                  color: redColor, fontSize: SizeConfig.font14(context)),
            )),
      ),
    );
  }
}
