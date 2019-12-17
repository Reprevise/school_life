import 'package:school_life/services/assignments_db/assignments_db.dart';
import 'package:school_life/services/assignments_db/repo_service_assignment.dart';

class Assignment {
  int id;
  String name;
  DateTime dueDate;
  int subjectID;
  String details;
  bool isDeleted;

  Assignment(
    this.id,
    this.name,
    this.dueDate,
    this.subjectID,
    this.details,
    this.isDeleted,
  );

  Assignment.fromJson(Map<String, dynamic> json) {
    id = json[AssignmentDBCreator.ID];
    name = json[AssignmentDBCreator.NAME];
    dueDate = DateTime.parse(json[AssignmentDBCreator.DUE_DATE]);
    subjectID = json[AssignmentDBCreator.SUBJECT_ID];
    details = json[AssignmentDBCreator.DETAILS];
    isDeleted = json[AssignmentDBCreator.IS_DELETED] == 1;
  }

  Future<void> delete() async {
    await RepositoryServiceAssignment.deleteAssignment(this);
  }
}
