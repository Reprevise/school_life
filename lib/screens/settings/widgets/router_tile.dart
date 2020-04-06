import 'package:flutter/material.dart';
import 'package:school_life/router/router.gr.dart';

class RouterTile extends StatelessWidget {
  const RouterTile({
    @required this.icon,
    @required this.title,
    this.subtitle,
    @required this.route,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: Theme.of(context).accentTextTheme.bodyText2,
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: Icon(Icons.arrow_right),
      onTap: () => Router.navigator.pushNamed(route),
    );
  }
}
