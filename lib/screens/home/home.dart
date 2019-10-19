import 'package:flutter/material.dart';
import 'package:school_life/services/theme_service.dart';
import 'package:school_life/theme/themes.dart';

import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/widgets/drawer/custom_drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    ThemeService().checkDeviceCompatableToChangeTheme().then((value) {
      if (!value) {
        if (brightness == Brightness.dark) {
          Themes().setDarkSystemColors();
        } else {
          Themes().setLightSystemColors();
        }
      }
    });

    return Scaffold(
      appBar: CustomAppBar(title: "Home"),
      drawer: CustomDrawer(),
      body: Placeholder(),
    );
  }
}
