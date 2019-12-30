import 'package:hive/hive.dart';

class SettingsDBCreator {
  static const SETTINGS_BOX = 'settings_db';

  Future<void> init() async {
    await Hive.openBox(SETTINGS_BOX);
  }
}
