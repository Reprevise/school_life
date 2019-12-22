import 'package:flutter/material.dart';

extension BetterDates on DateTime {
  DateTime get todaysDate => DateTime(year, month, day);
  TimeOfDay get currentTime => TimeOfDay.fromDateTime(this);
  DateTime addYears(int years) => this.add(Duration(days: 365 * years));
}
