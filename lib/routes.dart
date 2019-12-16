import 'package:flutter/widgets.dart';
import 'package:school_life/ui/assignments/assignments.dart';
import 'package:school_life/ui/calendar/calendar.dart';
import 'package:school_life/ui/help_feedback/help_feedback.dart';
import 'package:school_life/ui/home/home.dart';
import 'package:school_life/ui/schedule/schedule.dart';
import 'package:school_life/ui/settings/settings.dart';
import 'package:school_life/ui/subjects/subjects.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/': (context) => HomePage(),
  '/assignments': (context) => AssignmentsPage(),
  '/calendar': (context) => CalendarPage(),
  '/schedule': (context) => SchedulePage(),
  '/subjects': (context) => SubjectsPage(),
  '/settings': (context) => SettingsPage(),
  '/help-feedback': (context) => HelpFeedbackPage(),
};
