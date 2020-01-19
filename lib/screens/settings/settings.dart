import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/main.dart';
import 'package:school_life/routing/router.gr.dart';
import 'package:school_life/screens/settings/pages/index.dart';
import 'package:school_life/screens/settings/widgets/index.dart';
import 'package:school_life/services/theme/theme_service.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Brightness _currentBrightness;

  @override
  void initState() {
    super.initState();
    _currentBrightness = DynamicTheme.of(context).brightness;
  }

  void _changeTheme(Brightness newBrightness) {
    if (newBrightness == DynamicTheme.of(context).brightness) {
      return;
    }
    setState(() {
      _currentBrightness = newBrightness;
    });
    getIt<ThemeService>().saveCurrentBrightnessToDisk(newBrightness);
    DynamicTheme.of(context).setBrightness(newBrightness);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('Settings'),
      drawer: CustomDrawer(),
      body: ListView(
        primary: false,
        children: <Widget>[
          buildThemeToggle(),
          const Divider(color: Colors.grey),
          const SettingHeader('Page Settings'),
          RouterTile(
            icon: Icons.assignment,
            title: 'Assignments',
            route: AssignmentsSettingsPage(),
          ),
          RouterTile(
            icon: Icons.schedule,
            title: 'Schedule',
            route: ScheduleSettingsPage(),
          ),
          RouterTile(
            icon: Icons.school,
            title: 'Subjects',
            route: SubjectsSettingsPage(),
          ),
        ],
      ),
    );
  }

  Widget buildThemeToggle() {
    return ListTile(
      leading: Icon(Icons.color_lens),
      title: const Text('Theme'),
      subtitle: Text(_currentBrightness == Brightness.light ? 'Light' : 'Dark'),
      onTap: () => showDialog<void>(
        context: context,
        builder: (BuildContext context) => buildThemeDialog(),
      ),
    );
  }

  Widget buildThemeDialog() {
    return SimpleDialog(
      elevation: 1,
      title: const Text('Change theme'),
      children: <Widget>[
        buildSelectLightTheme(),
        buildSelectDarkTheme(),
      ],
    );
  }

  Widget buildSelectLightTheme() {
    return RadioListTile<Brightness>(
      title: const Text('Light Theme'),
      value: Brightness.light,
      activeColor: Colors.black,
      groupValue: _currentBrightness,
      onChanged: (Brightness value) {
        _changeTheme(value);
        Router.navigator.pop();
      },
    );
  }

  Widget buildSelectDarkTheme() {
    return RadioListTile<Brightness>(
      title: const Text('Dark Theme'),
      value: Brightness.dark,
      activeColor: Colors.black,
      groupValue: _currentBrightness,
      onChanged: (Brightness value) {
        _changeTheme(value);
        Router.navigator.pop();
      },
    );
  }
}
