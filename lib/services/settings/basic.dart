import 'package:hive/hive.dart';

import '../../models/settings_defaults.dart';
import '../../models/settings_keys.dart';
import '../databases/hive_helper.dart';

class BasicSettingsHelper {
  late final Box<dynamic> _settingsBox;

  BasicSettingsHelper() {
    _settingsBox = Hive.box<dynamic>(HiveBoxes.settingsBox);
    _initialize();
  }

  String _firstName = '', _lastName = '';
  String get firstName => _firstName;
  String get lastName => _lastName;

  void _initialize() {
    _firstName = _settingsBox.get(
      BasicSettingsKeys.firstName,
      defaultValue: BasicSettingsDefaults.firstName,
    );
    _lastName = _settingsBox.get(
      BasicSettingsKeys.lastName,
      defaultValue: BasicSettingsDefaults.lastName,
    );
  }
}
