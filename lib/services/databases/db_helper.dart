import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/holiday.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/adapters/brightness_adapter.dart';
import 'package:school_life/services/adapters/color_adapter.dart';
import 'package:school_life/services/adapters/time_adapter.dart';

class DatabaseHelper {
  // ! valid adapter type ids are 0-223
  // ! valid field numbers are 0-255
  static const int assignmentTypeID = 1;
  static const int subjectTypeID = 2;
  static const int holidayTypeID = 3;
  static const int colorTypeID = 200;
  static const int timeTypeID = 201;
  static const int brightnessTypeID = 202;

  static Future<void> initializeHiveBoxes() async {
    await Hive.initFlutter();
    _registerHiveAdapters();
    await Future.wait([
      Hive.openBox<Subject>(Databases.subjectsBox),
      Hive.openBox<Assignment>(Databases.assignmentsBox),
      Hive.openBox<dynamic>(Databases.settingsBox),
      Hive.openBox<Holiday>(Databases.holidaysBox),
    ]);
  }

  static void _registerHiveAdapters() {
    Hive.registerAdapter<Color>(ColorAdapter());
    Hive.registerAdapter<TimeOfDay>(TimeAdapter());
    Hive.registerAdapter<Brightness>(BrightnessAdapter());
    Hive.registerAdapter<Assignment>(AssignmentAdapter());
    Hive.registerAdapter<Subject>(SubjectAdapter());
    Hive.registerAdapter<Holiday>(HolidayAdapter());
  }
}

abstract class Databases {
  static const String assignmentsBox = 'assignments_db';
  static const String subjectsBox = 'subjects_db';
  static const String settingsBox = 'settings_db';
  static const String holidaysBox = 'holidays_db';
}
