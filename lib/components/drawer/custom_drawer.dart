import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:school_life/routes.dart';
import 'package:school_life/util/models/drawer_item.dart';

int _selectedIndex = 0;

class CustomDrawer extends StatelessWidget {
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int newIndex) => _selectedIndex = newIndex;
  
  final List<String> appRouteNames = routes.keys.toList();
  final List<DrawerItem> _drawerItems = [
    DrawerItem(
      title: "Home",
      icon: OMIcons.home,
    ),
    DrawerItem(
      title: "Assignments",
      icon: OMIcons.assignment,
    ),
    DrawerItem(
      title: "Calendar",
      icon: OMIcons.calendarToday,
    ),
    DrawerItem(
      title: "Schedule",
      icon: OMIcons.schedule,
    ),
    DrawerItem(
      title: "Subjects",
      icon: OMIcons.subject,
    ),
    DrawerItem(
      title: "Settings",
      icon: OMIcons.settings,
    ),
    DrawerItem(
      title: "Help and Feedback",
      icon: OMIcons.help,
    ),
  ];

  _onSelectItem(BuildContext context, int index) {
    if (_selectedIndex == index) {
      Navigator.of(context).pop();
      return;
    }
    _selectedIndex = index;
    Navigator.of(context).pushReplacementNamed(appRouteNames[index]);
  }

  Color _getItemColor(BuildContext context, int currentIndex, Color itemColor) {
    if (_selectedIndex == currentIndex) return Color(0xff1967d2);
    if (itemColor != null) return itemColor;
    return Theme.of(context).textTheme.body1.color;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final iconColor = Theme.of(context).primaryIconTheme.color;
    final Color containerColor = Color(0xffe8f0fe);

    final Widget drawerHeader = SafeArea(
      top: true,
      left: true,
      minimum: const EdgeInsets.all(16),
      child: Text(
        "School Life",
        style: textTheme.display3,
      ),
    );

    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            drawerHeader,
            ListView.builder(
              itemCount: _drawerItems.length,
              padding: const EdgeInsets.only(top: 10),
              shrinkWrap: true,
              itemBuilder: (context, i) {
                DrawerItem d = _drawerItems[i];
                return Container(
                  color:
                      _selectedIndex == i ? containerColor : Colors.transparent,
                  child: ListTile(
                    dense: true,
                    leading: Icon(
                      d.icon,
                      color: _getItemColor(context, i, iconColor),
                    ),
                    onTap: () => _onSelectItem(context, i),
                    title: Text(
                      d.title,
                      style: textTheme.display1.copyWith(
                        color: _getItemColor(context, i, textTheme.body1.color),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
