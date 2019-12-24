import 'package:hive/hive.dart';
import 'package:school_life/services/databases/assignments_db.dart';
import 'package:school_life/services/databases/assignments_repository.dart';

part 'assignment.g.dart';

@HiveType()
class Assignment extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  DateTime dueDate;
  @HiveField(3)
  int subjectID;
  @HiveField(4)
  String details;
  @HiveField(5)
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
}
