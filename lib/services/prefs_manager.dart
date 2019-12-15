import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  SharedPreferences prefs;

  PrefsManager() {
    _init();
  }

  Future<void> _init() async {
    prefs = await SharedPreferences.getInstance();
  }

  saveString(String key, String value) async {
    if (prefs == null) await _init();
    prefs.setString(key, value);
  }

  saveStringList(String key, List<String> value) async {
    if (prefs == null) await _init();
    prefs.setStringList(key, value);
  }

  Future<String> getString(String key) async {
    if (prefs == null) await _init();
    return prefs.getString(key);
  }
}

final PrefsManager prefsManager = PrefsManager();
