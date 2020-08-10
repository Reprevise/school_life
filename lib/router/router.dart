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

@MaterialAutoRouter(routes: [
  MaterialRoute(page: HomePage),
  MaterialRoute(page: SchedulePage),
  MaterialRoute(page: SubjectsPage),
  MaterialRoute(page: AssignmentsPage),
  MaterialRoute(page: SettingsPage),
  MaterialRoute(page: ScheduleHolidaysPage),
  MaterialRoute(page: AssignmentsSettingsPage),
  MaterialRoute(page: SubjectsSettingsPage),
  MaterialRoute(page: ScheduleSettingsPage),
  MaterialRoute(page: AssignmentDetailsPage),
  MaterialRoute(page: AddAssignmentPage),
  MaterialRoute(page: AddHolidayPage),
  MaterialRoute(page: AddSchedulePage),
  MaterialRoute(page: AddSubjectPage),
])
class $Router {}
