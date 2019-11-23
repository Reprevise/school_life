import 'package:flutter/material.dart';
import 'package:school_life/app.dart';
import 'package:school_life/util/models/drawer_item.dart';

import 'widgets/custom_list_tile.dart';

int _selectedIndex = 0;

class CustomDrawer extends StatefulWidget {
  get selectedIndex => _selectedIndex;

  set selectedIndex(int newIndex) => _selectedIndex = newIndex;
  final List<String> appRoutes = App.routes.keys.toList();

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final List<DrawerItem> _drawerItems = [
    DrawerItem(
      title: "Home",
      icon: Icons.home,
    ),
    DrawerItem(
      title: "Assignments",
      icon: Icons.assignment,
    ),
    DrawerItem(
      title: "Schedule",
      icon: Icons.schedule,
    ),
    DrawerItem(
      title: "Subjects",
      icon: Icons.subject,
    ),
    DrawerItem(
      title: "Settings",
      icon: Icons.settings,
    ),
    DrawerItem(
      title: "Help and Feedback",
      icon: Icons.help,
    ),
    DrawerItem(
      title: "Upgrade",
      icon: Icons.star,
      color: Colors.orange,
    ),
  ];

  final Widget drawerHeader = SafeArea(
    top: true,
    child: Container(
      child: const Text(
        "School Life",
        style: const TextStyle(fontSize: 24.0, fontFamily: 'OpenSans'),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            drawerHeader,
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 5, right: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: _drawerItems.map((drawerItem) {
                  int index = _drawerItems.indexOf(drawerItem);
                  return CustomListTile(
                    topContainerColor: _selectedIndex == index
                        ? Color(0xffe8f0fe)
                        : Colors.transparent,
                    text: drawerItem.title,
                    textColor: _selectedIndex == index
                        ? Color(0xff1967d2)
                        : drawerItem.color,
                    icon: drawerItem.icon,
                    iconColor: _selectedIndex == index
                        ? Color(0xff1967d2)
                        : drawerItem.color,
                    onTap: () {
                      if (_selectedIndex == index) {
                        Navigator.of(context).pop();
                        return;
                      }
                      _selectedIndex = index;
                      Navigator.of(context)
                          .pushReplacementNamed(widget.appRoutes[index]);
                    },
                  );
                }).toList(growable: false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
