import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../components/navbar/icons/nav_bar_icons_icons.dart';
import '../assignments/assignments.dart';
import '../home/home.dart';
import '../schedule/schedule.dart';
import '../settings/settings.dart';
import '../subjects/subjects.dart';

class NavView extends StatelessWidget {
  const NavView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const HomePage(),
      const SchedulePage(),
      SubjectsPage(),
      AssignmentsPage(),
      const SettingsPage(),
    ];
    final brightness = Theme.of(context).brightness;
    final _selectedColor =
        brightness == Brightness.light ? Colors.black : Colors.white;
    final _unselectedColor = brightness == Brightness.light
        ? const Color(0xFF9F9F9F)
        : const Color(0xFF5e5e5e);

    return ViewModelBuilder<IndexTrackingViewModel>.reactive(
      viewModelBuilder: () => IndexTrackingViewModel(),
      builder: (context, model, _) {
        return Scaffold(
          body: PageTransitionSwitcher(
            transitionBuilder: (child, anim, secAnim) {
              return FadeThroughTransition(
                animation: anim,
                secondaryAnimation: secAnim,
                child: child,
              );
            },
            child: pages[model.currentIndex],
          ),
          extendBodyBehindAppBar: true,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: model.currentIndex,
            selectedItemColor: _selectedColor,
            backgroundColor: Theme.of(context).bottomAppBarColor,
            unselectedItemColor: _unselectedColor,
            onTap: model.setIndex,
            elevation: 0.0,
            iconSize: 36.0,
            showUnselectedLabels: false,
            showSelectedLabels: true,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(NavBarIcons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(NavBarIcons.schedule),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(NavBarIcons.subjects),
                label: 'Subjects',
              ),
              BottomNavigationBarItem(
                icon: Icon(NavBarIcons.assignments),
                label: 'Assignments',
              ),
              BottomNavigationBarItem(
                icon: Icon(NavBarIcons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
