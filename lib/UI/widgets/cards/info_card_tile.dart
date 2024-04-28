import 'package:flutter/material.dart';

class InfoCardTile extends StatelessWidget {
  const InfoCardTile({
    super.key,
    required this.title,
    required this.valueText,
  });

  final String title;
  final String valueText;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        valueText,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 13,
        ),
      ),
    );
  }
}
