import 'package:flutter/material.dart';

class DateAndTimeService {
  static Future<TimeOfDay?> timePicker(BuildContext context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return timeOfDay;
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
