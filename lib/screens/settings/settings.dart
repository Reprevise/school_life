import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:school_life/services/android_details.dart';
import 'package:school_life/services/theme_service.dart';
import 'package:school_life/theme/themes.dart';

import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/widgets/drawer/custom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeKeys { LIGHT, DARK }

class SettingsPage extends StatefulWidget {
  final AndroidDetails details = AndroidDetails();

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool canChangeTheme = false;
  ThemeKeys currentTheme = ThemeKeys.LIGHT;

  @override
  void initState() {
    super.initState();
    getCurrentTheme();
  }

  canDeviceChangeTheme() {
    ThemeService().checkDeviceCompatableToChangeTheme().then((bool) {
      if (bool) {
        setState(() {
          canChangeTheme = true;
        });
      } else {
        setState(() {
          canChangeTheme = false;
        });
      }
    });
  }

  Future<void> getCurrentTheme() async {
    final ThemeKeys storedTheme = await ThemeService().getCurrentTheme();
    setState(() {
      currentTheme = storedTheme;
    });
  }

  void saveCurrentTheme(ThemeKeys newTheme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String _theme = newTheme == ThemeKeys.LIGHT ? "LIGHT" : "DARK";
    prefs.setString("theme", _theme);
    setState(() {
      currentTheme = newTheme;
    });
  }

  void _changeTheme(ThemeKeys newTheme) {
    if (newTheme == ThemeKeys.LIGHT) {
      saveCurrentTheme(ThemeKeys.LIGHT);
      Themes().setLightSystemColors();
      DynamicTheme.of(context).setBrightness(Brightness.light);
    } else {
      saveCurrentTheme(ThemeKeys.DARK);
      Themes().setDarkSystemColors();
      DynamicTheme.of(context).setBrightness(Brightness.dark);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Settings"),
      drawer: CustomDrawer(),
      body: ListView(
        primary: false,
        children: <Widget>[
          themeToggle(),
        ],
      ),
    );
  }

  //TODO build out theme switcher

  Widget themeToggle() {
    return Visibility(
      visible: canChangeTheme, //! TURN ON WHEN NOT IN DEV
      // visible: true,
      child: ListTile(
        title: Text("Change theme"),
        subtitle: Text("Change the app theme"),
        onTap: () {
          showDialog(
              builder: (context) => buildThemeDialog(), context: context);
        },
      ),
    );
  }

  Widget buildThemeDialog() {
    return SimpleDialog(
      elevation: 3,
      title: Text("Change theme"),
      children: <Widget>[
        buildSelectLightTheme(),
        buildSelectDarkTheme(),
      ],
    );
  }

  Widget buildSelectLightTheme() {
    return RadioListTile<ThemeKeys>(
      title: Text("Light Theme"),
      value: ThemeKeys.LIGHT,
      activeColor: Colors.black,
      groupValue: currentTheme,
      onChanged: (ThemeKeys value) {
        _changeTheme(ThemeKeys.LIGHT);
        Navigator.pop(context);
      },
    );
  }

  Widget buildSelectDarkTheme() {
    return RadioListTile<ThemeKeys>(
      title: Text("Dark Theme"),
      value: ThemeKeys.DARK,
      activeColor: Colors.black,
      groupValue: currentTheme,
      onChanged: (ThemeKeys value) {
        _changeTheme(ThemeKeys.DARK);
        Navigator.pop(context);
      },
    );
  }
}
