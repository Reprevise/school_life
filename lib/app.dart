import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_life/theme/themes.dart';
import 'package:school_life/widgets/route_observer/custom_route_observer.dart';

import 'screens/assignments/assignments.dart';
import 'screens/help_feedback/help_feedback.dart';
import 'screens/home/home.dart';
import 'screens/schedule/schedule.dart';
import 'screens/settings/settings.dart';
import 'screens/subjects/subjects.dart';
import 'screens/upgrade/upgrade.dart';

class App extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    '/': (context) => HomePage(),
    '/assignments': (context) => AssignmentsPage(),
    '/schedule': (context) => SchedulePage(),
    '/subjects': (context) => SubjectsPage(),
    '/settings': (context) => SettingsPage(),
    '/help-feedback': (context) => HelpFeedbackPage(),
    '/upgrade': (context) => UpgradePage(),
  };

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    
    return DynamicTheme(
      defaultBrightness: Brightness.light,
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
          routes: routes,
          theme: theme,
          darkTheme: theme,
          navigatorObservers: [CustomRouteObserver()],
          debugShowCheckedModeBanner: false,
          title: 'School Life',
        );
      },
    );
  }
}
