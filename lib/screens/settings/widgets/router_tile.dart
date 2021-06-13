import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class RouterTile extends StatelessWidget {
  const RouterTile({
    required this.icon,
    required this.title,
    this.subtitle2,
    this.disable = false,
    required this.route,
  });

  final IconData icon;
  final String title;
  final String? subtitle2;
  final String route;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    final navService = locator<NavigationService>();

    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      subtitle: subtitle2 != null ? Text(subtitle2!) : null,
      trailing: Icon(Icons.arrow_right),
      onTap: disable ? null : () => navService.navigateTo(route),
    );
  }
}
