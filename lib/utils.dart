import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  Future<DateTime> pickDate(BuildContext context, DateTime date) async {
    final datePicked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2020));
    print(datePicked.toUtc());
    print(datePicked.millisecondsSinceEpoch);
    if (datePicked != null)
      return datePicked;
    else
      return date;
  }

  Future<DateTime> pickTime(BuildContext context, DateTime time) async {
    final timePicked = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 0, minute: 0));
    DateTime todayDate = today();
    if (timePicked != null)
      return todayDate
          .add(Duration(hours: timePicked.hour, minutes: timePicked.minute));
    else
      return time;
  }

  String dateFormatter(DateTime date) {
    final dateFormatter = new DateFormat('dd/MM/yyyy');
    return dateFormatter.format(date);
  }

  String timeFormatter(DateTime time) {
    print(time);
    final dateFormatter = new DateFormat('HH:mm');
    return dateFormatter.format(time);
  }

  DateTime today() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    return today;
  }
}
