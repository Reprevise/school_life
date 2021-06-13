import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../app/app.locator.dart';
import '../services/databases/assignments_repository.dart';
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
    this.schedule,
    this.isDeleted = false,
  });

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
  List<TimeBlock>? schedule;

  @override
  Future<void> delete() async {
    final assignmentsRepo = locator<AssignmentsRepository>();
    final delOps =
        assignmentsRepo.getAssignmentsFromSubjectID(id).map((e) => e.delete());
    await Future.wait(delOps);
    return super.delete();
  }
}
