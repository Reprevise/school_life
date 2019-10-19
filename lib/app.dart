import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:school_life/screens/settings/children/assignment-set.dart';
import 'package:school_life/services/theme_service.dart';
import 'package:school_life/theme/themes.dart';
import 'package:school_life/widgets/route_observer/custom_route_observer.dart';

import 'screens/forms/add_assignnment/add_assignment.dart';
import 'screens/forms/add_subject/add_subject.dart';
import 'screens/assignments/assignments.dart';
import 'screens/help_feedback/help_feedback.dart';
import 'screens/home/home.dart';
import 'screens/schedule/schedule.dart';
import 'screens/settings/settings.dart';
import 'screens/subjects/subjects.dart';
import 'screens/upgrade/upgrade.dart';

class App extends StatefulWidget {
  final routes = <String, WidgetBuilder>{
    '/': (context) => HomePage(),
    '/assignments': (context) => AssignmentsPage(),
    '/schedule': (context) => SchedulePage(),
    '/subjects': (context) => SubjectsPage(),
    '/settings': (context) => SettingsPage(),
    '/help-feedback': (context) => HelpFeedbackPage(),
    '/upgrade': (context) => UpgradePage(),
    '/settings/assignments': (context) => AssignmentsSettingsPage(),
    '/subjects/add-subject': (context) => AddSubjectPage(),
    '/assignments/add-assignment': (context) => AddAssignmentPage(),
  };

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Brightness defaultBrightness;

  @override
  void initState() {
    super.initState();
    getDefaultBrightness();
  }

  void getDefaultBrightness() async {
    final Brightness _defaultBrightness = await ThemeService().getBrightness();
    setState(() {
      defaultBrightness = _defaultBrightness;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return DynamicTheme(
      // defaultBrightness: defaultBrightness,
      data: (brightness) {
        if (brightness == Brightness.dark) {
          Themes().setDarkSystemColors();
          return Themes.darkTheme;
        } else {
          Themes().setLightSystemColors();
          return Themes.lightTheme;
        }
      },
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          initialRoute: '/',
          routes: widget.routes,
          theme: theme,
          darkTheme: Themes.darkTheme,
          navigatorObservers: [CustomRouteObserver()],
          debugShowCheckedModeBanner: false,
          title: 'School Life',
        );
      },
    );
  }
}
