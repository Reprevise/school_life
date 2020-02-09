import 'package:flutter/material.dart';

import 'package:school_life/components/dialog/dialogs.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/routing/router.gr.dart';
import 'package:school_life/screens/assignments/add_assignnment/add_assignment.dart';
import 'package:school_life/screens/assignments/widgets/assignments_list.dart';
import 'package:school_life/screens/settings/pages/index.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

class AssignmentsPage extends StatefulWidget {
  @override
  _AssignmentsPageState createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  SubjectsRepository subjects;
  bool _userHasSubjects = false;

  @override
  void initState() {
    super.initState();
    subjects = sl<SubjectsRepository>();
    _doesUserHaveSubjects();
  }

  void _doesUserHaveSubjects() {
    final List<Subject> allSubjects = subjects.subjects;
    if (allSubjects.isNotEmpty) {
      _userHasSubjects = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        'Assignments',
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Router.navigator.push(
              MaterialPageRoute<AssignmentsSettingsPage>(
                builder: (BuildContext context) => AssignmentsSettingsPage(),
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleAddAssignmentPress,
        label: const Text('ADD ASSIGNMENT'),
        icon: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        primary: false,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.only(top: 20, bottom: 70),
        child: Center(
          child: AssignmentsList(),
        ),
      ),
    );
  }

  void _handleAddAssignmentPress() {
    if (!_userHasSubjects) {
      showNoSubjectsDialog(context);
      return;
    }
    Router.navigator.push<AddAssignmentPage>(
      MaterialPageRoute<AddAssignmentPage>(
        builder: (BuildContext context) => AddAssignmentPage(),
      ),
    );
  }
}
