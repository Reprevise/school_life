import 'package:flutter/material.dart';
import 'package:school_life/widgets/appbar/custom_appbar.dart';

class SubjectsSettingsPage extends StatefulWidget {
  @override
  _SubjectsSettingsPageState createState() =>
      _SubjectsSettingsPageState();
}

class _SubjectsSettingsPageState extends State<SubjectsSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Subject Settings"),
      body: Placeholder(),
    );
  }
}
