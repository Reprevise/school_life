import 'package:hive/hive.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/services/databases/db_helper.dart';

class AssignmentsRepository {
  AssignmentsRepository() {
    _assignmentsDB = Hive.box(Databases.ASSIGNMENTS_BOX);
  }

  Box<Assignment> _assignmentsDB;

  int get newID => allAssignments.length;

  List<Assignment> get allAssignments {
    final List<Assignment> data = _assignmentsDB.values.toList();
    return data ?? <Assignment>[];
  }

  Future<Assignment> getAssignment(int id) async {
    return _assignmentsDB.getAt(id);
  }

  List<Assignment> getAssignmentsFromSubjectID(int subjectID) {
    return allAssignments
        .where((Assignment assignment) => assignment.subjectID == subjectID)
        .toList();
  }

  void addAssignment(Assignment assignment) {
    _assignmentsDB.add(assignment);
  }

  void deleteAssignment(Assignment assignment) {
    _assignmentsDB.delete(assignment.id);
  }
}
