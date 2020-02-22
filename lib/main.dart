import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:school_life/components/theme/style.dart';
import 'package:school_life/components/theme/theme_switcher.dart';
import 'package:school_life/config.dart';
import 'package:school_life/router/custom_route_observer.dart';
import 'package:school_life/router/router.gr.dart';
import 'package:school_life/services/databases/db_helper.dart';

final GetIt sl = GetIt.instance;

Future<void> main() async {
  // ensure everything's good to go
  WidgetsFlutterBinding.ensureInitialized();
  // initialize all HiveDB databases
  await DatabaseHelper.initializeHiveBoxes();
  configure();
  // finally run the app
  runApp(SchoolLife());
}

class SchoolLife extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ],
    );
    return ThemeSwitcher(
      themedWidgetBuilder: (context, mode) {
        return MaterialApp(
          initialRoute: Router.home,
          navigatorKey: Router.navigatorKey,
          onGenerateRoute: Router.onGenerateRoute,
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: mode,
          navigatorObservers: <NavigatorObserver>[CustomRouteObserver()],
          title: 'School Life',
        );
      },
    );
  }
}

