import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../databases/hive_helper.dart';

class TimeAdapter extends TypeAdapter<TimeOfDay> {
  @override
  TimeOfDay read(BinaryReader reader) {
    final read = reader.read();
    var time;
    if (read is DateTime) {
      time = TimeOfDay.fromDateTime(read);
    } else if (read is TimeOfDay) {
      time = read;
    }
    return time;
  }

  @override
  void write(BinaryWriter writer, TimeOfDay obj) {
    writer.write(obj);
  }

  @override
  int get typeId => HiveHelper.timeTypeID;
}
