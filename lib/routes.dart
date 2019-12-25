import 'package:flutter/widgets.dart';
import 'package:school_life/screens/assignments/assignments.dart';
import 'package:school_life/screens/help_feedback/help_feedback.dart';
import 'package:school_life/screens/home/home.dart';
import 'package:school_life/screens/schedule/schedule.dart';
import 'package:school_life/screens/settings/settings.dart';
import 'package:school_life/screens/subjects/subjects.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/': (context) => HomePage(),
  '/assignments': (context) => AssignmentsPage(),
  '/schedule': (context) => SchedulePage(),
  '/subjects': (context) => SubjectsPage(),
  '/settings': (context) => SettingsPage(),
  '/help-feedback': (context) => HelpFeedbackPage(),
};
