import 'package:flutter/material.dart';
import 'package:school_life/services/theme_service.dart';
import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/widgets/lifecycle_event_handler/lifecycle_events.dart';

class AssignmentsSettingsPage extends StatefulWidget {
  @override
  _AssignmentsSettingsPageState createState() =>
      _AssignmentsSettingsPageState();
}

class _AssignmentsSettingsPageState extends State<AssignmentsSettingsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(LifecycleEventHandler(
        resumeCallBack: () => ThemeService().checkMatchingBrightness(context)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Assignment Settings"),
      body: Placeholder(),
    );
  }
}
