import 'package:flutter/material.dart';
import 'package:school_life/services/theme_service.dart';

import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/widgets/drawer/custom_drawer.dart';
import 'package:school_life/widgets/lifecycle_event_handler/lifecycle_events.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(LifecycleEventHandler(
        resumeCallBack: () => ThemeService().checkMatchingBrightness(context)));
  }

  @override
  Widget build(BuildContext context) {
    ThemeService().checkMatchingBrightness(context);
    print("HI");
    return Scaffold(
      appBar: CustomAppBar(title: "Home"),
      drawer: CustomDrawer(),
      body: Placeholder(),
    );
  }
}
