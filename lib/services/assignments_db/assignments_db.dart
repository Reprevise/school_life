import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;

class AssignmentDBCreator {
  static const ASSIGNMENTS_TABLE = 'assignments';
  static const ID = '_id';
  static const NAME = 'name';
  static const DUE_DATE = 'dueDate';
  static const SUBJECT = 'subject';
  static const DETAILS = 'details';
  static const IS_DELETED = 'isDeleted';

  Future<void> createAssignmentsTable(Database db) async {
    final subjectSql = '''CREATE TABLE $ASSIGNMENTS_TABLE
    (
      $ID integer primary key,
      $NAME text not null,
      $DUE_DATE text not null,
      $SUBJECT text not null,
      $DETAILS text,
      $IS_DELETED bit not null
    )''';

    await db.execute(subjectSql);
  }

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    // make sure path exists
    if (await Directory(dirname(path)).exists()) {
      // await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath('assignments_db');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
  }

  Future<void> onCreate(Database db, int version) async {
    await createAssignmentsTable(db);
  }
}
