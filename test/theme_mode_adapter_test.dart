import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:school_life/services/adapters/theme_mode_adapter.dart';

import 'mocks.dart';

void main() {
  group('ThemeMode adapter', () {
    test('.read()', () {
      final mode = ThemeMode.light;
      final BinaryReader binaryReader = BinaryReaderMock();
      when(binaryReader.read()).thenReturn(mode);

      final readMode = ThemeModeAdapter().read(binaryReader);
      verify(binaryReader.read());
      expect(readMode, mode);
    });
    test('.write()', () {
      final mode = ThemeMode.light;
      final BinaryWriter binaryWriter = BinaryWriterMock();

      ThemeModeAdapter().write(binaryWriter, mode);
      verify(binaryWriter.write(mode));
    });
  });
}
