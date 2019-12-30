import 'package:flutter/material.dart';
import 'package:school_life/components/dialog/dialogs.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/screens/assignments/widgets/assignments_list.dart';
import 'package:school_life/screens/forms/add_assignnment/add_assignment.dart';
import 'package:school_life/screens/settings/pages/assignments-set.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

class AssignmentsPage extends StatefulWidget {
  @override
  _AssignmentsPageState createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  SubjectsRepository subjects;
  Map<int, Subject> _assignmentSubjectsByID;
  bool _userHasSubjects = false;

  @override
  void initState() {
    super.initState();
    subjects = getIt<SubjectsRepository>();
    _doesUserHaveSubjects();
    _getSubjectsMap();
  }

  void _doesUserHaveSubjects() {
    List<Subject> allSubjects = subjects.getAllSubjects();
    if (allSubjects.isNotEmpty) {
      setState(() {
        _userHasSubjects = true;
      });
    }
  }

  void _getSubjectsMap() {
    Map<int, Subject> subjectsByID = subjects.getSubjectsMap();
    setState(() {
      _assignmentSubjectsByID = subjectsByID;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_assignmentSubjectsByID == null)
      return Center(child: CircularProgressIndicator());
    return Scaffold(
      appBar: CustomAppBar(
        "Assignments",
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AssignmentsSettingsPage(),
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _handleAddAssignmentPress(context),
        label: const Text("ADD ASSIGNMENT"),
        icon: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        primary: false,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.only(top: 20, bottom: 70),
        child: Center(
          child: AssignmentsList(
            _assignmentSubjectsByID,
          ),
        ),
      ),
    );
  }

  void _handleAddAssignmentPress(BuildContext context) {
    if (!_userHasSubjects) {
      showNoSubjectsDialog(context);
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAssignmentPage(),
      ),
    );
  }
}
