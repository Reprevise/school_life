import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:school_life/services/theme/theme_service.dart';
import 'package:school_life/ui/settings/children/assignments-set.dart';
import 'package:school_life/ui/settings/children/schedule-set.dart';
import 'package:school_life/ui/settings/children/subjects-set.dart';
import 'package:school_life/widgets/index.dart';

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
    return Scaffold(
      appBar: CustomAppBar("Settings"),
      drawer: CustomDrawer(),
      body: ListView(
        primary: false,
        children: <Widget>[
          buildSettingHeader("Theme"),
          buildThemeToggle(),
          buildSettingHeader("Page Settings"),
          buildGoToAssignmentsSettings(context),
          buildGoToSubjectsSettings(context),
          buildGoToScheduleSettings(context),
        ],
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
      leading: Icon(Icons.color_lens),
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
      leading: Icon(Icons.assignment),
      title: Text("Assignments"),
      subtitle: Text("Open assignment settings"),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AssignmentsSettingsPage(),
        ),
      ),
    );
  }

  Widget buildGoToSubjectsSettings(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.school),
      title: Text("Subjects"),
      subtitle: Text("Open subject settings"),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SubjectsSettingsPage(),
        ),
      ),
    );
  }

  Widget buildGoToScheduleSettings(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.schedule),
      title: Text("Schedule"),
      subtitle: Text("Open schedule settings"),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleSettingsPage(),
        ),
      ),
    );
  }
}
