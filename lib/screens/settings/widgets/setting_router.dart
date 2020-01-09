import 'package:flutter/material.dart';

class SettingRouter extends StatelessWidget {
  const SettingRouter({
    Key key,
    @required this.icon,
    @required this.title,
    this.subtitle,
    @required this.route,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: Icon(Icons.arrow_right),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<Widget>(
          builder: (BuildContext context) => route,
        ),
      ),
    );
  }
}
