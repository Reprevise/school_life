import 'package:flutter/material.dart';
import 'package:school_life/app.dart';
import 'package:school_life/util/models/drawer_item.dart';

import 'widgets/custom_list_tile.dart';

int _selectedIndex = 0;

class CustomDrawer extends StatefulWidget {
  get selectedIndex => _selectedIndex;
  set selectedIndex(int newIndex) => _selectedIndex = newIndex;

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

  @override
  Widget build(BuildContext context) {
    return Drawer( 
      elevation: 0,
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SafeArea(
                  top: true,
                  child: Container(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      "School Life",
                      style: TextStyle(fontSize: 24.0, fontFamily: 'OpenSans'),
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
              padding: EdgeInsets.only(top: 5, right: 10),
              shrinkWrap: true,
              itemCount: _drawerItems.length,
              primary: false,
              itemBuilder: (context, index) {
                DrawerItem currentItem = _drawerItems[index];
                return Container(
                  decoration: BoxDecoration(
                    color: _selectedIndex == index
                        ? Color(0xffe8f0fe)
                        : Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: CustomListTile(
                    text: currentItem.title,
                    textColor: _selectedIndex == index/*  && _selectedIndex != 6 */
                        ? Color(0xff1967d2)
                        : currentItem.color,
                    icon: currentItem.icon,
                    iconColor: _selectedIndex == index/*  && _selectedIndex != 6 */
                        ? Color(0xff1967d2)
                        : currentItem.color,
                    onTap: () {
                      if (_selectedIndex == index) {
                        Navigator.of(context).pop();
                        return;
                      }
                      _selectedIndex = index;
                      Navigator.of(context).pushReplacementNamed(
                          App().routes.keys.toList()[index]);
                    },
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
