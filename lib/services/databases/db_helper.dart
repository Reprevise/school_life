import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/services/adapters/color_adapter.dart';
import 'package:school_life/services/databases/assignments_db.dart';
import 'package:school_life/services/databases/settings_db.dart';
import 'package:school_life/services/databases/subjects_db.dart';

class DatabaseHelper {
  Future<void> initializeDatabases() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter<Color>(ColorAdapter(), 0);
    Hive.registerAdapter<Assignment>(AssignmentAdapter(), 1);
    Hive.registerAdapter<Subject>(SubjectAdapter(), 2);
    await SubjectsDBCreator().init();
    await AssignmentsDBCreator().init();
    await SettingsDBCreator().init();
  }
}
