import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:school_life/services/adapters/color_adapter.dart';

import 'mocks.dart';

void main() {
  group('ColorAdapter', () {
    test('.read()', () {
      const color = Color(0xFF000000);
      final BinaryReader binaryReader = BinaryReaderMock();
      when(binaryReader.readInt()).thenReturn(color.value);

      final readColor = ColorAdapter().read(binaryReader);
      verify(binaryReader.readInt());
      expect(readColor, readColor);
    });

    test('.write()', () {
      const color = Color(0xFF000000);
      final BinaryWriter binaryWriter = BinaryWriterMock();

      ColorAdapter().write(binaryWriter, color);
      verify(binaryWriter.writeInt(color.value));
    });
  });
}