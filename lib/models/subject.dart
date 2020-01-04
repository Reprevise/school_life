import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/single_day_schedule.dart';
import 'package:school_life/services/databases/assignments_repository.dart';

part 'subject.g.dart';

@HiveType(typeId: 2)
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
  Color color;
  @HiveField(6)
  bool isDeleted;
  @HiveField(7)
  List<SingleDaySchedule> schedule;

  Subject(
    this.id,
    this.name,
    this.room,
    this.building,
    this.teacher,
    this.color,
    this.schedule,
    this.isDeleted,
  );

  @override
  Future<void> delete() {
    List<Assignment> assignments =
        getIt<AssignmentsRepository>().getAssignmentsFromSubjectID(id);
    assignments.forEach((assignment) => assignment.delete());
    return super.delete();
  }
}
