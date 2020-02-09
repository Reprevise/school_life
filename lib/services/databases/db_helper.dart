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
    await Future.wait(<Future<Box<dynamic>>>[
      Hive.openBox<Subject>(Databases.SUBJECTS_BOX),
      Hive.openBox<Assignment>(Databases.ASSIGNMENTS_BOX),
      Hive.openBox<dynamic>(Databases.SETTINGS_BOX),
      Hive.openBox<Holiday>(Databases.HOLIDAYS_BOX),
    ]);
  }

  static void _registerHiveAdapters() {
    Hive.registerAdapter<Color>(ColorAdapter());
    Hive.registerAdapter<TimeOfDay>(TimeAdapter());
    Hive.registerAdapter<Brightness>(BrightnessAdapter());
    Hive.registerAdapter<Assignment>(AssignmentAdapter());
    Hive.registerAdapter<Subject>(SubjectAdapter());
  }
}

abstract class Databases {
  static const String ASSIGNMENTS_BOX = 'assignments_db';
  static const String SUBJECTS_BOX = 'subjects_db';
  static const String SETTINGS_BOX = 'settings_db';
  static const String HOLIDAYS_BOX = 'holidays_db';
}
