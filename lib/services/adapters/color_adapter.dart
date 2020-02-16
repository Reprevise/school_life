import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:school_life/services/databases/db_helper.dart';

class ColorAdapter extends TypeAdapter<Color> {
  @override
  Color read(BinaryReader reader) {
    final colorValue = reader.readInt();
    return Color(colorValue);
  }

  @override
  void write(BinaryWriter writer, Color obj) {
    writer.writeInt(obj.value);
  }

  @override
  int get typeId => DatabaseHelper.colorTypeID;
}
