import 'package:school_life/services/databases/assignments_repository.dart';
import 'package:school_life/services/databases/subjects_db.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

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
    id = json[SubjectsDBCreator.ID];
    name = json[SubjectsDBCreator.NAME];
    room = json[SubjectsDBCreator.ROOM];
    building = json[SubjectsDBCreator.BUILDING];
    teacher = json[SubjectsDBCreator.TEACHER];
    colorValue = json[SubjectsDBCreator.COLOR];
    isDeleted = json[SubjectsDBCreator.IS_DELETED] == 1;
  }

  Map<String, dynamic> toDBJson() {
    return {
      SubjectsDBCreator.ID: id,
      SubjectsDBCreator.NAME: name,
      SubjectsDBCreator.ROOM: room,
      SubjectsDBCreator.BUILDING: building,
      SubjectsDBCreator.TEACHER: teacher,
      SubjectsDBCreator.COLOR: colorValue,
      SubjectsDBCreator.IS_DELETED: isDeleted ? 1 : 0,
    };
  }

  Map<String, dynamic> toDBUpdatableValuesJson() {
    return {
      SubjectsDBCreator.NAME: name,
      SubjectsDBCreator.ROOM: room,
      SubjectsDBCreator.BUILDING: building,
      SubjectsDBCreator.TEACHER: teacher,
      SubjectsDBCreator.COLOR: colorValue,
    };
  }

  Map<String, dynamic> toSelectJson() {
    return {'display': name, 'value': id};
  }

  Future<void> delete() async {
    List<Assignment> assignments =
        await AssignmentsRepository.getAssignmentsFromSubjectID(id);
    assignments.forEach((assignment) => assignment.delete());
    SubjectsRepository.deleteSubject(this);
  }
}
