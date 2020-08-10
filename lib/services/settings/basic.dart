import 'package:hive/hive.dart';
import 'package:school_life/models/settings_defaults.dart';
import 'package:school_life/models/settings_keys.dart';
import 'package:school_life/services/databases/db_helper.dart';

class BasicSettingsHelper {
  BasicSettingsHelper() {
    _settingsBox = Hive.box<dynamic>(Databases.settingsBox);
    _getVariables();
  }

  Box<dynamic> _settingsBox;

  String _firstName = '', _lastName = '';
  String get firstName => _firstName;
  String get lastName => _lastName;

  void _getVariables() {
    _getName();
  }

  void _getName() {
    _firstName = _settingsBox.get(BasicSettingsKeys.firstName,
        defaultValue: BasicSettingsDefaults.firstName) as String;
    _lastName = _settingsBox.get(BasicSettingsKeys.lastName,
        defaultValue: BasicSettingsDefaults.lastName) as String;
  }
}
