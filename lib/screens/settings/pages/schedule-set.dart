import 'package:flutter/material.dart';
import 'package:school_life/components/index.dart';

class ScheduleSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Schedule Settings"),
      body: ListView(
        primary: false,
        children: <Widget>[
          ListTile(
            title: Text(""),
          )
        ],
      ),
    );
  }
}
