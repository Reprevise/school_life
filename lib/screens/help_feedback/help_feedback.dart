import 'package:flutter/material.dart';
import 'package:school_life/services/theme_service.dart';

import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/widgets/drawer/custom_drawer.dart';
import 'package:school_life/widgets/lifecycle_event_handler/lifecycle_events.dart';

class HelpFeedbackPage extends StatefulWidget {
  @override
  _HelpFeedbackPageState createState() => _HelpFeedbackPageState();
}

class _HelpFeedbackPageState extends State<HelpFeedbackPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(LifecycleEventHandler(
        resumeCallBack: () => ThemeService().checkMatchingBrightness(context)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeService().checkMatchingBrightness(context);
    return Scaffold(
      appBar: CustomAppBar(title: "Help & Feedback"),
      drawer: CustomDrawer(),
      body: Placeholder(),
    );
  }
}
