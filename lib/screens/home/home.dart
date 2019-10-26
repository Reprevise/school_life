import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:school_life/services/theme_service.dart';
import 'package:school_life/theme/themes.dart';

import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/widgets/drawer/custom_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
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
      _changeSystemColorsBasedOnBrightness();
    }
  }

  @override
  Widget build(BuildContext context) {
    _changeSystemColorsBasedOnBrightness();
    return Scaffold(
      appBar: CustomAppBar(title: "Home"),
      drawer: CustomDrawer(),
      body: Placeholder(),
    );
  }

  void _changeSystemColorsBasedOnBrightness() async {
    final Brightness platformBrightness =
        MediaQuery.of(context).platformBrightness;
    final Brightness themeBrightness = DynamicTheme.of(context).brightness;
    final bool canChangeSystemBrightness =
        await ThemeService().checkDeviceCompatableToChangeTheme();
    if (!canChangeSystemBrightness) {
      // you don't have night/dark mode but you're above android v7
      ThemeService().changeBrightness(themeBrightness, context);
    } else {
      // you are above android 10 (google) or android 9 (samsung)
      ThemeService().changeBrightness(platformBrightness, context);
    }
    // set theme & system colors based on system brightness or current theme
  }
}
