import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;

class SubjectDBCreator {
  static const SUBJECTS_TABLE = 'subjects';
  static const ID = '_id';
  static const NAME = 'name';
  static const ROOM = 'room';
  static const BUILDING = 'building';
  static const TEACHER = 'teacher';
  static const COLOR = 'color';
  static const IS_DELETED = 'isDeleted';

  Future<void> createSubjectsTable(Database db) async {
    final subjectSql = '''CREATE TABLE $SUBJECTS_TABLE
    (
      $ID integer primary key,
      $NAME text,
      $ROOM text,
      $BUILDING text,
      $TEACHER text,
      $COLOR text,
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
    final path = await getDatabasePath('subjects_db');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
  }

  Future<void> onCreate(Database db, int version) async {
    await createSubjectsTable(db);
  }
}
