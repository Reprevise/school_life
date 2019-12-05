import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:school_life/app.dart';
import 'package:school_life/util/models/drawer_item.dart';
import 'package:school_life/widgets/drawer/widgets/custom_list_tile.dart';

int _selectedIndex = 0;

class CustomDrawer extends StatelessWidget {
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int newIndex) => _selectedIndex = newIndex;
  final List<String> appRoutes = App.routes.keys.toList();
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
    DrawerItem(
      title: "Upgrade",
      icon: OMIcons.star,
      color: Colors.orange,
    ),
  ];

  void _onSelectItem(BuildContext context, int index) {
    if (_selectedIndex == index) {
      Navigator.of(context).pop();
      return;
    }
    _selectedIndex = index;
    Navigator.of(context).pushReplacementNamed(appRoutes[index]);
  }

  final Widget drawerHeader = SafeArea(
    top: true,
    child: Container(
      child: Text(
        "School Life",
        style: TextStyle(fontSize: 24.0, fontFamily: 'OpenSans'),
      ),
    ),
  );

  Color _getItemColor(BuildContext context, int currentIndex, Color itemColor) {
    if (_selectedIndex == currentIndex) return Color(0xff1967d2);
    if (itemColor != null) return itemColor;
    return Theme.of(context).textTheme.body1.color;
  }

  @override
  Widget build(BuildContext context) {
    final Color drawerColor = Theme.of(context).primaryColor;
    return Drawer(
      child: Container(
        color: drawerColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            drawerHeader,
            ListView.builder(
              itemCount: _drawerItems.length,
              padding: const EdgeInsets.only(top: 15, right: 10),
              shrinkWrap: true,
              itemBuilder: (context, i) {
                DrawerItem d = _drawerItems[i];
                return CustomListTile(
                  icon: d.icon,
                  topContainerColor: _selectedIndex == i
                      ? Color(0xffe8f0fe)
                      : Colors.transparent,
                  iconColor: _getItemColor(context, i, d.color),
                  onTap: () => _onSelectItem(context, i),
                  text: d.title,
                  textColor: _getItemColor(context, i, d.color),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
