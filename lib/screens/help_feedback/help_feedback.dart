import 'package:flutter/material.dart';
import 'package:school_life/services/theme_service.dart';

import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/widgets/drawer/custom_drawer.dart';

class HelpFeedbackPage extends StatelessWidget {
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
