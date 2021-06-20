import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../screens/assignments/add_assignnment/add_assignment.dart';
import '../screens/nav/nav_view.dart';
import '../screens/schedule/add_schedule/add_schedule.dart';
import '../screens/settings/pages/assignments/assignments_settings.dart';
import '../screens/settings/pages/schedule/schedule_settings.dart';
import '../screens/settings/pages/schedule/widgets/holidays.dart';
import '../screens/settings/pages/subjects/subjects_settings.dart';
import '../screens/subjects/add_subject/add_subject.dart';
import '../screens/subjects/details/subject_details.dart';
import '../services/databases/assignments_repository.dart';
import '../services/databases/holidays_repository.dart';
import '../services/databases/subjects_repository.dart';
import '../services/settings/schedule.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: NavView, initial: true),
    // assignments
    MaterialRoute(page: AssignmentsSettingsPage, path: '/assignmentsSettings'),
    MaterialRoute(page: AddAssignmentPage, path: '/addAssignment'),
    // schedule
    MaterialRoute(page: ScheduleHolidaysPage, path: '/holidays'),
    MaterialRoute(page: ScheduleSettingsPage, path: '/scheduleSettings'),
    MaterialRoute(page: AddSchedulePage, path: '/addSchedule'),
    MaterialRoute(page: AddHolidayPage, path: '/addHoliday'),
    // subjects
    MaterialRoute(page: AddSubjectPage, path: '/addSubject'),
    MaterialRoute(page: SubjectDetailsPage, path: '/subjectDetails'),
    MaterialRoute(page: SubjectsSettingsPage, path: '/subjectSettings'),
  ],
  dependencies: [
    // repositories
    LazySingleton(classType: AssignmentsRepository),
    LazySingleton(classType: HolidaysRepository),
    LazySingleton(classType: SubjectsRepository),
    // helpers
    LazySingleton(classType: ScheduleSettingsHelper),
    // stacked services
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
  ],
)
class App {}
