import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_life/components/theme/theme_switcher.dart';
import 'package:school_life/routing/custom_route_observer.dart';
import 'package:school_life/routing/router.gr.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ],
    );
    return ThemeSwitcher(
      themedWidgetBuilder: (BuildContext context, ThemeData theme) {
        return MaterialApp(
          initialRoute: Router.home,
          navigatorKey: Router.navigatorKey,
          onGenerateRoute: Router.onGenerateRoute,
          theme: theme,
          navigatorObservers: <NavigatorObserver>[CustomRouteObserver()],
          title: 'School Life',
        );
      },
    );
  }
}
