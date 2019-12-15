import 'package:flutter/material.dart';
import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/widgets/drawer/custom_drawer.dart';

class HelpFeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Help & Feedback"),
      drawer: CustomDrawer(),
      body: Container(),
    );
  }
}
