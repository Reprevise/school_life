import 'package:flutter/material.dart';
import 'package:school_life/app.dart';
import 'package:school_life/widgets/drawer/custom_drawer.dart';

class CustomRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  CustomDrawer drawer = CustomDrawer();

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (route.settings.name == "/subjects/add-subject" || route.settings.name == "/assignments/add-assignment") return;
    if (previousRoute is PageRoute && route is PageRoute) {
      drawer.selectedIndex =
          App().routes.keys.toList().indexOf(previousRoute.settings.name);
    }
  }
}
