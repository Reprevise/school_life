import 'package:flutter/material.dart';

class AssignmentsSettingsPage extends StatelessWidget {
  const AssignmentsSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ListView(
        children: const <Widget>[
          Text('Assignments Settings'),
        ],
      ),
    );
  }
}
