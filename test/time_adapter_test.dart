import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:school_life/services/adapters/time_adapter.dart';

import 'mocks.dart';

void main() {
  group('TimeOfDayAdapter', () {
    test('.read()', () {
      final TimeOfDay currentTime = TimeOfDay.now();
      final BinaryReader binaryReader = BinaryReaderMock();
      when(binaryReader.readString()).thenReturn(currentTime.toString());

      final TimeOfDay time = TimeAdapter().read(binaryReader);
      verify(binaryReader.readString());
      expect(time, time);
    });

    test('.write()', () {
      final TimeOfDay currentTime = TimeOfDay.now();
      final BinaryWriter binaryWriter = BinaryWriterMock();

      TimeAdapter().write(binaryWriter, currentTime);
      verify(binaryWriter.writeString(currentTime.toString()));
    });
  });
}