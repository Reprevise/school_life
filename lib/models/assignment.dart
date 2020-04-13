import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:school_life/services/databases/db_helper.dart';

part 'assignment.g.dart';

@HiveType(typeId: DatabaseHelper.assignmentTypeID)
class Assignment extends HiveObject {
  Assignment({
    @required this.id,
    @required this.name,
    @required this.dueDate,
    @required this.subjectID,
    @required this.details,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  DateTime dueDate;
  @HiveField(3)
  int subjectID;
  @HiveField(4)
  String details;
}
