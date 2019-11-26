import 'package:flutter/material.dart';
import 'package:school_life/services/assignments_db/repo_service_assignment.dart';
import 'package:school_life/services/subjects_db/repo_service_subject.dart';
import 'package:school_life/util/models/assignment.dart';
import 'package:school_life/util/models/subject.dart';

class AllAssignments extends StatefulWidget {
  @override
  _AllAssignmentsState createState() => _AllAssignmentsState();
}

class _AllAssignmentsState extends State<AllAssignments> {
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
    refreshAssignments();
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width / 20;

    return FutureBuilder<List<Assignment>>(
      future: future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            if (snapshot.data.length > 0) {
              return Column(
                children: snapshot.data.map(
                  (assignment) {
                    if (assignmentSubjectsByID == null)
                      return Center(child: CircularProgressIndicator());
                    Subject currentSubject =
                        assignmentSubjectsByID[assignment.subjectID];
                    return AssignmentItem(
                      assignment: assignment,
                      assignmentSubject: currentSubject,
                      onLongPress: () => deleteAssignmentPopup(assignment),
                    );
                  },
                ).toList(),
              );
            } else {
              return Column(
                children: <Widget>[
                  Icon(
                    Icons.assignment,
                    color: Colors.grey[400],
                    size: 128.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "You don't have any assignments due!",
                      style: Theme.of(context)
                          .textTheme
                          .display2
                          .copyWith(fontSize: fontSize),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Woo-hoo!",
                    style: Theme.of(context)
                        .textTheme
                        .display2
                        .copyWith(fontSize: fontSize / 1.2),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }
        }
      },
    );
  }

  void deleteAssignmentPopup(Assignment assignment) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        final DialogTheme _dialogTheme = Theme.of(context).dialogTheme;
        final Color _contentStyleColor = _dialogTheme.contentTextStyle.color;
        return AlertDialog(
          title: RichText(
            text: TextSpan(
              style: TextStyle(
                color: _dialogTheme.titleTextStyle.color,
                fontSize: 16,
              ),
              children: <TextSpan>[
                TextSpan(text: "Do you want to delete "),
                TextSpan(
                  text: "${assignment.name}?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text(
                "Yes",
                style: TextStyle(color: _contentStyleColor),
              ),
              onPressed: () {
                deleteAssignment(assignment);
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              child: Text(
                "No",
                style: TextStyle(color: _contentStyleColor),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }
}

class AssignmentItem extends StatelessWidget {
  final Assignment assignment;
  final Function onLongPress;
  final Subject assignmentSubject;

  AssignmentItem({
    @required this.assignment,
    this.onLongPress,
    this.assignmentSubject,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).accentColor,
      elevation: 3.0,
      child: InkWell(
        onTap: () {},
        onLongPress: onLongPress,
        child: Container(
          height: 100,
          width: 375,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[Text(assignment.name)],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8),
                child: Row(
                  children: <Widget>[
                    Text(assignmentSubject.name),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(assignment.dueDate.toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
