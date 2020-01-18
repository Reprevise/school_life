import 'package:auto_route/auto_route_annotations.dart';
import 'package:school_life/screens/assignments/assignments.dart';
import 'package:school_life/screens/help_feedback/help_feedback.dart';
import 'package:school_life/screens/home/home.dart';
import 'package:school_life/screens/schedule/schedule.dart';
import 'package:school_life/screens/settings/settings.dart';
import 'package:school_life/screens/subjects/subjects.dart';

@AutoRouter(generateRouteList: true)
class $Router {
  @initial
  HomePage home;
  AssignmentsPage assignments;
  SchedulePage schedule;
  SubjectsPage subjects;
  SettingsPage settings;
  HelpFeedbackPage helpFeedback;
}
