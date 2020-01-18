import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/services/databases/assignments_repository.dart';

part 'subject.g.dart';

@HiveType(typeId: 2)
class Subject extends HiveObject {
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
  Map<String, List<DateTime>> schedule;

  @override
  Future<void> delete() {
    final List<Assignment> assignments =
        getIt<AssignmentsRepository>().getAssignmentsFromSubjectID(id);
    for (Assignment assignment in assignments) {
      assignment.delete();
    }
    return super.delete();
  }
}
