import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:school_life/app.dart';
import 'package:school_life/util/models/drawer_item.dart';
import 'package:school_life/widgets/drawer/widgets/custom_list_tile.dart';

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

  final Widget drawerHeader = SafeArea(
    top: true,
    child: Container(
      child: const Text(
        "School Life",
        style: const TextStyle(fontSize: 24.0, fontFamily: 'OpenSans'),
      ),
    ),
  );

  _onSelectItem(int index) {
    if (_selectedIndex == index) {
      Navigator.of(context).pop();
      return;
    }
    _selectedIndex = index;
    Navigator.of(context).pushReplacementNamed(
      widget.appRoutes[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (int i = 0; i < _drawerItems.length; i++) {
      var d = _drawerItems[i];
      drawerOptions.add(CustomListTile(
        icon: d.icon,
        topContainerColor: _selectedIndex == i ? Color(0xffe8f0fe) : Colors.transparent,
        iconColor: _selectedIndex == i ? Color(0xff1967d2) : d.color,
        onTap: () => _onSelectItem(i),
        text: d.title,
        textColor: _selectedIndex == i ? Color(0xff1967d2) : d.color,
      ));
    }

    return Drawer(
      elevation: 0,
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            drawerHeader,
            ListView(
                padding: EdgeInsets.only(top: 15, right: 10),
                shrinkWrap: true,
                children: drawerOptions),
          ],
        ),
      ),
    );
  }
}
