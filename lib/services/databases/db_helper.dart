import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/adapters/color_adapter.dart';
import 'package:school_life/services/adapters/time_adapter.dart';

class DatabaseHelper {
  static Future<void> initializeHiveBoxes() async {
    await Hive.initFlutter();
    _registerHiveAdapters();
    await Future.wait(<Future<Box<dynamic>>>[
      Hive.openBox<Subject>(Databases.SUBJECTS_BOX),
      Hive.openBox<Assignment>(Databases.ASSIGNMENTS_BOX),
      Hive.openBox<dynamic>(Databases.SETTINGS_BOX),
    ]);
  }

  static void _registerHiveAdapters() {
    Hive.registerAdapter<Color>(ColorAdapter());
    Hive.registerAdapter<TimeOfDay>(TimeAdapter());
    Hive.registerAdapter<Assignment>(AssignmentAdapter());
    Hive.registerAdapter<Subject>(SubjectAdapter());
  }
}

abstract class Databases {
  static const String ASSIGNMENTS_BOX = 'assignments_db';
  static const String SUBJECTS_BOX = 'subjects_db';
  static const String SETTINGS_BOX = 'settings_db';
}
