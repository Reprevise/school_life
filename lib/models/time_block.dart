import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:school_life/services/databases/db_helper.dart';

part 'time_block.g.dart';

@HiveType(typeId: DatabaseHelper.timeBlockTypeID)
class TimeBlock extends HiveObject {
  TimeBlock({
    @required this.day,
    @required this.startTime,
    @required this.endTime,
  });

  @HiveField(0)
  String day;
  @HiveField(1)
  TimeOfDay startTime;
  @HiveField(2)
  TimeOfDay endTime;
}
