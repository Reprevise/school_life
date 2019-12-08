import 'package:flutter/material.dart';
import 'package:school_life/services/assignments_db/assignments_db.dart';
import 'package:school_life/services/device/android_details.dart';
import 'package:school_life/services/subjects_db/subjects_db.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AndroidDetails();
  await SubjectDBCreator().initDatabase();
  await AssignmentDBCreator().initDatabase();
  runApp(App());
}
