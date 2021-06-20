import 'package:hive/hive.dart';

import '../services/databases/hive_helper.dart';

part 'assignment.g.dart';

@HiveType(typeId: HiveHelper.assignmentTypeID)
class Assignment extends HiveObject {
  Assignment({
    required this.id,
    required this.name,
    required this.dueDate,
    required this.subjectID,
    required this.details,
    this.completed = false,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  DateTime dueDate;
  @HiveField(3)
  String subjectID;
  @HiveField(4)
  String details;
  @HiveField(5, defaultValue: false)
  bool completed;
}
