import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:school_life/app.dart';
import 'package:school_life/config.dart';
import 'package:school_life/services/databases/db_helper.dart';

final GetIt sl = GetIt.instance;

Future<void> main() async {
  // ensure everything's good to go
  WidgetsFlutterBinding.ensureInitialized();
  // initialize all HiveDB databases
  await DatabaseHelper.initializeHiveBoxes();
  configure();
  // await ready
  await sl.readyFuture;
  // finally run the app
  runApp(App());
}
