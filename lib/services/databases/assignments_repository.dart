import 'package:school_life/models/assignment.dart';
import 'package:school_life/services/databases/assignments_db.dart';

class AssignmentsRepository {
  static int get newID => getAllAssignments().length;

  static List<Assignment> getAllAssignments() {
    final List<Assignment> data = assignmentsDB.values.toList();
    return data ?? [];
  }

  static List<Assignment> getAssignmentsFromSubjectID(int subjectID) {
    return getAllAssignments()
        .where((assignment) => assignment.subjectID == subjectID).toList() ?? [];
  }

  static Future<Assignment> getAssignmentFromID(int id) async {
    return assignmentsDB.getAt(id);
  }

  static void addAssignment(Assignment assignment) {
    assignmentsDB.add(assignment);
  }

  static void deleteAssignment(Assignment assignment) {
    assignmentsDB.delete(assignment.id);
  }

  static void updateAssignment(Assignment assignment) {
    assignmentsDB.put(assignment.id, assignment);
  }
}
