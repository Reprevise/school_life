import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../components/screen_header/screen_header.dart';
import '../../services/databases/subjects_repository.dart';
import '../../services/stacked/dialogs.dart';
import '../../util/date_utils.dart';
import 'widgets/header.dart';
import 'widgets/schedules_list.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool _userHasSubjects = false;
  bool _userHasSubjectsWithoutSchedule = false;
  late DateTime selectedCalendarDay;
  final ns = locator<NavigationService>();
  final ds = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    selectedCalendarDay = DateTime.now().onlyDate;
    _getSubjectInfo();
  }

  void _getSubjectInfo() {
    final subjects = locator<SubjectsRepository>();
    if (subjects.subjects.isNotEmpty) {
      _userHasSubjects = true;
    }
    if (subjects.subjectsWithoutSchedule.isNotEmpty) {
      _userHasSubjectsWithoutSchedule = true;
    }
  }

  void onDayChanged(DateTime selectedDay) {
    setState(() {
      selectedCalendarDay = selectedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          primary: false,
          children: <Widget>[
            buildScreenHeader(),
            ScheduleHeader(
              onDaySelected: onDayChanged,
              focusedDay: selectedCalendarDay,
            ),
            SchedulesList(
              selectedDay: selectedCalendarDay,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleAddScheduleButtonPress,
        label: const Text('Add Schedule'),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildScreenHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const ScreenHeader('Schedule'),
        IconButton(
          icon: const Icon(Icons.today),
          onPressed: () {
            final now = DateTime.now().onlyDate;
            setState(() {
              selectedCalendarDay = now;
            });
          },
        ),
      ],
    );
  }

  void _handleAddScheduleButtonPress() {
    if (!_userHasSubjects) {
      ds.showCustomDialog(variant: DialogType.noSubjects);
      return;
    }
    if (!_userHasSubjectsWithoutSchedule) {
      ds.showCustomDialog(variant: DialogType.noSubjectsWithoutSchedule);
      return;
    }
    ns.navigateTo(Routes.addSchedulePage);
  }
}
