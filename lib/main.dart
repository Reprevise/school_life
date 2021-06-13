import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_life/services/stacked/dialogs.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'components/theme/style.dart';
import 'services/databases/hive_helper.dart';
import 'services/stacked/bottomsheet.dart';

Future<void> main() async {
  // ensure everything's good to go
  WidgetsFlutterBinding.ensureInitialized();
  // initialize dependency injection
  setupLocator();
  // initialize stacked services
  setupBottomSheetUi();
  setupDialogService();
  // initialize all HiveDB databases
  await HiveHelper.initializeHive();
  // initialize [ThemeManager]
  await ThemeManager.initialise();
  // finally run the app
  runApp(SchoolLife());
}

class SchoolLife extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    return ThemeBuilder(
      darkTheme: darkTheme,
      lightTheme: lightTheme,
      builder: (context, theme, darkTheme, mode) {
        return MaterialApp(
          navigatorKey: StackedService.navigatorKey,
          theme: theme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          title: 'School Life',
          onGenerateRoute: StackedRouter().onGenerateRoute,
          builder: (_, child) {
            return ScrollConfiguration(
              behavior: _NoGlowScrollBehavior(),
              child: child!,
            );
          },
        );
      },
    );
  }
}

class _NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
