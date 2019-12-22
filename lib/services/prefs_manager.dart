import 'package:school_life/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  SharedPreferences prefs;

  PrefsManager() {
    _init().then((_) => getIt.signalReady(this));
  }

  Future<void> _init() async {
    prefs = await SharedPreferences.getInstance();
  }

  saveString(String key, String value) async {
    prefs ?? await _init();
    prefs.setString(key, value);
  }

  saveStringList(String key, List<String> value) async {
    prefs ?? await _init();
    prefs.setStringList(key, value);
  }

  Future<String> getString(String key) async {
    prefs ?? await _init();
    return prefs.getString(key);
  }
}
