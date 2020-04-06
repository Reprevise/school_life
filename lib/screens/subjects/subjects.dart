import 'package:flutter/material.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/router/router.gr.dart';
import 'package:school_life/screens/subjects/widgets/subjects_list.dart';

class SubjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        'Subjects',
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () =>
                Router.navigator.pushNamed(Routes.subjectsSettings),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Router.navigator.pushNamed(Routes.addSubject),
        label: const Text('ADD SUBJECT'),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(child: SubjectsList()),
    );
  }
}
