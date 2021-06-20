import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../components/screen_header/screen_header.dart';
import 'widgets/router_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  late ThemeMode currentMode;
  late AnimationController _animController;

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
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 75),
      value: 0.0,
    );
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _changeMode(ThemeMode? newMode) {
    currentMode = newMode!;
    getThemeManager(context).setThemeMode(newMode);
    _navService.back();
  }

  void _showThemeChangeDialog() {
    showGeneralDialog(
      context: context,
      pageBuilder: (_, __, ___) => Container(),
      barrierLabel: 'Theme changer dialog',
      barrierDismissible: true,
      transitionBuilder: (c, a1, a2, child) {
        return FadeScaleTransition(
          animation: a1,
          child: AlertDialog(
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
                  title: const Text('System'),
                  onChanged: _changeMode,
                ),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.light,
                  groupValue: currentMode,
                  title: const Text('Light'),
                  onChanged: _changeMode,
                ),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.dark,
                  groupValue: currentMode,
                  title: const Text('Dark'),
                  onChanged: _changeMode,
                ),
              ],
            ),
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
              title: const Text('Theme'),
              subtitle: Text(_themeNames[currentMode]!),
              trailing: const Icon(Icons.more_horiz_outlined),
              onTap: _showThemeChangeDialog,
            ),
            const RouterTile(
              icon: Icons.schedule,
              title: 'Schedule',
              route: Routes.scheduleSettingsPage,
            ),
            const RouterTile(
              icon: Icons.assignment,
              title: 'Assignments',
              route: Routes.assignmentsSettingsPage,
              disable: true,
            ),
            const RouterTile(
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
