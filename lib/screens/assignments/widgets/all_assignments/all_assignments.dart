import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
    future = RepositoryServiceAssignment.getAllAssignments();
    super.initState();
    getAssignmentSubjects();
  }

  void getAssignmentSubjects() async {
    List<Assignment> assignments = await future;
    List<int> assignmentSubjectIDs = [];
    assignments.forEach((assignment) {
      assignmentSubjectIDs.add(assignment.subjectID);
    });
    Map<int, Subject> temp = {};
    assignmentSubjectIDs.forEach((id) {
      RepositoryServiceSubject.getSubject(id).then((_subjectFromID) {
        temp[id] = _subjectFromID;
      });
    });
    SchedulerBinding.instance.addPostFrameCallback((_) => setState(() {
          assignmentSubjectsByID = temp;
        }));
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
                    Subject currentAssignmentSubject =
                        assignmentSubjectsByID[assignment.subjectID];
                    return AssignmentItem(
                      assignment: assignment,
                      assignmentSubject: currentAssignmentSubject,
                      onLongPress: () => deleteAssignmentPopup(assignment),
                    );
                  },
                ).toList(),
              );
            } else {
              return SafeArea(
                child: Center(
                  child: Column(
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
                          style: Theme.of(context).textTheme.display2.copyWith(fontSize: fontSize),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Woo-hoo!",
                        style: Theme.of(context).textTheme.display2.copyWith(fontSize: fontSize/1.2),
                      ),
                    ],
                  ),
                ),
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
        return AlertDialog(
          title: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Theme.of(context).dialogTheme.titleTextStyle.color,
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
                style: TextStyle(
                  color: Theme.of(context).dialogTheme.contentTextStyle.color,
                ),
              ),
              onPressed: () {
                deleteAssignment(assignment);
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              child: Text(
                "No",
                style: TextStyle(
                  color: Theme.of(context).dialogTheme.contentTextStyle.color,
                ),
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

  AssignmentItem(
      {@required this.assignment, this.onLongPress, this.assignmentSubject});

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
