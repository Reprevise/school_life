import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'single_day_schedule.g.dart';

@HiveType(typeId: 3)
class SingleDaySchedule {
  SingleDaySchedule(this.day, this.startTime, this.endTime);

  @HiveField(0)
  int day;
  @HiveField(1)
  TimeOfDay startTime;
  @HiveField(2)
  TimeOfDay endTime;
}
