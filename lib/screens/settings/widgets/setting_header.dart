import 'package:flutter/material.dart';

class SettingHeader extends StatelessWidget {
  const SettingHeader(this.title, {Key key}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8.0),
      child: Text(
        title,
        style: Theme.of(context)
            .accentTextTheme
            .bodyText1,
      ),
    );
  }
}
