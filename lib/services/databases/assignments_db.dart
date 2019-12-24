import 'package:hive/hive.dart';
import 'package:school_life/models/assignment.dart';

Box<Assignment> assignmentsDB;

class AssignmentsDBCreator {
  static const ASSIGNMENTS_TABLE = 'assignments';
  static const ID = '_id';
  static const NAME = 'name';
  static const DUE_DATE = 'dueDate';
  static const SUBJECT_ID = 'subjectID';
  static const DETAILS = 'details';
  static const IS_DELETED = 'isDeleted';

  Future<void> init() async {
    assignmentsDB = await Hive.openBox<Assignment>('assignments_db');
  }
}
