import 'package:school_life/services/assignments_db/repo_service_assignment.dart';
import 'package:school_life/services/subjects_db/repo_service_subject.dart';
import 'package:school_life/services/subjects_db/subjects_db.dart';
import 'package:school_life/models/assignment.dart';

class Subject {
  int id;
  String name;
  String room;
  String building;
  String teacher;
  int colorValue;
  bool isDeleted;

  Subject(
    this.id,
    this.name,
    this.room,
    this.building,
    this.teacher,
    this.colorValue,
    this.isDeleted,
  );

  Subject.fromJson(Map<String, dynamic> json) {
    id = json[SubjectDBCreator.ID];
    name = json[SubjectDBCreator.NAME];
    room = json[SubjectDBCreator.ROOM];
    building = json[SubjectDBCreator.BUILDING];
    teacher = json[SubjectDBCreator.TEACHER];
    colorValue = json[SubjectDBCreator.COLOR];
    isDeleted = json[SubjectDBCreator.IS_DELETED] == 1;
  }

  Map<String, dynamic> toJson() {
    return {'display': name, 'value': id};
  }

  Future<void> delete() async {
    List<Assignment> assignments =
        await RepositoryServiceAssignment.getAllAssociatedAssignments(id);
    for (Assignment _assignment in assignments) {
      _assignment.delete();
    }
    RepositoryServiceSubject.deleteSubject(this);
  }
}
