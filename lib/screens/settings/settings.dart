import 'package:flutter/material.dart';
import 'package:school_life/components/navbar/navbar.dart';
import 'package:school_life/components/theme/theme_switcher.dart';
import 'package:school_life/router/router.gr.dart';
import 'package:school_life/screens/settings/widgets/router_tile.dart';
import 'package:school_life/screens/settings/widgets/setting_header.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: CustomBottomNavBar(widget.tabsChangeNotifier),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Theme'),
          ),
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
}
