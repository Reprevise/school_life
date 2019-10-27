import 'package:flutter/material.dart';
import 'package:school_life/services/theme_service.dart';
import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/widgets/lifecycle_event_handler/lifecycle_events.dart';

class SubjectsSettingsPage extends StatefulWidget {
  @override
  _SubjectsSettingsPageState createState() => _SubjectsSettingsPageState();
}

class _SubjectsSettingsPageState extends State<SubjectsSettingsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(LifecycleEventHandler(
        resumeCallBack: () => ThemeService().checkMatchingBrightness(context)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Subject Settings"),
      body: Placeholder(),
    );
  }
}
