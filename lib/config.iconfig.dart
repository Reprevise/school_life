// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:school_life/screens/settings/pages/helpers/schedule_settings_helper.dart';
import 'package:school_life/services/databases/assignments_repository.dart';
import 'package:school_life/services/databases/holidays_repository.dart';
import 'package:school_life/services/databases/subjects_repository.dart';
import 'package:school_life/services/device/android_details.dart';
import 'package:school_life/services/theme/theme_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void $initGetIt({String environment}) {
  getIt
    ..registerSingleton<ScheduleSettingsHelper>(ScheduleSettingsHelper())
    ..registerSingleton<AssignmentsRepository>(AssignmentsRepository())
    ..registerSingleton<HolidaysRepository>(HolidaysRepository())
    ..registerSingleton<SubjectsRepository>(SubjectsRepository())
    ..registerSingleton<AndroidDetails>(AndroidDetails(), signalsReady: true)
    ..registerSingleton<ThemeService>(ThemeService());
}
