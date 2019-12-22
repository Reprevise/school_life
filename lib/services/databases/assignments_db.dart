import 'package:school_life/services/databases/db_helper.dart';
import 'package:sqflite/sqflite.dart';

Database assignmentsDB;

class AssignmentsDBCreator {
  static const ASSIGNMENTS_TABLE = 'assignments';
  static const ID = '_id';
  static const NAME = 'name';
  static const DUE_DATE = 'dueDate';
  static const SUBJECT_ID = 'subjectID';
  static const DETAILS = 'details';
  static const IS_DELETED = 'isDeleted';

  Future<void> createAssignmentsTable(Database db) async {
    final subjectSql = '''CREATE TABLE $ASSIGNMENTS_TABLE
    (
      $ID integer primary key,
      $NAME text not null,
      $DUE_DATE text not null,
      $SUBJECT_ID integer not null,
      $DETAILS text,
      $IS_DELETED bit not null
    )''';

    await db.execute(subjectSql);
  }

  Future<void> initializeDatabase() async {
    final path = await DatabaseHelper.getDBPath('assignments_db');
    assignmentsDB = await openDatabase(path, version: 1, onCreate: onCreate);
  }

  Future<void> onCreate(Database db, int version) async {
    await createAssignmentsTable(db);
  }
}
