import 'package:flutter/material.dart';
import 'package:school_life/screens/forms/add_subject/add_subject.dart';
import 'package:school_life/screens/settings/children/subjects-set.dart';
import 'package:school_life/screens/subjects/widgets/all_subjects/all_subjects.dart';
import 'package:school_life/services/subjects_db/repo_service_subject.dart';
import 'package:school_life/util/models/subject.dart';
import 'package:school_life/widgets/scaffold/custom_scaffold.dart';

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  Future<List<Subject>> future;

  @override
  void initState() {
    refreshSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "Subjects",
      appBarActions: <Widget>[
        PopupMenuButton(
          onSelected: (_) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubjectsSettingsPage(),
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
      fab: FloatingActionButton.extended(
        onPressed: () {
          future.then((subjectList) {
            if (subjectList.length >= 19) {
              _showTooManySubjectsDialog();
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddSubjectPage(),
              ),
            );
          });
        },
        label: Text(
          "Add Subject",
          style: TextStyle(fontFamily: "OpenSans"),
        ),
        icon: Icon(Icons.add),
      ),
      fabLocation: FloatingActionButtonLocation.centerFloat,
      scaffoldBody: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20, bottom: 70),
        child: Center(
          child: AllSubjects(future, deleteSubject),
        ),
      ),
    );
  }

  void _showTooManySubjectsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Too many subjects",
            style: Theme.of(context).textTheme.display2,
          ),
          content: Text(
            "You have 19 subjects, that's a lot! \nUnfortunately, we don't support more than 19 subjects. :( \nHowever, we will in the future, stay tuned!",
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text("Aw :("),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  void deleteSubject(Subject subject) async {
    await subject.delete();
    refreshSubjects();
  }

  void refreshSubjects() {
    setState(() {
      future = RepositoryServiceSubject.getAllSubjects();
    });
  }
}
