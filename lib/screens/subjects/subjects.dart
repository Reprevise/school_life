import 'package:flutter/material.dart';
import 'package:school_life/components/dialog/dialogs.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/screens/forms/add_subject/add_subject.dart';
import 'package:school_life/screens/settings/children/subjects-set.dart';
import 'package:school_life/screens/subjects/widgets/subjects_list.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  Future<List<Subject>> future;

  @override
  void initState() {
    super.initState();
    future = SubjectsRepository.getAllSubjects();
  }

  @override
  Widget build(BuildContext context) {
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
        onPressed: () => _handleAddSubjectButtonPress(context),
        label: const Text("Add Subject"),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20, bottom: 70),
        child: Center(
          child: SubjectsList(future, deleteSubject),
        ),
      ),
    );
  }

  Future<void> _handleAddSubjectButtonPress(BuildContext context) async {
    final List<Subject> subjectList = await future;
    if (subjectList.length >= 19) {
      showTooManySubjectsDialog(context);
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddSubjectPage(),
      ),
    );
  }

  void deleteSubject(Subject subject) async {
    await subject.delete();
    refreshSubjects();
  }

  void refreshSubjects() {
    Future<List<Subject>> subjects = SubjectsRepository.getAllSubjects();
    setState(() {
      future = subjects;
    });
  }
}
