import 'package:flutter/material.dart';
import 'package:life_link/UI/widgets/switchs/custom_switch.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/colors.dart';

class BedCard extends StatefulWidget {
  BedCard({super.key, toggleValue});

  @override
  State<BedCard> createState() => _BedCardState();
}

class _BedCardState extends State<BedCard> {
  bool _toggleValue = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: SizeConfig.width10(context),
          left: SizeConfig.width10(context),
          bottom: 2),
      child: Card(
        child: ListTile(
          title: const Text(
            "BD-0001",
          ),
          leading: const Icon(Icons.bed_rounded),
          subtitle: _toggleValue ? null : Text("Assigned to:"),
          trailing: CustomSwitch(
            activeColor: greenColor,
            inactiveColor: redColor,
            value: _toggleValue,
            onChanged: (value) => _toggleOnChanged(value),
          ),
        ),
      ),
    );
  }

  void _toggleOnChanged(bool toggle) {
    _toggleValue = !_toggleValue;
    setState(() {});
  }
}
