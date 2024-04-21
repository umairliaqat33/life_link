import 'package:flutter/material.dart';

class Services {
  static Future<TimeOfDay?> timePicker(BuildContext context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return timeOfDay;
  }
}
