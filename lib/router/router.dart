import 'package:auto_route/auto_route_annotations.dart';
import 'package:school_life/screens/assignments/add_assignnment/add_assignment.dart';
import 'package:school_life/screens/assignments/assignments.dart';
import 'package:school_life/screens/assignments/details/assignment_details.dart';
import 'package:school_life/screens/home/home.dart';
import 'package:school_life/screens/schedule/add_schedule/add_schedule.dart';
import 'package:school_life/screens/schedule/schedule.dart';
import 'package:school_life/screens/settings/pages/assignments/assignments_settings.dart';
import 'package:school_life/screens/settings/pages/schedule/schedule_settings.dart';
import 'package:school_life/screens/settings/pages/schedule/widgets/holidays.dart';
import 'package:school_life/screens/settings/pages/subjects/subjects_settings.dart';
import 'package:school_life/screens/settings/settings.dart';
import 'package:school_life/screens/subjects/add_subject/add_subject.dart';
import 'package:school_life/screens/subjects/subjects.dart';

@CustomAutoRouter(generateRouteList: true)
class $Router {
  @CustomRoute()
  HomePage home;
  SchedulePage schedule;
  AssignmentsPage assignments;
  SettingsPage settings;
  SubjectsPage subjects;
  ScheduleHolidaysPage holidays;

  AssignmentsSettingsPage assignmentSettings;
  SubjectsSettingsPage subjectsSettings;
  ScheduleSettingsPage scheduleSettings;

  AssignmentDetailsPage assignmentDetails;

  AddAssignmentPage addAssignment;
  AddHolidayPage addHoliday;
  AddSchedulePage addSchedule;
  AddSubjectPage addSubject;
}
