import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_life/services/subjects_db/repo_service_subject.dart';
import 'package:school_life/ui/forms/add_schedule/add_schedule.dart';
import 'package:school_life/util/models/subject.dart';
import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/widgets/drawer/custom_drawer.dart';

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
    List<Subject> subjects = await RepositoryServiceSubject.getAllSubjects();
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
        label: Text(
          "Add Subject Schedule",
          style: GoogleFonts.openSans(),
        ),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _handleAddScheduleButtonPress(BuildContext context) {
    if (!_userHasSubjects) {
      _showNoSubjectsDialog(context);
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddSchedulePage(),
      ),
    );
  }

  void _showNoSubjectsDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("No subjects found"),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
