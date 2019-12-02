import 'package:flutter/material.dart';
import 'package:school_life/ui/assignments/widgets/all_assignments/all_assignments.dart';
import 'package:school_life/ui/forms/add_assignnment/add_assignment.dart';
import 'package:school_life/ui/settings/children/assignments-set.dart';
import 'package:school_life/services/assignments_db/repo_service_assignment.dart';
import 'package:school_life/services/subjects_db/repo_service_subject.dart';
import 'package:school_life/services/theme_service.dart';
import 'package:school_life/util/models/assignment.dart';
import 'package:school_life/util/models/subject.dart';
import 'package:school_life/widgets/lifecycle/lifecycle_events_handler.dart';
import 'package:school_life/widgets/scaffold/custom_scaffold.dart';

class AssignmentsPage extends StatefulWidget {
  @override
  _AssignmentsPageState createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  Future<List<Assignment>> future;
  Map<int, Subject> assignmentSubjectsByID;

  @override
  void initState() {
    super.initState();
    future = RepositoryServiceAssignment.getAllAssignments();
    _getAssignmentSubjects();
  }

  void _getAssignmentSubjects() async {
    List<int> assignmentSubjectIDs = await _getSubjectsList();
    Map<int, Subject> assignmentSubjectsMap =
        await _getSubjectsMap(assignmentSubjectIDs);
    setState(() {
      assignmentSubjectsByID = assignmentSubjectsMap;
    });
  }

  Future<List<int>> _getSubjectsList() async {
    // get list of assignments
    final List<Assignment> assignments = await future;
    // create temporary list that holds the ids of all assignments
    final List<int> assignmentSubjectIDs = [];
    // loop through all the assignments to put all ids in above list
    for (Assignment assignment in assignments) {
      assignmentSubjectIDs.add(assignment.subjectID);
    }
    return assignmentSubjectIDs;
  }

  Future<Map<int, Subject>> _getSubjectsMap(
      List<int> assignmentSubjectIDs) async {
    // create temp map
    Map<int, Subject> subjectsByID = {};
    // loop through given subject ids
    // assignmentSubjectIDs.forEach((subjectID) async {
    for (int subjectID in assignmentSubjectIDs) {
      // get subject from current id
      final _subject = await RepositoryServiceSubject.getSubject(subjectID);
      // assign subject id to its subject
      subjectsByID[subjectID] = _subject;
    }
    return subjectsByID;
  }

  void refreshAssignments() {
    setState(() {
      future = RepositoryServiceAssignment.getAllAssignments();
    });
  }

  void deleteAssignment(Assignment assignment) async {
    await assignment.delete();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "Assignments",
      appBarActions: <Widget>[
        PopupMenuButton(
          onSelected: (_) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LifecycleEventsHandler(resumeCallback: () => ThemeService().updateColors(), child: AssignmentsSettingsPage()),
            ),
          ),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Text("Settings"),
                value: "Settings",
              ),
            ];
          },
        ),
      ],
      fabLocation: FloatingActionButtonLocation.centerFloat,
      fab: FloatingActionButton.extended(
        onPressed: () {
          RepositoryServiceSubject.getAllSubjects().then((subjects) {
            if (subjects.isEmpty) {
              userHasNoSubjects(context);
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAssignmentPage(),
              ),
            );
          });
        },
        label: Text(
          "Add Assignment",
          style: TextStyle(fontFamily: "OpenSans"),
        ),
        icon: Icon(Icons.add),
      ),
      scaffoldBody: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.only(top: 20, bottom: 70),
        child: Center(
          child: AllAssignments(
            future,
            assignmentSubjectsByID,
            deleteAssignment,
          ),
        ),
      ),
    );
  }

  void userHasNoSubjects(BuildContext context) {
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
