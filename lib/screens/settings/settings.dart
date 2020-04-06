import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/components/theme/theme_switcher.dart';
import 'package:school_life/router/router.gr.dart';
import 'package:school_life/screens/settings/widgets/router_tile.dart';
import 'package:school_life/screens/settings/widgets/setting_header.dart';
import 'package:school_life/screens/settings/widgets/theme_switch_controller.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _controller = ThemeSwitchController();
  static const _animPath = 'assets/animations/switch_daytime.flr';

  bool _isDark;

  @override
  void initState() {
    super.initState();
    _isDark = ThemeSwitcher.of(context).mode == ThemeMode.dark;
    _controller.setDarkness(isDark: _isDark);
  }

  void _toggleTheme() {
    _isDark = !_isDark;
    _controller.setDarkness(isDark: _isDark);
    ThemeSwitcher.of(context).setThemeMode(
      _isDark ? ThemeMode.dark : ThemeMode.light,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('Settings'),
      drawer: CustomDrawer(),
      body: ListView(
        children: <Widget>[
          buildThemeTile(),
          const Divider(color: Colors.grey),
          const SettingHeader('Page Settings'),
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
    );
  }

  Widget buildThemeTile() {
    final textTheme = Theme.of(context).accentTextTheme;

    return InkWell(
      onTap: _toggleTheme,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Theme', style: textTheme.bodyText2),
            SizedBox(
              width: 75,
              child: FlareActor(
                _animPath,
                controller: _controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
