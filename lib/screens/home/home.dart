import 'package:flutter/material.dart';
import 'package:school_life/services/theme_service.dart';

import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/widgets/drawer/custom_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    ThemeService().changeToSysBrightness(context);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      ThemeService().changeToSysBrightness(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("HI");
    //! causes a constant loop, needs fix
    ThemeService().changeToSysBrightness(context);
    return Scaffold(
      appBar: CustomAppBar(title: "Home"),
      drawer: CustomDrawer(),
      body: Placeholder(),
    );
  }
}
