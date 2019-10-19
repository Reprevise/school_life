import 'package:flutter/material.dart';

import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/widgets/drawer/custom_drawer.dart';

class UpgradePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Upgrade"),
      drawer: CustomDrawer(),
      body: Placeholder(),
    );
  }
}
