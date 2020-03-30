import 'package:flutter/material.dart';
import 'package:school_life/models/subject.dart';

class Validators {
  /// Verify a field's trimmed val. is less than the set max
  static String maxLength(String value, int maxLength) {
    if (value.trim().length > maxLength) {
      return 'Shorten to $maxLength charactersa';
    }
    return null;
  }

  /// Ensure field doesn't have the same start time as another subject
  static String notSameStartTime(
    TimeOfDay time,
    String selectedDay,
    List<Subject> subjects,
  ) {
    for (final subject in subjects) {
      // TODO: ensure a class is not within another class
      if (subject.schedule[selectedDay][0] == time) {
        return 'Same start time';
      }
    }
    return null;
  }
}
