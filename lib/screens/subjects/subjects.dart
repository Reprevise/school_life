import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:school_life/components/dialog/dialogs.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/routing/router.gr.dart';
import 'package:school_life/screens/settings/pages/index.dart';
import 'package:school_life/screens/subjects/add_subject/add_subject.dart';
import 'package:school_life/screens/subjects/widgets/subjects_list.dart';
import 'package:school_life/services/databases/subjects_repository.dart';

class SubjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(
        DynamicTheme.of(context).brightness == Brightness.dark);

    return Scaffold(
      appBar: CustomAppBar(
        'Subjects',
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Router.navigator.push(
              MaterialPageRoute<SubjectsSettingsPage>(
                builder: (BuildContext context) => SubjectsSettingsPage(),
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _handleAddSubjectButtonPress(context),
        label: const Text('ADD SUBJECT'),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, bottom: 70),
        child: Center(
          child: SubjectsList(),
        ),
      ),
    );
  }

  Future<void> _handleAddSubjectButtonPress(BuildContext context) async {
    final List<Subject> subjectList =
        getIt<SubjectsRepository>().getAllSubjects();
    if (subjectList.length >= 19) {
      showTooManySubjectsDialog(context);
      return;
    }
    Router.navigator.push(
      MaterialPageRoute<AddSubjectPage>(
        builder: (BuildContext context) => AddSubjectPage(),
      ),
    );
  }
}
