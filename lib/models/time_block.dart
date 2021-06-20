import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../services/databases/hive_helper.dart';

part 'time_block.g.dart';

@HiveType(typeId: HiveHelper.timeBlockTypeID)
class TimeBlock {
  TimeBlock({
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  @HiveField(0)
  String day;
  @HiveField(1)
  TimeOfDay startTime;
  @HiveField(2)
  TimeOfDay endTime;
}
