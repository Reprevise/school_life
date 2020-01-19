import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TimeAdapter extends TypeAdapter<TimeOfDay> {
  @override
  TimeOfDay read(BinaryReader reader) {
    final String string = reader.readString();
    final int startIndex = string.indexOf('(') + 1;
    final String hour = string.substring(startIndex, startIndex + 2);
    final String minute = string.substring(startIndex + 3, startIndex + 4);
    return TimeOfDay(
      hour: int.parse(hour),
      minute: int.parse(minute),
    );
  }

  @override
  void write(BinaryWriter writer, TimeOfDay obj) {
    print('TimeOfDay toString: $obj');
    writer.writeString(obj.toString());
  }

  @override
  int get typeId => 201;
}
