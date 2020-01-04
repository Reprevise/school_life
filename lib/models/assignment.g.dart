// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssignmentAdapter extends TypeAdapter<Assignment> {
  @override
  final typeId = 1;

  @override
  Assignment read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Assignment(
      fields[0] as int,
      fields[1] as String,
      fields[2] as DateTime,
      fields[3] as int,
      fields[4] as String,
      fields[5] as dynamic,
      fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Assignment obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.dueDate)
      ..writeByte(3)
      ..write(obj.subjectID)
      ..writeByte(4)
      ..write(obj.details)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.isDeleted);
  }
}
