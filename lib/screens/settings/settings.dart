import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/components/theme/theme_switcher.dart';
import 'package:school_life/router/router.gr.dart';
import 'package:school_life/screens/settings/widgets/index.dart';
import 'package:school_life/screens/settings/widgets/theme_switch_controller.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDark;

  ThemeSwitchController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ThemeSwitchController();
    ThemeSwitcher.of(context).mode == ThemeMode.light
        ? _isDark = false
        : _isDark = true;
    _controller.setDarkness(_isDark);
  }

  void _toggleTheme() {
    _isDark = !_isDark;
    ThemeSwitcher.of(context).setThemeMode(
      _isDark == true ? ThemeMode.dark : ThemeMode.light,
      context,
    );
    _controller.setDarkness(_isDark);
    setState(() {});
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
            route: Router.assignmentSettings,
          ),
          RouterTile(
            icon: Icons.schedule,
            title: 'Schedule',
            route: Router.scheduleSettings,
          ),
          RouterTile(
            icon: Icons.school,
            title: 'Subjects',
            route: Router.subjectsSettings,
          ),
        ],
      ),
    );
  }

  Widget buildThemeToggle() {
    return GestureDetector(
      onTap: _toggleTheme,
      child: Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Theme',
                    style: Theme.of(context).accentTextTheme.headline4,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isDark == false ? 'Light' : 'Dark',
                    style: Theme.of(context).accentTextTheme.bodyText2,
                  ),
                ],
              ),
            ),
            Container(
              width: 100,
              height: 50,
              child: FlareActor(
                'assets/animations/switch_daytime.flr',
                controller: _controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
