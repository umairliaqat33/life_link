import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateAndTimeService {
  static Future<TimeOfDay?> timePicker(BuildContext context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return timeOfDay;
  }

  static String timeToString(TimeOfDay? timeOfDay) {
    String time = '';
    if (timeOfDay != null) {
      DateTime now = DateTime.now();
      time = DateFormat('hh:mm a').format(
        DateTime(
            now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute),
      );
      log(timeOfDay.toString());
      log(time);
    }
    return time;
  }

  static Future<DateTime?> datePicker(
    bool isDateOfBirth,
    BuildContext context,
  ) {
    return showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: isDateOfBirth ? DateTime(1900) : DateTime.now(),
            lastDate: isDateOfBirth ? DateTime.now() : DateTime(2030))
        .then(
      (pickedDate) {
        if (pickedDate != null) {
          return pickedDate;
        } else if (pickedDate == null) {
          return null;
        }
        return null;
      },
    );
  }
}
