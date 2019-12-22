import 'package:school_life/services/databases/db_helper.dart';
import 'package:sqflite/sqflite.dart';

Database subjectsDB;

class SubjectsDBCreator {
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
      $NAME text not null,
      $ROOM text,
      $BUILDING text,
      $TEACHER text not null,
      $COLOR integer not null,
      $IS_DELETED bit not null
    )''';

    await db.execute(subjectSql);
  }

  Future<void> initDatabase() async {
    final path = await DatabaseHelper.getDBPath('subjects_db');
    subjectsDB = await openDatabase(path, version: 1, onCreate: onCreate);
  }

  Future<void> onCreate(Database db, int version) async {
    await createSubjectsTable(db);
  }
}
