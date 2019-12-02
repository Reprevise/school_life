import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:school_life/services/theme_service.dart';
import 'package:school_life/widgets/lifecycle/lifecycle_events_handler.dart';
import 'package:school_life/widgets/scaffold/custom_scaffold.dart';

import 'children/assignments-set.dart';
import 'children/subjects-set.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Brightness _currentBrightness;
  ThemeService _themeService;

  @override
  void initState() {
    super.initState();
    _themeService = ThemeService();
    _currentBrightness = DynamicTheme.of(context).brightness;
  }

  void _changeTheme(Brightness newBrightness, BuildContext context) {
    if (newBrightness == DynamicTheme.of(context).brightness) return;
    setState(() {
      _currentBrightness = newBrightness;
    });
    _themeService.saveCurrentBrightnessToDisk(newBrightness);
    DynamicTheme.of(context).setBrightness(newBrightness);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "Settings",
      scaffoldBody: SingleChildScrollView(
        primary: false,
        child: Column(
          children: <Widget>[
            buildSettingHeader("Theme"),
            buildThemeToggle(),
            buildSettingHeader("Assignments"),
            buildGoToAssignmentsSettings(context),
            buildSettingHeader("Subjects"),
            buildGoToSubjectsSettings(context),
          ],
        ),
      ),
    );
  }

  Widget buildSettingHeader(String title) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildThemeToggle() {
    return ListTile(
      leading: Icon(Icons.color_lens, size: 32),
      title: Text("Change theme"),
      subtitle: Text("Change the app theme"),
      onTap: () => showDialog(
        builder: (context) => buildThemeDialog(context),
        context: context,
      ),
    );
  }

  Widget buildThemeDialog(BuildContext context) {
    return SimpleDialog(
      elevation: 1,
      title: Text("Change theme"),
      children: <Widget>[
        buildSelectLightTheme(context),
        buildSelectDarkTheme(context),
      ],
    );
  }

  Widget buildSelectLightTheme(BuildContext context) {
    return RadioListTile<Brightness>(
      title: Text("Light Theme"),
      value: Brightness.light,
      activeColor: Colors.black,
      groupValue: _currentBrightness,
      onChanged: (value) {
        _changeTheme(value, context);
        Navigator.pop(context);
      },
    );
  }

  Widget buildSelectDarkTheme(BuildContext context) {
    return RadioListTile<Brightness>(
      title: Text("Dark Theme"),
      value: Brightness.dark,
      activeColor: Colors.black,
      groupValue: _currentBrightness,
      onChanged: (value) {
        _changeTheme(value, context);
        Navigator.pop(context);
      },
    );
  }

  Widget buildGoToAssignmentsSettings(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.assignment, size: 32),
      title: Text("Assignments Settings"),
      subtitle: Text("Open assignments settings"),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LifecycleEventsHandler(resumeCallback: () => ThemeService().updateColors(), child: AssignmentsSettingsPage()),
        ),
      ),
    );
  }

  Widget buildGoToSubjectsSettings(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.school, size: 32),
      title: Text("Subjects Settings"),
      subtitle: Text("Open subjects settings"),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LifecycleEventsHandler(resumeCallback: () => ThemeService().updateColors(), child: SubjectsSettingsPage()),
        ),
      ),
    );
  }
}
