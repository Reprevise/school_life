import 'package:flutter/material.dart';
import 'package:school_life/components/dialog/dialogs.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/screens/assignments/widgets/assignments_list.dart';
import 'package:school_life/screens/forms/add_assignnment/add_assignment.dart';
import 'package:school_life/screens/settings/children/assignments-set.dart';
import 'package:school_life/services/databases/assignments_repository.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

class AssignmentsPage extends StatefulWidget {
  @override
  _AssignmentsPageState createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  Future<List<Assignment>> _future;
  Map<int, Subject> _assignmentSubjectsByID;
  bool _userHasSubjects = false;

  @override
  void initState() {
    super.initState();
    _future = AssignmentsRepository.getAllAssignments();
    _doesUserHaveSubjects();
    _getSubjectsMap();
  }

  void _doesUserHaveSubjects() async {
    List<Subject> subjects = await SubjectsRepository.getAllSubjects();
    if (subjects.isNotEmpty) {
      setState(() {
        _userHasSubjects = true;
      });
    }
  }

  void _getSubjectsMap() async {
    Map<int, Subject> subjectsByID = await SubjectsRepository.getSubjectsMap();
    setState(() {
      _assignmentSubjectsByID = subjectsByID;
    });
  }

  void deleteAssignment(Assignment assignment) async {
    await assignment.delete();
    refreshAssignments();
  }

  void refreshAssignments() {
    Future<List<Assignment>> assignments = AssignmentsRepository.getAllAssignments();
    setState(() {
      _future = assignments;
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
        label: const Text("Add Assignment"),
        icon: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        primary: false,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.only(top: 20, bottom: 70),
        child: Center(
          child: AssignmentsList(
            _future,
            _assignmentSubjectsByID,
            deleteAssignment,
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
