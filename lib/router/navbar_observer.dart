import 'package:flutter/widgets.dart';
import 'package:school_life/router/router.gr.dart';

class NavBarObserver extends NavigatorObserver {
  final ValueNotifier<int> tabsChangeNotifier;

  NavBarObserver(this.tabsChangeNotifier);

  @override
  void didPop(Route route, Route previousRoute) {
    final navBarRoutes = Routes.all.sublist(0, 5);
    final routeName = route.settings.name;
    final prevRouteName = previousRoute.settings.name;
    if (navBarRoutes.contains(routeName) &&
        navBarRoutes.contains(prevRouteName)) {
      final prevRouteIndex = navBarRoutes.indexOf(prevRouteName);
      tabsChangeNotifier.value = prevRouteIndex;
      // selectedIndex = index;
    }
  }
}
