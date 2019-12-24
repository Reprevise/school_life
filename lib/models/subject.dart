import 'package:hive/hive.dart';
import 'package:school_life/services/databases/assignments_repository.dart';
import 'package:school_life/services/databases/subjects_db.dart';
import 'package:school_life/models/assignment.dart';

part 'subject.g.dart';

@HiveType()
class Subject extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String room;
  @HiveField(3)
  String building;
  @HiveField(4)
  String teacher;
  @HiveField(5)
  int colorValue;
  @HiveField(6)
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

  Map<String, dynamic> toDropdownJson() {
    return {'display': name, 'value': id};
  }

  @override
  Future<void> delete() async {
    List<Assignment> assignments =
        await AssignmentsRepository.getAssignmentsFromSubjectID(id);
    assignments.forEach((assignment) => assignment.delete());
    return super.delete();
  }
}
