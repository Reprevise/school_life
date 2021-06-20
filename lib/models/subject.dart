import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:school_life/app/app.locator.dart';
import 'package:school_life/services/databases/assignments_repository.dart';

import '../services/databases/hive_helper.dart';
import 'time_block.dart';

part 'subject.g.dart';

@HiveType(typeId: HiveHelper.subjectTypeID)
class Subject extends HiveObject {
  Subject({
    required this.id,
    required this.name,
    required this.room,
    required this.building,
    required this.teacher,
    required this.color,
    this.schedule = const [],
  });

  @HiveField(0)
  String id;
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
  @HiveField(6, defaultValue: [])
  List<TimeBlock> schedule;

  Subject copyWithSchedule({
    List<TimeBlock> newSchedule = const [],
  }) {
    return Subject(
      building: building,
      name: name,
      color: color,
      id: id,
      room: room,
      teacher: teacher,
      schedule: newSchedule,
    );
  }

  @override
  Future<void> delete() async {
    final a = locator<AssignmentsRepository>().getAssignmentsFromSubjectID(id);
    await Future.wait(a.map((e) => e.delete()));
    return super.delete();
  }
}
