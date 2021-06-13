import 'package:flutter/material.dart';
import 'package:school_life/components/navbar/icons/nav_bar_icons_icons.dart';
import 'package:school_life/screens/assignments/assignments.dart';
import 'package:school_life/screens/home/home.dart';
import 'package:school_life/screens/schedule/schedule.dart';
import 'package:school_life/screens/settings/settings.dart';
import 'package:school_life/screens/subjects/subjects.dart';
import 'package:stacked/stacked.dart';

class NavView extends StatelessWidget {
  const NavView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomePage(),
      SchedulePage(),
      SubjectsPage(),
      AssignmentsPage(),
      SettingsPage(),
    ];
    final brightness = Theme.of(context).brightness;
    final _selectedColor =
        brightness == Brightness.light ? Colors.black : Colors.white;
    final _unselectedColor =
        brightness == Brightness.light ? Color(0xFF9F9F9F) : Color(0xFF5e5e5e);

    return ViewModelBuilder<IndexTrackingViewModel>.reactive(
      viewModelBuilder: () => IndexTrackingViewModel(),
      builder: (context, model, _) {
        return Scaffold(
          body: pages[model.currentIndex],
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
            items: [
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
