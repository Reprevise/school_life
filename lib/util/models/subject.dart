import 'package:school_life/services/subjects_db/subjects_db.dart';

class Subject {
  int id;
  String name;
  String room;
  String building;
  String teacher;
  String color;
  bool isDeleted;

  Subject(
    this.id,
    this.name,
    this.room,
    this.building,
    this.teacher,
    this.color,
    this.isDeleted,
  );

  Subject.fromJson(Map<String, dynamic> json) {
    id = json[SubjectDBCreator.ID];
    name = json[SubjectDBCreator.NAME];
    room = json[SubjectDBCreator.ROOM];
    building = json[SubjectDBCreator.BUILDING];
    teacher = json[SubjectDBCreator.TEACHER];
    color = json[SubjectDBCreator.COLOR];
    isDeleted = json[SubjectDBCreator.IS_DELETED] == 1;
  }

  Map<String, dynamic> toJson() {
    return {'display': name, 'value': id};
  }
}
