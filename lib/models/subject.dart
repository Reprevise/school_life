import 'package:hive/hive.dart';
import 'package:school_life/services/databases/assignments_repository.dart';
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

  @override
  Future<void> delete() {
    List<Assignment> assignments =
       AssignmentsRepository.getAssignmentsFromSubjectID(id);
    assignments.forEach((assignment) => assignment.delete());
    return super.delete();
  }
}
