import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:school_life/components/navbar/icons/nav_bar_icons_icons.dart';
import 'package:school_life/router/router.gr.dart';

class CustomBottomNavBar extends StatefulWidget {
  final ValueNotifier<int> tabsChangeNotifier;

  CustomBottomNavBar(this.tabsChangeNotifier);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  static int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.tabsChangeNotifier.value ?? 0;
    widget.tabsChangeNotifier?.addListener(() {
      setState(() {
        _selectedIndex = widget.tabsChangeNotifier.value;
      });
    });
  }

  Object getRouteArguments(int newIndex) {
    switch (newIndex) {
      case 0:
        return HomePageArguments(
          tabsChangeNotifier: widget.tabsChangeNotifier,
        );
      case 1:
        return SchedulePageArguments(
          tabsChangeNotifier: widget.tabsChangeNotifier,
        );
      case 2:
        return SubjectsPageArguments(
          tabsChangeNotifier: widget.tabsChangeNotifier,
        );
      case 3:
        return AssignmentsPageArguments(
          tabsChangeNotifier: widget.tabsChangeNotifier,
        );
      case 4:
        return SettingsPageArguments(
          tabsChangeNotifier: widget.tabsChangeNotifier,
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    const _titleStyle = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 12.0,
    );
    final brightness = Theme.of(context).brightness;
    final _selectedColor =
        brightness == Brightness.light ? Colors.black : Colors.white;
    final _unselectedColor =
        brightness == Brightness.light ? Color(0xFF9F9F9F) : Color(0xFF5e5e5e);

    void changeIndex(int newIndex) async {
      widget.tabsChangeNotifier.value = newIndex;
      await Future.delayed(Duration(milliseconds: 100));
      await ExtendedNavigator.root.push(
        Routes.all.toList()[newIndex],
        arguments: getRouteArguments(newIndex),
      );
    }

    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: _selectedColor,
      backgroundColor: Theme.of(context).bottomAppBarColor,
      unselectedItemColor: _unselectedColor,
      onTap: changeIndex,
      elevation: 0.0,
      iconSize: 36.0,
      showUnselectedLabels: false,
      showSelectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: Icon(NavBarIcons.home),
          title: Text('Home', style: _titleStyle),
        ),
        BottomNavigationBarItem(
          icon: Icon(NavBarIcons.schedule),
          title: Text('Schedule', style: _titleStyle),
        ),
        BottomNavigationBarItem(
          icon: Icon(NavBarIcons.subjects),
          title: Text('Subjects', style: _titleStyle),
        ),
        BottomNavigationBarItem(
          icon: Icon(NavBarIcons.assignments),
          title: Text('Assignments', style: _titleStyle),
        ),
        BottomNavigationBarItem(
          icon: Icon(NavBarIcons.settings),
          title: Text('Settings', style: _titleStyle),
        ),
      ],
    );
  }
}
