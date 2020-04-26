// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:school_life/services/databases/assignments_repository.dart';
import 'package:school_life/services/settings/basic.dart';
import 'package:school_life/services/databases/holidays_repository.dart';
import 'package:school_life/services/settings/schedule.dart';
import 'package:school_life/services/databases/subjects_repository.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerFactory<AssignmentsRepository>(() => AssignmentsRepository());
  g.registerFactory<HolidaysRepository>(() => HolidaysRepository());
  g.registerFactory<SubjectsRepository>(() => SubjectsRepository());

  //Eager singletons must be registered in the right order
  g.registerSingleton<BasicSettingsHelper>(BasicSettingsHelper());
  g.registerSingleton<ScheduleSettingsHelper>(ScheduleSettingsHelper());
}
