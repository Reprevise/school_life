import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:school_life/models/drawer_item.dart';
import 'package:school_life/router/router.gr.dart';

int _selectedIndex = 0;

class CustomDrawer extends StatelessWidget {
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int newIndex) => _selectedIndex = newIndex;

  final List<DrawerItem> _drawerItems = <DrawerItem>[
    DrawerItem(
      title: 'Home',
      icon: OMIcons.home,
    ),
    DrawerItem(
      title: 'Assignments',
      icon: OMIcons.assignment,
    ),
    DrawerItem(
      title: 'Schedule',
      icon: OMIcons.schedule,
    ),
    DrawerItem(
      title: 'Subjects',
      icon: OMIcons.school,
    ),
    DrawerItem(
      title: 'Settings',
      icon: OMIcons.settings,
    ),
    DrawerItem(
      title: 'Help and Feedback',
      icon: OMIcons.help,
    ),
  ];

  void _onSelectItem(int index) {
    if (_selectedIndex == index) {
      Router.navigator.pop();
      return;
    }
    _selectedIndex = index;
    Router.navigator.pushNamed(Router.routes[index]);
  }

  Color _getItemColor(BuildContext context, int currentIndex) {
    if (_selectedIndex == currentIndex) {
      return const Color(0xff1967d2);
    }
    return Theme.of(context).accentTextTheme.bodyText2.color;
  }

  @override
  Widget build(BuildContext context) {
    const containerColor = Color(0xffe8f0fe);
    final textTheme = Theme.of(context).textTheme;

    final Widget drawerHeader = SafeArea(
      top: true,
      left: true,
      minimum: const EdgeInsets.all(16),
      child: Text(
        'School Life',
        style: textTheme.headline2,
      ),
    );

    return Drawer(
      elevation: 8,
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
                final d = _drawerItems[i];
                return Container(
                  color:
                      _selectedIndex == i ? containerColor : Colors.transparent,
                  child: ListTile(
                    dense: true,
                    leading: Icon(
                      d.icon,
                      color: _getItemColor(context, i),
                    ),
                    onTap: () => _onSelectItem(i),
                    title: Text(
                      d.title,
                      style: textTheme.headline4.copyWith(
                        color: _getItemColor(context, i),
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
