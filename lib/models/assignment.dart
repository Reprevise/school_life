import 'package:hive/hive.dart';

part 'assignment.g.dart';

@HiveType()
class Assignment extends HiveObject {
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
  @HiveField(5)
  bool isDeleted;

  Assignment(
    this.id,
    this.name,
    this.dueDate,
    this.subjectID,
    this.details,
    this.isDeleted,
  );
}
