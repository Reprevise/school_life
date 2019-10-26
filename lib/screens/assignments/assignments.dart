import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:school_life/screens/forms/add_assignnment/add_assignment.dart';
import 'package:school_life/screens/settings/children/assignments-set.dart';
import 'package:school_life/services/assignments_db/repo_service_assignment.dart';
import 'package:school_life/services/subjects_db/repo_service_subject.dart';
import 'package:school_life/util/models/assignment.dart';

import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/widgets/drawer/custom_drawer.dart';

class AssignmentsPage extends StatefulWidget {
  @override
  _AssignmentsPageState createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  Future<List<Assignment>> future;

  @override
  void initState() {
    refreshAssignments();
    super.initState();
  }

  @override
  void didUpdateWidget(AssignmentsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Assignments",
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (_) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AssignmentsSettingsPage(),
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
      ),
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 2.0,
        onPressed: () {
          RepositoryServiceSubject.getAllSubjects().then((subjects) {
            if (subjects.isEmpty) {
              userHasNoSubjects();
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddAssignmentPage()),
            );
          });
        },
        label: Text(
          "Add Assignment",
          style: TextStyle(fontFamily: "OpenSans"),
        ),
        icon: Icon(Icons.add),
      ),
      body: ListView(
        primary: false,
        padding: EdgeInsets.only(top: 20, bottom: 70),
        children: <Widget>[
          buildAssignmentFuture(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  refreshAssignments() {
    setState(() {
      future = RepositoryServiceAssignment.getAllAssignments();
    });
  }

  _deleteAssignment(Assignment assignment) async {
    await RepositoryServiceAssignment.deleteAssignment(assignment);
    setState(() {
      future = RepositoryServiceAssignment.getAllAssignments();
    });
  }

  Widget buildItem(Assignment assignment) {
    return Card(
      color: Theme.of(context).accentColor,
      elevation: 3.0,
      child: InkWell(
        onTap: () {},
        onLongPress: () => _handleDeleteAssignment(context, assignment),
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
                  children: <Widget>[],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8),
                child: Row(
                  children: <Widget>[],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleDeleteAssignment(BuildContext context, Assignment assignment) {
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
                    ))
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
                _deleteAssignment(assignment);
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

  Widget buildAssignmentFuture() {
    return FutureBuilder<List<Assignment>>(
      future: future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.data.length > 0) {
              return Column(
                children: snapshot.data
                    .map(
                      (assignment) => buildItem(assignment),
                    )
                    .toList(),
              );
            } else {
              return SafeArea(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.assignment,
                      color: Colors.grey[400],
                      size: 128.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AutoSizeText(
                        "You don't have any assignments due!",
                        maxLines: 1,
                        wrapWords: false,
                        minFontSize: 15,
                        maxFontSize: 21,
                        style: Theme.of(context).textTheme.display2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AutoSizeText(
                      "Woo-hoo!",
                      maxLines: 1,
                      wrapWords: false,
                      minFontSize: 12,
                      maxFontSize: 18,
                      style: Theme.of(context)
                          .textTheme
                          .display2
                          .copyWith(fontSize: 18),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            }
        }
      },
    );
  }

  userHasNoSubjects() {
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
