import 'package:flutter/material.dart';
import 'package:school_life/components/dialog/dialogs.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/screens/forms/add_schedule/add_schedule.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool _userHasSubjects = false;

  @override
  void initState() {
    super.initState();
    _doesUserHaveSubjects();
  }

  void _doesUserHaveSubjects() async {
    List<Subject> subjects = await SubjectsRepository.getAllSubjects();
    if (subjects.isNotEmpty) {
      setState(() {
        _userHasSubjects = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Schedule"),
      drawer: CustomDrawer(),
      body: Container(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _handleAddScheduleButtonPress(context),
        label: const Text("Add Subject Schedule"),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _handleAddScheduleButtonPress(BuildContext context) {
    if (!_userHasSubjects) {
      showNoSubjectsDialog(context);
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddSchedulePage(),
      ),
    );
  }
}
