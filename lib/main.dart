import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:school_life/app.dart';
import 'package:school_life/services/databases/assignments_repository.dart';
import 'package:school_life/services/databases/db_helper.dart';
import 'package:school_life/services/databases/subjects_repository.dart';
import 'package:school_life/services/device/android_details.dart';
import 'package:school_life/services/theme/theme_service.dart';

GetIt getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.initializeDatabases();
  getIt.registerSingleton<AndroidDetails>(AndroidDetails(), signalsReady: true);
  await getIt.readyFuture;
  getIt.registerSingleton<ThemeService>(ThemeService());
  getIt.registerSingleton<AssignmentsRepository>(AssignmentsRepository());
  getIt.registerSingleton<SubjectsRepository>(SubjectsRepository());
  runApp(App());
}
