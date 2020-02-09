import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/services/databases/assignments_repository.dart';
import 'package:school_life/services/databases/db_helper.dart';

part 'subject.g.dart';

@HiveType(typeId: DatabaseHelper.subjectTypeID)
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
  Map<String, List<TimeOfDay>> schedule;

  @override
  Future<void> delete() {
    final List<Assignment> assignments =
        sl<AssignmentsRepository>().getAssignmentsFromSubjectID(id);
    for (final Assignment assignment in assignments) {
      assignment.delete();
    }
    return super.delete();
  }
}
