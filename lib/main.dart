import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:school_life/components/scroll_behavior/no_glow.dart';
import 'package:school_life/components/theme/style.dart';
import 'package:school_life/components/theme/theme_switcher.dart';
import 'package:school_life/router/navbar_observer.dart';
import 'package:school_life/router/router.gr.dart';
import 'package:school_life/services/databases/db_helper.dart';

final GetIt sl = GetIt.instance;

Future<void> main() async {
  // ensure everything's good to go
  WidgetsFlutterBinding.ensureInitialized();
  // initialize all HiveDB databases
  await DatabaseHelper.initializeHiveBoxes();
  // finally run the app
  runApp(SchoolLife());
}

class SchoolLife extends StatefulWidget {
  @override
  _SchoolLifeState createState() => _SchoolLifeState();
}

class _SchoolLifeState extends State<SchoolLife> {
  ValueNotifier<int> tabsChangeNotifier;

  @override
  void initState() {
    super.initState();
    tabsChangeNotifier = ValueNotifier<int>(0);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    return ThemeSwitcher(
      themedWidgetBuilder: (context, mode) {
        return ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
          child: MaterialApp(
            builder: ExtendedNavigator<Router>(
              router: Router(),
              initialRouteArgs: HomePageArguments(
                tabsChangeNotifier: tabsChangeNotifier,
              ),
              observers: [NavBarObserver(tabsChangeNotifier)],
            ),
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: mode,
            title: 'School Life',
          ),
        );
      },
    );
  }
}
