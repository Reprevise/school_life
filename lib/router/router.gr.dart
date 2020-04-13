// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:school_life/screens/home/home.dart';
import 'package:school_life/screens/schedule/schedule.dart';
import 'package:school_life/screens/assignments/assignments.dart';
import 'package:school_life/screens/settings/settings.dart';
import 'package:school_life/screens/subjects/subjects.dart';
import 'package:school_life/screens/settings/pages/schedule/widgets/holidays.dart';
import 'package:school_life/screens/settings/pages/assignments/assignments_settings.dart';
import 'package:school_life/screens/settings/pages/subjects/subjects_settings.dart';
import 'package:school_life/screens/settings/pages/schedule/schedule_settings.dart';
import 'package:school_life/screens/assignments/details/assignment_details.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/screens/assignments/add_assignnment/add_assignment.dart';
import 'package:school_life/screens/schedule/add_schedule/add_schedule.dart';
import 'package:school_life/screens/subjects/add_subject/add_subject.dart';

abstract class Routes {
  static const home = '/';
  static const schedule = '/schedule';
  static const assignments = '/assignments';
  static const settings = '/settings';
  static const subjects = '/subjects';
  static const holidays = '/holidays';
  static const assignmentSettings = '/assignment-settings';
  static const subjectsSettings = '/subjects-settings';
  static const scheduleSettings = '/schedule-settings';
  static const assignmentDetails = '/assignment-details';
  static const addAssignment = '/add-assignment';
  static const addHoliday = '/add-holiday';
  static const addSchedule = '/add-schedule';
  static const addSubject = '/add-subject';
  static const all = [
    home,
    schedule,
    assignments,
    settings,
    subjects,
    holidays,
    assignmentSettings,
    subjectsSettings,
    scheduleSettings,
    assignmentDetails,
    addAssignment,
    addHoliday,
    addSchedule,
    addSubject,
  ];
}

class Router extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.home:
        if (hasInvalidArgs<HomePageArguments>(args)) {
          return misTypedArgsRoute<HomePageArguments>(args);
        }
        final typedArgs = args as HomePageArguments ?? HomePageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              HomePage(typedArgs.tabsChangeNotifier),
          settings: settings,
        );
      case Routes.schedule:
        if (hasInvalidArgs<SchedulePageArguments>(args)) {
          return misTypedArgsRoute<SchedulePageArguments>(args);
        }
        final typedArgs =
            args as SchedulePageArguments ?? SchedulePageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              SchedulePage(typedArgs.tabsChangeNotifier),
          settings: settings,
        );
      case Routes.assignments:
        if (hasInvalidArgs<AssignmentsPageArguments>(args)) {
          return misTypedArgsRoute<AssignmentsPageArguments>(args);
        }
        final typedArgs =
            args as AssignmentsPageArguments ?? AssignmentsPageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              AssignmentsPage(typedArgs.tabsChangeNotifier),
          settings: settings,
        );
      case Routes.settings:
        if (hasInvalidArgs<SettingsPageArguments>(args)) {
          return misTypedArgsRoute<SettingsPageArguments>(args);
        }
        final typedArgs =
            args as SettingsPageArguments ?? SettingsPageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              SettingsPage(typedArgs.tabsChangeNotifier),
          settings: settings,
        );
      case Routes.subjects:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) => SubjectsPage(),
          settings: settings,
        );
      case Routes.holidays:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              ScheduleHolidaysPage(),
          settings: settings,
        );
      case Routes.assignmentSettings:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              AssignmentsSettingsPage(),
          settings: settings,
        );
      case Routes.subjectsSettings:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              SubjectsSettingsPage(),
          settings: settings,
        );
      case Routes.scheduleSettings:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              ScheduleSettingsPage(),
          settings: settings,
        );
      case Routes.assignmentDetails:
        if (hasInvalidArgs<AssignmentDetailsPageArguments>(args)) {
          return misTypedArgsRoute<AssignmentDetailsPageArguments>(args);
        }
        final typedArgs = args as AssignmentDetailsPageArguments ??
            AssignmentDetailsPageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              AssignmentDetailsPage(
                  typedArgs.assignment, typedArgs.assignmentSubject),
          settings: settings,
        );
      case Routes.addAssignment:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              AddAssignmentPage(),
          settings: settings,
        );
      case Routes.addHoliday:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) => AddHolidayPage(),
          settings: settings,
        );
      case Routes.addSchedule:
        if (hasInvalidArgs<AddSchedulePageArguments>(args)) {
          return misTypedArgsRoute<AddSchedulePageArguments>(args);
        }
        final typedArgs =
            args as AddSchedulePageArguments ?? AddSchedulePageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              AddSchedulePage(subject: typedArgs.subject),
          settings: settings,
        );
      case Routes.addSubject:
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

//HomePage arguments holder class
class HomePageArguments {
  final ValueNotifier<int> tabsChangeNotifier;
  HomePageArguments({this.tabsChangeNotifier});
}

//SchedulePage arguments holder class
class SchedulePageArguments {
  final ValueNotifier<int> tabsChangeNotifier;
  SchedulePageArguments({this.tabsChangeNotifier});
}

//AssignmentsPage arguments holder class
class AssignmentsPageArguments {
  final ValueNotifier<int> tabsChangeNotifier;
  AssignmentsPageArguments({this.tabsChangeNotifier});
}

//SettingsPage arguments holder class
class SettingsPageArguments {
  final ValueNotifier<int> tabsChangeNotifier;
  SettingsPageArguments({this.tabsChangeNotifier});
}

//AssignmentDetailsPage arguments holder class
class AssignmentDetailsPageArguments {
  final Assignment assignment;
  final Subject assignmentSubject;
  AssignmentDetailsPageArguments({this.assignment, this.assignmentSubject});
}

//AddSchedulePage arguments holder class
class AddSchedulePageArguments {
  final Subject subject;
  AddSchedulePageArguments({this.subject});
}
