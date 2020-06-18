// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:school_life/screens/home/home.dart';
import 'package:school_life/screens/schedule/schedule.dart';
import 'package:school_life/screens/subjects/subjects.dart';
import 'package:school_life/screens/assignments/assignments.dart';
import 'package:school_life/screens/settings/settings.dart';
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
  static const subjects = '/subjects';
  static const assignments = '/assignments';
  static const settings = '/settings';
  static const holidays = '/holidays';
  static const assignmentSettings = '/assignment-settings';
  static const subjectsSettings = '/subjects-settings';
  static const scheduleSettings = '/schedule-settings';
  static const assignmentDetails = '/assignment-details';
  static const addAssignment = '/add-assignment';
  static const addHoliday = '/add-holiday';
  static const addSchedule = '/add-schedule';
  static const addSubject = '/add-subject';
  static const all = {
    home,
    schedule,
    subjects,
    assignments,
    settings,
    holidays,
    assignmentSettings,
    subjectsSettings,
    scheduleSettings,
    assignmentDetails,
    addAssignment,
    addHoliday,
    addSchedule,
    addSubject,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.home:
        if (hasInvalidArgs<HomePageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<HomePageArguments>(args);
        }
        final typedArgs = args as HomePageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomePage(typedArgs.tabsChangeNotifier),
          settings: settings,
        );
      case Routes.schedule:
        if (hasInvalidArgs<SchedulePageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<SchedulePageArguments>(args);
        }
        final typedArgs = args as SchedulePageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => SchedulePage(typedArgs.tabsChangeNotifier),
          settings: settings,
        );
      case Routes.subjects:
        if (hasInvalidArgs<SubjectsPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<SubjectsPageArguments>(args);
        }
        final typedArgs = args as SubjectsPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => SubjectsPage(typedArgs.tabsChangeNotifier),
          settings: settings,
        );
      case Routes.assignments:
        if (hasInvalidArgs<AssignmentsPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<AssignmentsPageArguments>(args);
        }
        final typedArgs = args as AssignmentsPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => AssignmentsPage(typedArgs.tabsChangeNotifier),
          settings: settings,
        );
      case Routes.settings:
        if (hasInvalidArgs<SettingsPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<SettingsPageArguments>(args);
        }
        final typedArgs = args as SettingsPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => SettingsPage(typedArgs.tabsChangeNotifier),
          settings: settings,
        );
      case Routes.holidays:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ScheduleHolidaysPage(),
          settings: settings,
        );
      case Routes.assignmentSettings:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AssignmentsSettingsPage(),
          settings: settings,
        );
      case Routes.subjectsSettings:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SubjectsSettingsPage(),
          settings: settings,
        );
      case Routes.scheduleSettings:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ScheduleSettingsPage(),
          settings: settings,
        );
      case Routes.assignmentDetails:
        if (hasInvalidArgs<AssignmentDetailsPageArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<AssignmentDetailsPageArguments>(args);
        }
        final typedArgs = args as AssignmentDetailsPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => AssignmentDetailsPage(
              typedArgs.assignment, typedArgs.assignmentSubject),
          settings: settings,
        );
      case Routes.addAssignment:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AddAssignmentPage(),
          settings: settings,
        );
      case Routes.addHoliday:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AddHolidayPage(),
          settings: settings,
        );
      case Routes.addSchedule:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AddSchedulePage(),
          settings: settings,
        );
      case Routes.addSubject:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AddSubjectPage(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//HomePage arguments holder class
class HomePageArguments {
  final ValueNotifier<int> tabsChangeNotifier;
  HomePageArguments({@required this.tabsChangeNotifier});
}

//SchedulePage arguments holder class
class SchedulePageArguments {
  final ValueNotifier<int> tabsChangeNotifier;
  SchedulePageArguments({@required this.tabsChangeNotifier});
}

//SubjectsPage arguments holder class
class SubjectsPageArguments {
  final ValueNotifier<int> tabsChangeNotifier;
  SubjectsPageArguments({@required this.tabsChangeNotifier});
}

//AssignmentsPage arguments holder class
class AssignmentsPageArguments {
  final ValueNotifier<int> tabsChangeNotifier;
  AssignmentsPageArguments({@required this.tabsChangeNotifier});
}

//SettingsPage arguments holder class
class SettingsPageArguments {
  final ValueNotifier<int> tabsChangeNotifier;
  SettingsPageArguments({@required this.tabsChangeNotifier});
}

//AssignmentDetailsPage arguments holder class
class AssignmentDetailsPageArguments {
  final Assignment assignment;
  final Subject assignmentSubject;
  AssignmentDetailsPageArguments(
      {@required this.assignment, @required this.assignmentSubject});
}
