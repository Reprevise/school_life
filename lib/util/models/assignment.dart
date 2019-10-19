import 'package:school_life/services/assignments_db/assignments_db.dart';
import 'package:school_life/util/models/subject.dart';

class Assignment {
  int id;
  String name;
  DateTime dueDate;
  Subject subject;
  String details;
  bool isDeleted;

  Assignment(
    this.id,
    this.name,
    this.dueDate,
    this.subject,
    this.details,
    this.isDeleted,
  );

  Assignment.fromJson(Map<String, dynamic> json) {
    id = json[AssignmentDBCreator.ID];
    name = json[AssignmentDBCreator.NAME];
    dueDate = json[AssignmentDBCreator.DUE_DATE];
    subject = json[AssignmentDBCreator.SUBJECT];
    details = json[AssignmentDBCreator.DETAILS];
    isDeleted = json[AssignmentDBCreator.IS_DELETED] == 1;
  }
}
