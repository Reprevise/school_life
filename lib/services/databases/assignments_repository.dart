import 'package:school_life/models/assignment.dart';
import 'package:school_life/services/databases/assignments_db.dart';

class AssignmentsRepository {
  static Future<List<Assignment>> getAllAssignments() async {
    final data = await assignmentsDB.query(
      AssignmentsDBCreator.ASSIGNMENTS_TABLE,
      where: '${AssignmentsDBCreator.IS_DELETED} = 0',
    );
    List<Assignment> assignments =
        data.map((node) => Assignment.fromJson(node)).toList();

    return assignments;
  }

  static Future<List<Assignment>> getAssignmentsFromSubjectID(
      int subjectID) async {
    final data = await assignmentsDB.query(
      AssignmentsDBCreator.ASSIGNMENTS_TABLE,
      where: '${AssignmentsDBCreator.IS_DELETED} = 0 AND ' +
          '${AssignmentsDBCreator.SUBJECT_ID} = ?',
      whereArgs: [subjectID],
    );
    List<Assignment> assignments = [];

    for (final node in data) {
      final assignment = Assignment.fromJson(node);
      assignments.add(assignment);
    }
    return assignments;
  }

  static Future<Assignment> getAssignment(int id) async {
    final sql = '''SELECT * FROM ${AssignmentsDBCreator.ASSIGNMENTS_TABLE}
    WHERE ${AssignmentsDBCreator.ID} = ?''';

    List<dynamic> params = [id];
    final data = await assignmentsDB.rawQuery(sql, params);

    final assignment = Assignment.fromJson(data.first);
    return assignment;
  }

  static void addAssignment(Assignment assignment) {
    final sql = '''INSERT INTO ${AssignmentsDBCreator.ASSIGNMENTS_TABLE}
    (
      ${AssignmentsDBCreator.ID},
      ${AssignmentsDBCreator.NAME},
      ${AssignmentsDBCreator.DUE_DATE},
      ${AssignmentsDBCreator.SUBJECT_ID},
      ${AssignmentsDBCreator.DETAILS},
      ${AssignmentsDBCreator.IS_DELETED}
    )
    VALUES (?,?,?,?,?,?)''';
    List<dynamic> params = [
      assignment.id,
      assignment.name,
      assignment.dueDate.toString(),
      assignment.subjectID,
      assignment.details,
      assignment.isDeleted ? 1 : 0,
    ];
    assignmentsDB.rawInsert(sql, params);
  }

  static void deleteAssignment(Assignment assignment) {
    final sql = '''UPDATE ${AssignmentsDBCreator.ASSIGNMENTS_TABLE}
    SET ${AssignmentsDBCreator.IS_DELETED} = 1
    WHERE ${AssignmentsDBCreator.ID} == ?''';

    List<dynamic> params = [assignment.id];

    assignmentsDB.rawUpdate(sql, params);
  }

  static void updateAssignment(Assignment assignment) {
    final sql = '''UPDATE ${AssignmentsDBCreator.ASSIGNMENTS_TABLE}
    SET ${AssignmentsDBCreator.NAME} = ?
    SET ${AssignmentsDBCreator.DUE_DATE} = ?
    SET ${AssignmentsDBCreator.SUBJECT_ID} = ?
    SET ${AssignmentsDBCreator.DETAILS} = ?
    WHERE ${AssignmentsDBCreator.ID} == ?''';

    List<dynamic> params = [
      assignment.name,
      assignment.dueDate,
      assignment.subjectID,
      assignment.details,
      assignment.id,
    ];

    assignmentsDB.rawUpdate(sql, params);
  }

  static Future<int> assignmentsCount() async {
    final sql = '''SELECT COUNT(*) FROM 
    ${AssignmentsDBCreator.ASSIGNMENTS_TABLE}''';
    final data = await assignmentsDB.rawQuery(sql);

    int count = data[0].values.elementAt(0);
    int idForNewItem = count++;
    return idForNewItem;
  }
}
