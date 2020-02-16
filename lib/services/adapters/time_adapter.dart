import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:school_life/services/databases/db_helper.dart';

class TimeAdapter extends TypeAdapter<TimeOfDay> {
  @override
  TimeOfDay read(BinaryReader reader) {
    final time = reader.read() as TimeOfDay;
    return time;
  }

  @override
  void write(BinaryWriter writer, TimeOfDay obj) {
    writer.write(obj);
  }

  @override
  int get typeId => DatabaseHelper.timeTypeID;
}
