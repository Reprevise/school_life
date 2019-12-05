import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:school_life/app.dart';
import 'package:school_life/util/models/drawer_item.dart';
import 'package:school_life/widgets/drawer/widgets/custom_list_tile.dart';

int _selectedIndex = 0;

class CustomDrawer extends StatefulWidget {
  int get selectedIndex => _selectedIndex;
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
  List<Widget> drawerOptions = [];

  @override
  void initState() {
    super.initState();
    _populateDrawerOptions();
  }

  void _populateDrawerOptions() {
    for (var d in _drawerItems) {
      var i = _drawerItems.indexOf(d);
      drawerOptions.add(CustomListTile(
        icon: d.icon,
        topContainerColor:
            _selectedIndex == i ? Color(0xffe8f0fe) : Colors.transparent,
        iconColor: _selectedIndex == i
            ? Color(0xff1967d2)
            : d.color != null ? d.color : Colors.grey[700],
        onTap: () => _onSelectItem(i),
        text: d.title,
        textColor: _selectedIndex == i
            ? Color(0xff1967d2)
            : d.color != null ? d.color : Colors.grey[700],
      ));
    }
  }

  void _onSelectItem(int index) {
    if (_selectedIndex == index) {
      Navigator.of(context).pop();
      return;
    }
    _selectedIndex = index;
    Navigator.of(context).pushReplacementNamed(
      widget.appRoutes[index],
    );
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
            ListView(
              padding: const EdgeInsets.only(top: 15, right: 10),
              shrinkWrap: true,
              children: drawerOptions,
            ),
          ],
        ),
      ),
    );
  }
}
