import 'package:flutter/material.dart';
import 'package:school_life/components/navbar/navbar.dart';
import 'package:school_life/components/screen_header/screen_header.dart';
import 'package:school_life/components/theme/theme_switcher.dart';
import 'package:school_life/router/router.gr.dart';
import 'package:school_life/screens/settings/widgets/router_tile.dart';

class SettingsPage extends StatefulWidget {
  final ValueNotifier<int> tabsChangeNotifier;

  SettingsPage(this.tabsChangeNotifier);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ThemeMode currentMode;

  @override
  void initState() {
    super.initState();
    currentMode = ThemeSwitcher.of(context).mode;
    if (mounted) setState(() {});
  }

  void _changeMode(ThemeMode newMode) {
    currentMode = newMode;
    ThemeSwitcher.of(context).setThemeMode(newMode, context);
    Router.navigator.pop();
  }

  void _showThemeChangeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: Text(
            'Change theme',
            style: Theme.of(context).textTheme.headline3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          content: Column(
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
      bottomNavigationBar: CustomBottomNavBar(widget.tabsChangeNotifier),
      body: SafeArea(
        child: ListView(
          primary: false,
          children: <Widget>[
            ScreenHeader('Settings'),
            ListTile(
              title: Text('Theme'),
              subtitle: Text(themes[currentMode]),
              onTap: _showThemeChangeDialog,
            ),
            RouterTile(
              icon: Icons.assignment,
              title: 'Assignments',
              route: Routes.assignmentSettings,
            ),
            RouterTile(
              icon: Icons.schedule,
              title: 'Schedule',
              route: Routes.scheduleSettings,
            ),
            RouterTile(
              icon: Icons.school,
              title: 'Subjects',
              route: Routes.subjectsSettings,
            ),
          ],
        ),
      ),
    );
  }
}
