import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_life/services/theme_service.dart';
import 'package:school_life/theme/themes.dart';
import 'package:school_life/widgets/lifecycle/lifecycle_events_handler.dart';
import 'package:school_life/widgets/route_observer/custom_route_observer.dart';

import 'ui/assignments/assignments.dart';
import 'ui/help_feedback/help_feedback.dart';
import 'ui/home/home.dart';
import 'ui/schedule/schedule.dart';
import 'ui/settings/settings.dart';
import 'ui/subjects/subjects.dart';
import 'ui/upgrade/upgrade.dart';

class App extends StatelessWidget {
  static final routes = <String, WidgetBuilder>{
    '/': (context) => LifecycleEventsHandler(
          resumeCallback: () => ThemeService().updateColors(),
          child: HomePage(),
        ),
    '/assignments': (context) => LifecycleEventsHandler(
          resumeCallback: () => ThemeService().updateColors(),
          child: AssignmentsPage(),
        ),
    '/schedule': (context) => LifecycleEventsHandler(
          resumeCallback: () => ThemeService().updateColors(),
          child: SchedulePage(),
        ),
    '/subjects': (context) => LifecycleEventsHandler(
          resumeCallback: () => ThemeService().updateColors(),
          child: SubjectsPage(),
        ),
    '/settings': (context) => LifecycleEventsHandler(
          resumeCallback: () => ThemeService().updateColors(),
          child: SettingsPage(),
        ),
    '/help-feedback': (context) => LifecycleEventsHandler(
          resumeCallback: () => ThemeService().updateColors(),
          child: HelpFeedbackPage(),
        ),
    '/upgrade': (context) => LifecycleEventsHandler(
          resumeCallback: () => ThemeService().updateColors(),
          child: UpgradePage(),
        ),
  };

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) {
          Themes.updateColorsFromBrightness(brightness);
          if (brightness == Brightness.light) {
            return Themes.lightTheme;
          }
          return Themes.darkTheme;
        },
        themedWidgetBuilder: (context, currentTheme) {
          return MaterialApp(
            initialRoute: '/',
            routes: routes,
            theme: currentTheme,
            navigatorObservers: [CustomRouteObserver()],
            debugShowCheckedModeBanner: false,
            title: 'School Life',
          );
        });
  }
}
