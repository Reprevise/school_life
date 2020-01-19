import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_life/custom_route_observer.dart';
import 'package:school_life/main.dart';
import 'package:school_life/routing/router.gr.dart';
import 'package:school_life/services/theme/theme_service.dart';
import 'package:school_life/theme/style.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ],
    );
    return DynamicTheme(
      data: (Brightness brightness) {
        getIt.get<ThemeService>().updateColorsFromBrightness(brightness);
        if (brightness == Brightness.dark) {
          return darkTheme;
        }
        return lightTheme;
      },
      defaultBrightness: Brightness.light,
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
