import 'dart:io';

import 'package:path/path.dart';
import 'package:school_life/services/databases/assignments_db.dart';
import 'package:school_life/services/databases/subjects_db.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Future<void> initializeDatabases() async {
    await SubjectsDBCreator().initDatabase();
    await AssignmentsDBCreator().initializeDatabase();
  }

  static Future<String> getDBPath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);
    final pathExists = await Directory(dirname(path)).exists();
    // create directory if it doesn't exist
    if (!pathExists) {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }
}
