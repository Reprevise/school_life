// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:school_life/screens/home/home.dart';
import 'package:school_life/screens/assignments/assignments.dart';
import 'package:school_life/screens/schedule/schedule.dart';
import 'package:school_life/screens/subjects/subjects.dart';
import 'package:school_life/screens/settings/settings.dart';
import 'package:school_life/screens/help_feedback/help_feedback.dart';

class Router {
  static const home = '/';
  static const assignments = '/assignments';
  static const schedule = '/schedule';
  static const subjects = '/subjects';
  static const settings = '/settings';
  static const helpFeedback = '/help-feedback';
  static const routes = [
    home,
    assignments,
    schedule,
    subjects,
    settings,
    helpFeedback,
  ];
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.home:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
          settings: settings,
        );
      case Router.assignments:
        return MaterialPageRoute(
          builder: (_) => AssignmentsPage(),
          settings: settings,
        );
      case Router.schedule:
        return MaterialPageRoute(
          builder: (_) => SchedulePage(),
          settings: settings,
        );
      case Router.subjects:
        return MaterialPageRoute(
          builder: (_) => SubjectsPage(),
          settings: settings,
        );
      case Router.settings:
        return MaterialPageRoute(
          builder: (_) => SettingsPage(),
          settings: settings,
        );
      case Router.helpFeedback:
        return MaterialPageRoute(
          builder: (_) => HelpFeedbackPage(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
