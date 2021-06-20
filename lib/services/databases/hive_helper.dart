import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/assignment.dart';
import '../../models/holiday.dart';
import '../../models/subject.dart';
import '../../models/time_block.dart';

class HiveHelper {
  // ! valid adapter type ids are 0-223
  // ! valid field numbers are 0-255
  static const int assignmentTypeID = 1;
  static const int subjectTypeID = 2;
  static const int holidayTypeID = 3;
  static const int timeBlockTypeID = 4;
  static const int brightnessTypeID = 202;
  static const int themeModeTypeID = 203;

  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    _registerHiveAdapters();
    await Future.wait([
      Hive.openBox<Subject>(HiveBoxes.subjectsBox),
      Hive.openBox<Assignment>(HiveBoxes.assignmentsBox),
      Hive.openBox<dynamic>(HiveBoxes.settingsBox),
      Hive.openBox<Holiday>(HiveBoxes.holidaysBox),
    ]);
  }

  static void _registerHiveAdapters() {
    Hive
      ..registerAdapter<Color>(ColorAdapter())
      ..registerAdapter<TimeOfDay>(TimeOfDayAdapter())
      ..registerAdapter<Assignment>(AssignmentAdapter())
      ..registerAdapter<Subject>(SubjectAdapter())
      ..registerAdapter<Holiday>(HolidayAdapter())
      ..registerAdapter<TimeBlock>(TimeBlockAdapter());
  }
}

abstract class HiveBoxes {
  static const String assignmentsBox = 'assignments_db';
  static const String subjectsBox = 'subjects_db';
  static const String settingsBox = 'settings_db';
  static const String holidaysBox = 'holidays_db';
}
