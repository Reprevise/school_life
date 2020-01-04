// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_day_schedule.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SingleDayScheduleAdapter extends TypeAdapter<SingleDaySchedule> {
  @override
  final typeId = 3;

  @override
  SingleDaySchedule read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SingleDaySchedule(
      fields[0] as int,
      fields[1] as TimeOfDay,
      fields[2] as TimeOfDay,
    );
  }

  @override
  void write(BinaryWriter writer, SingleDaySchedule obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime);
  }
}
