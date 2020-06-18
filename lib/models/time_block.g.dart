// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_block.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeBlockAdapter extends TypeAdapter<TimeBlock> {
  @override
  final typeId = 4;

  @override
  TimeBlock read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeBlock(
      day: fields[0] as String,
      startTime: fields[1] as TimeOfDay,
      endTime: fields[2] as TimeOfDay,
    );
  }

  @override
  void write(BinaryWriter writer, TimeBlock obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeBlockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
