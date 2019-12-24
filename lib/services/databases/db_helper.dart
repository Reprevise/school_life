import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_life/services/databases/assignments_db.dart';
import 'package:school_life/services/databases/subjects_db.dart';

class DatabaseHelper {
  Future<void> initializeDatabases() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await SubjectsDBCreator().init();
    await AssignmentsDBCreator().init();
  }
}
