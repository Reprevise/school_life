import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_life/services/theme/theme_service.dart';
import 'package:school_life/theme/themes.dart';
import 'package:school_life/ui/schedule/schedule.dart';
import 'package:school_life/widgets/route_observer/custom_route_observer.dart';

import 'ui/assignments/assignments.dart';
import 'ui/help_feedback/help_feedback.dart';
import 'ui/home/home.dart';
import 'ui/calendar/calendar.dart';
import 'ui/settings/settings.dart';
import 'ui/subjects/subjects.dart';

class App extends StatelessWidget {
  static final routes = <String, WidgetBuilder>{
    '/': (context) => HomePage(),
    '/assignments': (context) => AssignmentsPage(),
    '/calendar': (context) => CalendarPage(),
    '/schedule': (context) => SchedulePage(),
    '/subjects': (context) => SubjectsPage(),
    '/settings': (context) => SettingsPage(),
    '/help-feedback': (context) => HelpFeedbackPage(),
  };

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    return DynamicTheme(
      data: (brightness) {
        ThemeService.updateColorsFromBrightness(brightness);
        if (brightness == Brightness.dark) return Themes.darkTheme;
        return Themes.lightTheme;
      },
      defaultBrightness: Brightness.light,
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          initialRoute: '/',
          routes: routes,
          theme: theme,
          navigatorObservers: [CustomRouteObserver()],
          title: 'School Life',
        );
      },
    );
  }
}
