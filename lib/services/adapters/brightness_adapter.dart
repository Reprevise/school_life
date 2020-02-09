import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:school_life/services/databases/db_helper.dart';

class BrightnessAdapter extends TypeAdapter<Brightness> {
  @override
  Brightness read(BinaryReader reader) {
    final bool isLight = reader.readBool();
    return isLight ? Brightness.light : Brightness.dark;
  }

  @override
  void write(BinaryWriter writer, Brightness obj) {
    writer.writeBool(obj == Brightness.light);
  }

  @override
  int get typeId => DatabaseHelper.brightnessTypeID;
}
