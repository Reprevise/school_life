import 'package:flutter/material.dart';

class SettingHeader extends StatelessWidget {
  const SettingHeader(this.title, {Key key}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(title, style: Theme.of(context).textTheme.headline1),
    );
  }
}
