import 'package:flutter/material.dart';
import 'package:school_life/components/dialogs/dialogs.dart';
import 'package:school_life/components/navbar/navbar.dart';
import 'package:school_life/components/screen_header/screen_header.dart';
import 'package:school_life/main.dart';
import 'package:school_life/router/router.gr.dart';
import 'package:school_life/screens/schedule/widgets/header.dart';
import 'package:school_life/screens/schedule/widgets/schedules_list.dart';
import 'package:school_life/services/databases/subjects_repository.dart';
import 'package:school_life/util/date_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePage extends StatefulWidget {
  final ValueNotifier<int> tabsChangeNotifier;

  SchedulePage(this.tabsChangeNotifier);


  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool _userHasSubjects = false;
  bool _userHasSubjectsWithoutSchedule = false;
  DateTime selectedCalendarDay;
  final CalendarController controller = CalendarController();

  @override
  void initState() {
    super.initState();
    selectedCalendarDay = DateTime.now().onlyDate;
    _getSubjectInfo();
  }

  void _getSubjectInfo() {
    final subjects = sl<SubjectsRepository>();
    if (subjects.subjects.isNotEmpty) {
      _userHasSubjects = true;
    }
    if (subjects.subjectsWithoutSchedule.isNotEmpty) {
      _userHasSubjectsWithoutSchedule = true;
    }
  }

  void onDayChanged(DateTime day, List<dynamic> events) {
    setState(() {
      selectedCalendarDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(widget.tabsChangeNotifier),
      body: SafeArea(
        child: ListView(
          primary: false,
          children: <Widget>[
            // TODO: sync days of school in settings with calendar
            buildScreenHeader(),
            ScheduleHeader(
              onDaySelected: onDayChanged,
              controller: controller,
            ),
            SchedulesList(
              selectedDay: selectedCalendarDay,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleAddScheduleButtonPress,
        label: Text(
          'Add Schedule',
          style: Theme.of(context).accentTextTheme.bodyText1,
        ),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildScreenHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ScreenHeader('Schedule'),
        IconButton(
          icon: Icon(Icons.today),
          onPressed: () {
            final now = DateTime.now().onlyDate;
            setState(() {
              selectedCalendarDay = now;
              controller.setSelectedDay(now);
              controller.setFocusedDay(now);
            });
          },
        ),
      ],
    );
  }

  void _handleAddScheduleButtonPress() {
    if (!_userHasSubjects) {
      showNoSubjectsDialog(context);
      return;
    }
    if (!_userHasSubjectsWithoutSchedule) {
      showNoSubjectsWithoutScheduleDialog(context);
      return;
    }
    Router.navigator.pushNamed(Routes.addSchedule);
  }
}
