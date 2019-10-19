import 'assignments_db.dart';
import 'package:school_life/util/models/assignment.dart';

class RepositoryServiceAssignment {
  static Future<List<Assignment>> getAllAssignments() async {
    final sql = '''SELECT * FROM ${AssignmentDBCreator.ASSIGNMENTS_TABLE}
    WHERE ${AssignmentDBCreator.IS_DELETED} == 0''';
    final data = await db.rawQuery(sql);
    List<Assignment> assignments = List();

    for (final node in data) {
      final assignment = Assignment.fromJson(node);
      assignments.add(assignment);
    }
    return assignments;
  }

  static Future<Assignment> getAssignment(int id) async {
    final sql = '''SELECT * FROM ${AssignmentDBCreator.ASSIGNMENTS_TABLE}
    WHERE ${AssignmentDBCreator.ID} = ?''';

    List<dynamic> params = [id];
    final data = await db.rawQuery(sql, params);

    final assignment = Assignment.fromJson(data.first);
    return assignment;
  }

  static Future<void> addAssignment(Assignment assignment) async {
    final sql = '''INSERT INTO ${AssignmentDBCreator.ASSIGNMENTS_TABLE}
    (
      ${AssignmentDBCreator.ID},
      ${AssignmentDBCreator.NAME},
      ${AssignmentDBCreator.DUE_DATE},
      ${AssignmentDBCreator.SUBJECT},
      ${AssignmentDBCreator.DETAILS},
      ${AssignmentDBCreator.IS_DELETED}
    )
    VALUES (?,?,?,?,?,?,?)''';
    List<dynamic> params = [
      assignment.id,
      assignment.name,
      assignment.dueDate,
      assignment.subject,
      assignment.details,
      assignment.isDeleted ? 1 : 0,
    ];
    await db.rawInsert(sql, params);
  }

  static Future<void> deleteAssignment(Assignment assignment) async {
    final sql = '''UPDATE ${AssignmentDBCreator.ASSIGNMENTS_TABLE}
    SET ${AssignmentDBCreator.IS_DELETED} = 1
    WHERE ${AssignmentDBCreator.ID} == ?
    ''';

    List<dynamic> params = [assignment.id];

    await db.rawUpdate(sql, params);
  }

  static Future<void> updateAssignment(Assignment assignment) async {
    final sql = '''UPDATE ${AssignmentDBCreator.ASSIGNMENTS_TABLE}
    SET ${AssignmentDBCreator.NAME} = ?
    SET ${AssignmentDBCreator.DUE_DATE} = ?
    SET ${AssignmentDBCreator.SUBJECT} = ?
    SET ${AssignmentDBCreator.DETAILS} = ?
    WHERE ${AssignmentDBCreator.ID} == ?
    ''';

    List<dynamic> params = [
      assignment.name,
      assignment.dueDate,
      assignment.subject,
      assignment.details,
      assignment.id,
    ];

    await db.rawUpdate(sql, params);
  }

  static Future<int> assignmentsCount() async {
    final data = await db.rawQuery(
        '''SELECT COUNT(*) FROM ${AssignmentDBCreator.ASSIGNMENTS_TABLE}''');

    int count = data[0].values.elementAt(0);
    int idForNewItem = count++;
    return idForNewItem;
  }
}
