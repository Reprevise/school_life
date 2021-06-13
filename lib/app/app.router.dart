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
import '../screens/assignments/details/assignment_details.dart';
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
  static const String assignmentDetailsPage = '/assignmentDetails';
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
    assignmentDetailsPage,
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
    RouteDef(Routes.assignmentDetailsPage, page: AssignmentDetailsPage),
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
    AssignmentDetailsPage: (data) {
      var args = data.getArgs<AssignmentDetailsPageArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AssignmentDetailsPage(
          args.assignment,
          args.assignmentSubject,
        ),
        settings: data,
      );
    },
    AssignmentsSettingsPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AssignmentsSettingsPage(),
        settings: data,
      );
    },
    AddAssignmentPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddAssignmentPage(),
        settings: data,
      );
    },
    ScheduleHolidaysPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ScheduleHolidaysPage(),
        settings: data,
      );
    },
    ScheduleSettingsPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ScheduleSettingsPage(),
        settings: data,
      );
    },
    AddSchedulePage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddSchedulePage(),
        settings: data,
      );
    },
    AddHolidayPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddHolidayPage(),
        settings: data,
      );
    },
    AddSubjectPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddSubjectPage(),
        settings: data,
      );
    },
    SubjectDetailsPage: (data) {
      var args = data.getArgs<SubjectDetailsPageArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SubjectDetailsPage(args.subject),
        settings: data,
      );
    },
    SubjectsSettingsPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SubjectsSettingsPage(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// AssignmentDetailsPage arguments holder class
class AssignmentDetailsPageArguments {
  final Assignment assignment;
  final Subject assignmentSubject;
  AssignmentDetailsPageArguments(
      {required this.assignment, required this.assignmentSubject});
}

/// SubjectDetailsPage arguments holder class
class SubjectDetailsPageArguments {
  final Subject subject;
  SubjectDetailsPageArguments({required this.subject});
}
