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
  await DatabaseHelper.initializeDatabases();
  // get all device details (version)
  getIt.registerSingleton<AndroidDetails>(AndroidDetails(), signalsReady: true);
  // await until everything is ready
  await getIt.readyFuture;
  // Register repositories
  getIt.registerSingleton<ThemeService>(ThemeService());
  getIt.registerSingleton<AssignmentsRepository>(AssignmentsRepository());
  getIt.registerSingleton<SubjectsRepository>(SubjectsRepository());
  // Register settings helpers
  // ! Hive must be initialized
  getIt.registerSingleton<ScheduleHelper>(ScheduleHelper());
  // finally run the app
  runApp(App());
}
