import 'package:flutter/material.dart';
import 'package:school_life/services/subjects_db/repo_service_subject.dart';
import 'package:school_life/screens/forms/add_subject/add_subject.dart';
import 'package:school_life/screens/settings/children/subjects-set.dart';
import 'package:school_life/screens/subjects/widgets/all_subjects/all_subjects.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/components/index.dart';

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  Future<List<Subject>> future;

  @override
  void initState() {
    super.initState();
    future = RepositoryServiceSubject.getAllSubjects();
  }

  @override
  Widget build(BuildContext context) {
    print("subjects rebuilding");
    return Scaffold(
      appBar: CustomAppBar(
        "Subjects",
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SubjectsSettingsPage(),
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleAddSubjectButtonPress,
        label: const Text("Add Subject"),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20, bottom: 70),
        child: Center(
          child: AllSubjects(future, deleteSubject),
        ),
      ),
    );
  }

  Future<void> _handleAddSubjectButtonPress() async {
    final List<Subject> subjectList = await future;
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
