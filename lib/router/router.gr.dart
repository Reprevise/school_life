// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:school_life/screens/home/home.dart';
import 'package:school_life/screens/assignments/assignments.dart';
import 'package:school_life/screens/schedule/schedule.dart';
import 'package:school_life/screens/subjects/subjects.dart';
import 'package:school_life/screens/settings/settings.dart';
import 'package:school_life/screens/settings/pages/schedule/widgets/holidays.dart';
import 'package:school_life/screens/help_feedback/help_feedback.dart';
import 'package:school_life/screens/settings/pages/assignments_settings.dart';
import 'package:school_life/screens/settings/pages/subjects_settings.dart';
import 'package:school_life/screens/settings/pages/schedule/schedule_settings.dart';
import 'package:school_life/screens/assignments/details/assignment_details.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/screens/assignments/add_assignnment/add_assignment.dart';
import 'package:school_life/screens/schedule/add_schedule/add_schedule.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/screens/subjects/add_subject/add_subject.dart';

class Router {
  static const home = '/';
  static const assignments = '/assignments';
  static const schedule = '/schedule';
  static const subjects = '/subjects';
  static const settings = '/settings';
  static const holidays = '/holidays';
  static const helpFeedback = '/help-feedback';
  static const assignmentSettings = '/assignment-settings';
  static const subjectsSettings = '/subjects-settings';
  static const scheduleSettings = '/schedule-settings';
  static const assignmentDetails = '/assignment-details';
  static const addAssignment = '/add-assignment';
  static const addHoliday = '/add-holiday';
  static const addSchedule = '/add-schedule';
  static const addSubject = '/add-subject';
  static const routes = [
    home,
    assignments,
    schedule,
    subjects,
    settings,
    holidays,
    helpFeedback,
    assignmentSettings,
    subjectsSettings,
    scheduleSettings,
    assignmentDetails,
    addAssignment,
    addHoliday,
    addSchedule,
    addSubject,
  ];
  static final navigator = ExtendedNavigator();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.home:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) => HomePage(),
          settings: settings,
        );
      case Router.assignments:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              AssignmentsPage(),
          settings: settings,
        );
      case Router.schedule:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) => SchedulePage(),
          settings: settings,
        );
      case Router.subjects:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) => SubjectsPage(),
          settings: settings,
        );
      case Router.settings:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) => SettingsPage(),
          settings: settings,
        );
      case Router.holidays:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              ScheduleHolidaysPage(key: typedArgs),
          settings: settings,
        );
      case Router.helpFeedback:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              HelpFeedbackPage(),
          settings: settings,
        );
      case Router.assignmentSettings:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              AssignmentsSettingsPage(),
          settings: settings,
        );
      case Router.subjectsSettings:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              SubjectsSettingsPage(),
          settings: settings,
        );
      case Router.scheduleSettings:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              ScheduleSettingsPage(),
          settings: settings,
        );
      case Router.assignmentDetails:
        if (hasInvalidArgs<Assignment>(args)) {
          return misTypedArgsRoute<Assignment>(args);
        }
        final typedArgs = args as Assignment;
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              AssignmentDetailsPage(typedArgs),
          settings: settings,
        );
      case Router.addAssignment:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              AddAssignmentPage(),
          settings: settings,
        );
      case Router.addHoliday:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              AddHolidayPage(key: typedArgs),
          settings: settings,
        );
      case Router.addSchedule:
        if (hasInvalidArgs<AddSchedulePageArguments>(args)) {
          return misTypedArgsRoute<AddSchedulePageArguments>(args);
        }
        final typedArgs =
            args as AddSchedulePageArguments ?? AddSchedulePageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              AddSchedulePage(key: typedArgs.key, subject: typedArgs.subject),
          settings: settings,
        );
      case Router.addSubject:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) => AddSubjectPage(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//AddSchedulePage arguments holder class
class AddSchedulePageArguments {
  final Key key;
  final Subject subject;
  AddSchedulePageArguments({this.key, this.subject});
}
