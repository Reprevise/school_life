import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/adapters/color_adapter.dart';

class DatabaseHelper {
  static const ASSIGNMENTS_BOX = 'assignments_db';
  static const SUBJECTS_BOX = 'subjects_db';
  static const SETTINGS_BOX = 'settings_db';

  Future<void> initializeDatabases() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter<Color>(ColorAdapter(), 0);
    Hive.registerAdapter<Assignment>(AssignmentAdapter(), 1);
    Hive.registerAdapter<Subject>(SubjectAdapter(), 2);
    await Hive.openBox<Subject>(SUBJECTS_BOX);
    await Hive.openBox<Assignment>(ASSIGNMENTS_BOX);
    await Hive.openBox(SETTINGS_BOX);
  }
}
