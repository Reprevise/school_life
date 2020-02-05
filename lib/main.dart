import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:school_life/app.dart';
import 'package:school_life/screens/settings/pages/helpers/schedule_helper.dart';
import 'package:school_life/services/databases/assignments_repository.dart';
import 'package:school_life/services/databases/db_helper.dart';
import 'package:school_life/services/databases/subjects_repository.dart';
import 'package:school_life/services/device/android_details.dart';
import 'package:school_life/services/theme/theme_service.dart';

// instance of the get_it package
GetIt getIt = GetIt.instance;

Future<void> main() async {
  // ensure everything's good to go
  WidgetsFlutterBinding.ensureInitialized();
  // initialize all HiveDB databases
  await DatabaseHelper.initializeHiveBoxes();
  getIt
    // get all device details (version)
    ..registerSingletonAsync<AndroidDetails>(
      (Completer<dynamic> completer) => AndroidDetailsImplementation(completer),
    )
    ..registerSingletonAsync<ThemeService>(
      (_) => Future<ThemeService>.value(ThemeService()),
      dependsOn: <Type>[AndroidDetails],
    )
    // ! Hive must be initialized
    // Register repositories
    ..registerSingleton<AssignmentsRepository>(AssignmentsRepository())
    ..registerSingleton<SubjectsRepository>(SubjectsRepository())
    // Register settings helpers
    ..registerSingleton<ScheduleHelper>(ScheduleHelper());
  // await ready
  await getIt.allReady();
  // finally run the app
  runApp(App());
}
