import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  final Color activeColor;
  final Color inactiveColor;
  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(width: 8.0),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: activeColor,
              inactiveThumbColor: inactiveColor,
            ),
          ),
        ],
      ),
    );
  }
}
