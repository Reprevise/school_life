import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class RouterTile extends StatelessWidget {
  const RouterTile({
    @required this.icon,
    @required this.title,
    this.subtitle2,
    @required this.route,
  });

  final IconData icon;
  final String title;
  final String subtitle2;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      subtitle: subtitle2 != null ? Text(subtitle2) : null,
      trailing: Icon(Icons.arrow_right),
      onTap: () => ExtendedNavigator.root.push(route),
    );
  }
}
