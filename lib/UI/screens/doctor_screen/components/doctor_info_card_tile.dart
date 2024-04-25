import 'package:flutter/material.dart';

class DoctorInfoCardTile extends StatelessWidget {
  const DoctorInfoCardTile({
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
