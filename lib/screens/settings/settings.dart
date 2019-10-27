import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:school_life/services/android_details.dart';
import 'package:school_life/services/theme_service.dart';

import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/widgets/drawer/custom_drawer.dart';

import 'children/assignments-set.dart';
import 'children/subjects-set.dart';

enum ThemeKeys { LIGHT, DARK }

class SettingsPage extends StatefulWidget {
  final AndroidDetails details = AndroidDetails();

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool canManuallyChangeThemeInAppSettings = false;
  ThemeKeys currentTheme = ThemeKeys.LIGHT;

  @override
  void initState() {
    super.initState();
    _canDeviceChangeTheme();
    _getCurrentTheme();
  }

  Future<void> _canDeviceChangeTheme() async {
    bool _canManuallyChangeThemeInSysSettings =
        await ThemeService().hasAndroidSevenPlusAndNotNightMode();
    setState(() {
      canManuallyChangeThemeInAppSettings =
          _canManuallyChangeThemeInSysSettings;
    });
  }

  Future<void> _getCurrentTheme() async {
    final ThemeKeys storedTheme = await ThemeService().getCurrentTheme();
    if (!canManuallyChangeThemeInAppSettings) return;
    // _changeTheme(storedTheme);
    setState(() {
      currentTheme = storedTheme;
    });
  }

  void _saveTheme(ThemeKeys newTheme) {
    ThemeService().saveTheme(newTheme).then((_) {
      setState(() {
        currentTheme = newTheme;
      });
    });
  }

  void _changeTheme(ThemeKeys newTheme) {
    _saveTheme(newTheme);
    if (newTheme == ThemeKeys.LIGHT) {
      DynamicTheme.of(context).setBrightness(Brightness.light);
    } else {
      DynamicTheme.of(context).setBrightness(Brightness.dark);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeService().checkMatchingBrightness(context);
    return Scaffold(
      appBar: CustomAppBar(title: "Settings"),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        primary: false,
        child: Column(
          children: <Widget>[
            Visibility(
              visible: canManuallyChangeThemeInAppSettings,
              child: buildSettingHeader("Theme"),
            ),
            Visibility(
              visible: canManuallyChangeThemeInAppSettings,
              child: buildThemeToggle(),
            ),
            buildSettingHeader("Assignments"),
            buildGoToAssignmentsSettings(),
            buildSettingHeader("Subjects"),
            buildGoToSubjectsSettings(),
          ],
        ),
      ),
    );
  }

  Widget buildSettingHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 8.0, top: 8.0),
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).accentColor),
          ),
        ),
        Divider()
      ],
    );
  }

  Widget buildThemeToggle() {
    return ListTile(
      leading: Icon(Icons.color_lens, size: 32),
      title: Text("Change theme"),
      subtitle: Text("Change the app theme"),
      onTap: () {
        showDialog(builder: (context) => buildThemeDialog(), context: context);
      },
    );
  }

  Widget buildThemeDialog() {
    return SimpleDialog(
      elevation: 1,
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
      onChanged: (value) {
        _changeTheme(value);
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
      onChanged: (value) {
        _changeTheme(value);
        Navigator.pop(context);
      },
    );
  }

  Widget buildGoToAssignmentsSettings() {
    return ListTile(
      leading: Icon(Icons.assignment, size: 32),
      title: Text("Assignments Settings"),
      subtitle: Text("Open assignments settings"),
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => AssignmentsSettingsPage())),
    );
  }

  Widget buildGoToSubjectsSettings() {
    return ListTile(
      leading: Icon(Icons.school, size: 32),
      title: Text("Subjects Settings"),
      subtitle: Text("Open subjects settings"),
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => SubjectsSettingsPage())),
    );
  }
}
