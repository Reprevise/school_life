import 'package:school_life/services/databases/assignments_db.dart';
import 'package:school_life/services/databases/assignments_repository.dart';

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
    id = json[AssignmentsDBCreator.ID];
    name = json[AssignmentsDBCreator.NAME];
    dueDate = DateTime.parse(json[AssignmentsDBCreator.DUE_DATE]);
    subjectID = json[AssignmentsDBCreator.SUBJECT_ID];
    details = json[AssignmentsDBCreator.DETAILS];
    isDeleted = json[AssignmentsDBCreator.IS_DELETED] == 1;
  }

  Future<void> delete() async {
    AssignmentsRepository.deleteAssignment(this);
  }
}
