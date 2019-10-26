import 'package:flutter/material.dart';
import 'package:school_life/widgets/appbar/custom_appbar.dart';

class AssignmentsSettingsPage extends StatefulWidget {
  @override
  _AssignmentsSettingsPageState createState() =>
      _AssignmentsSettingsPageState();
}

class _AssignmentsSettingsPageState extends State<AssignmentsSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Assignment Settings"),
      body: Placeholder(),
    );
  }
}
