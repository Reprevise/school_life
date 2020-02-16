import 'package:flutter/material.dart';
import 'package:school_life/components/index.dart';
import 'package:school_life/router/router.gr.dart';

class CustomRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final CustomDrawer drawer = CustomDrawer();

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      drawer.selectedIndex = Router.routes.indexOf(previousRoute.settings.name);
    }
  }
}
