import 'package:hive/hive.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/services/databases/db_helper.dart';

class AssignmentsRepository {
  AssignmentsRepository() {
    _assignmentsDB = Hive.box(DatabaseHelper.ASSIGNMENTS_BOX);
  }

  Box<Assignment> _assignmentsDB;
  int get newID => getAllAssignments().length;

  List<Assignment> getAllAssignments() {
    final List<Assignment> data = _assignmentsDB.values.toList();
    return data ?? <Assignment>[];
  }

  List<Assignment> getAssignmentsFromSubjectID(int subjectID) {
    return getAllAssignments()
        .where((Assignment assignment) => assignment.subjectID == subjectID)
        .toList();
  }

  Future<Assignment> getAssignmentFromID(int id) async {
    return _assignmentsDB.getAt(id);
  }

  void addAssignment(Assignment assignment) {
    _assignmentsDB.add(assignment);
  }

  void deleteAssignment(Assignment assignment) {
    _assignmentsDB.delete(assignment.id);
  }

  void updateAssignment(Assignment assignment) {
    _assignmentsDB.put(assignment.id, assignment);
  }
}
