import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../components/screen_header/screen_header.dart';
import 'widgets/router_tile.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late ThemeMode currentMode;

  final _themeNames = {
    ThemeMode.system: 'System',
    ThemeMode.dark: 'Dark',
    ThemeMode.light: 'Light',
    null: 'Unknown',
  };
  final _navService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
    currentMode = getThemeManager(context).selectedThemeMode!;
    if (mounted) setState(() {});
  }

  void _changeMode(ThemeMode? newMode) {
    currentMode = newMode!;
    getThemeManager(context).setThemeMode(newMode);
    _navService.back();
  }

  void _showThemeChangeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Change theme',
            style: Theme.of(context).textTheme.headline6,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile<ThemeMode>(
                value: ThemeMode.system,
                groupValue: currentMode,
                title: Text('System'),
                onChanged: _changeMode,
              ),
              RadioListTile<ThemeMode>(
                value: ThemeMode.light,
                groupValue: currentMode,
                title: Text('Light'),
                onChanged: _changeMode,
              ),
              RadioListTile<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: currentMode,
                title: Text('Dark'),
                onChanged: _changeMode,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: ListView(
          primary: false,
          children: <Widget>[
            const ScreenHeader('Settings'),
            ListTile(
              title: Text('Theme'),
              subtitle: Text(_themeNames[currentMode]!),
              trailing: Icon(Icons.more_horiz_outlined),
              onTap: _showThemeChangeDialog,
            ),
            RouterTile(
              icon: Icons.schedule,
              title: 'Schedule',
              route: Routes.scheduleSettingsPage,
            ),
            RouterTile(
              icon: Icons.assignment,
              title: 'Assignments',
              route: Routes.assignmentsSettingsPage,
              disable: true,
            ),
            RouterTile(
              icon: Icons.school,
              title: 'Subjects',
              route: Routes.subjectsSettingsPage,
              disable: true,
            ),
          ],
        ),
      ),
    );
  }
}
