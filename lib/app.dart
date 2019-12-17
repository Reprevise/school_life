import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_life/routes.dart';
import 'package:school_life/services/theme/theme_service.dart';
import 'package:school_life/theme/style.dart';
import 'package:school_life/custom_route_observer.dart';

class App extends StatelessWidget {
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
