// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../models/assignment.dart';
import '../models/subject.dart';
import '../screens/assignments/add_assignnment/add_assignment.dart';
import '../screens/nav/nav_view.dart';
import '../screens/schedule/add_schedule/add_schedule.dart';
import '../screens/settings/pages/assignments/assignments_settings.dart';
import '../screens/settings/pages/schedule/schedule_settings.dart';
import '../screens/settings/pages/schedule/widgets/holidays.dart';
import '../screens/settings/pages/subjects/subjects_settings.dart';
import '../screens/subjects/add_subject/add_subject.dart';
import '../screens/subjects/details/subject_details.dart';

class Routes {
  static const String navView = '/';
  static const String assignmentsSettingsPage = '/assignmentsSettings';
  static const String addAssignmentPage = '/addAssignment';
  static const String scheduleHolidaysPage = '/holidays';
  static const String scheduleSettingsPage = '/scheduleSettings';
  static const String addSchedulePage = '/addSchedule';
  static const String addHolidayPage = '/addHoliday';
  static const String addSubjectPage = '/addSubject';
  static const String subjectDetailsPage = '/subjectDetails';
  static const String subjectsSettingsPage = '/subjectSettings';
  static const all = <String>{
    navView,
    assignmentsSettingsPage,
    addAssignmentPage,
    scheduleHolidaysPage,
    scheduleSettingsPage,
    addSchedulePage,
    addHolidayPage,
    addSubjectPage,
    subjectDetailsPage,
    subjectsSettingsPage,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.navView, page: NavView),
    RouteDef(Routes.assignmentsSettingsPage, page: AssignmentsSettingsPage),
    RouteDef(Routes.addAssignmentPage, page: AddAssignmentPage),
    RouteDef(Routes.scheduleHolidaysPage, page: ScheduleHolidaysPage),
    RouteDef(Routes.scheduleSettingsPage, page: ScheduleSettingsPage),
    RouteDef(Routes.addSchedulePage, page: AddSchedulePage),
    RouteDef(Routes.addHolidayPage, page: AddHolidayPage),
    RouteDef(Routes.addSubjectPage, page: AddSubjectPage),
    RouteDef(Routes.subjectDetailsPage, page: SubjectDetailsPage),
    RouteDef(Routes.subjectsSettingsPage, page: SubjectsSettingsPage),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    NavView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const NavView(),
        settings: data,
      );
    },
    AssignmentsSettingsPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AssignmentsSettingsPage(),
        settings: data,
      );
    },
    AddAssignmentPage: (data) {
      var args = data.getArgs<AddAssignmentPageArguments>(
        orElse: () => AddAssignmentPageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddAssignmentPage(
          key: args.key,
          assignmentToEdit: args.assignmentToEdit,
        ),
        settings: data,
      );
    },
    ScheduleHolidaysPage: (data) {
      var args = data.getArgs<ScheduleHolidaysPageArguments>(
        orElse: () => ScheduleHolidaysPageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ScheduleHolidaysPage(key: args.key),
        settings: data,
      );
    },
    ScheduleSettingsPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ScheduleSettingsPage(),
        settings: data,
      );
    },
    AddSchedulePage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AddSchedulePage(),
        settings: data,
      );
    },
    AddHolidayPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AddHolidayPage(),
        settings: data,
      );
    },
    AddSubjectPage: (data) {
      var args = data.getArgs<AddSubjectPageArguments>(
        orElse: () => AddSubjectPageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddSubjectPage(
          key: args.key,
          subjectToEdit: args.subjectToEdit,
        ),
        settings: data,
      );
    },
    SubjectDetailsPage: (data) {
      var args = data.getArgs<SubjectDetailsPageArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SubjectDetailsPage(
          args.subject,
          key: args.key,
        ),
        settings: data,
      );
    },
    SubjectsSettingsPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SubjectsSettingsPage(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// AddAssignmentPage arguments holder class
class AddAssignmentPageArguments {
  final Key? key;
  final Assignment? assignmentToEdit;
  AddAssignmentPageArguments({this.key, this.assignmentToEdit});
}

/// ScheduleHolidaysPage arguments holder class
class ScheduleHolidaysPageArguments {
  final Key? key;
  ScheduleHolidaysPageArguments({this.key});
}

/// AddSubjectPage arguments holder class
class AddSubjectPageArguments {
  final Key? key;
  final Subject? subjectToEdit;
  AddSubjectPageArguments({this.key, this.subjectToEdit});
}

/// SubjectDetailsPage arguments holder class
class SubjectDetailsPageArguments {
  final Subject subject;
  final Key? key;
  SubjectDetailsPageArguments({required this.subject, this.key});
}
