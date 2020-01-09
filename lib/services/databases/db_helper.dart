import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/single_day_schedule.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/adapters/color_adapter.dart';

class DatabaseHelper {
  static const String ASSIGNMENTS_BOX = 'assignments_db';
  static const String SUBJECTS_BOX = 'subjects_db';
  static const String SETTINGS_BOX = 'settings_db';

  static Future<void> initializeDatabases() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Color>(ColorAdapter());
    Hive.registerAdapter<Assignment>(AssignmentAdapter());
    Hive.registerAdapter<Subject>(SubjectAdapter());
    Hive.registerAdapter<SingleDaySchedule>(SingleDayScheduleAdapter());
    await Hive.openBox<Subject>(SUBJECTS_BOX);
    await Hive.openBox<Assignment>(ASSIGNMENTS_BOX);
    await Hive.openBox<dynamic>(SETTINGS_BOX);
  }
}
