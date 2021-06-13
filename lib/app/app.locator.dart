// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/databases/assignments_repository.dart';
import '../services/databases/holidays_repository.dart';
import '../services/databases/subjects_repository.dart';
import '../services/settings/schedule.dart';

final locator = StackedLocator.instance;

void setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => AssignmentsRepository());
  locator.registerLazySingleton(() => HolidaysRepository());
  locator.registerLazySingleton(() => SubjectsRepository());
  locator.registerLazySingleton(() => ScheduleSettingsHelper());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
}
