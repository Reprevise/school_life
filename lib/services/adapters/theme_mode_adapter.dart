import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../databases/hive_helper.dart';

class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  ThemeMode read(BinaryReader reader) {
    return reader.read();
  }

  @override
  void write(BinaryWriter writer, ThemeMode obj) {
    writer.write(obj);
  }

  @override
  int get typeId => HiveHelper.themeModeTypeID;
}
