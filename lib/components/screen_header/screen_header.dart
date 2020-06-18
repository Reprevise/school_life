import 'package:flutter/material.dart';

class ScreenHeader extends StatelessWidget {
  final String screenName;

  const ScreenHeader(this.screenName);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        screenName,
        style: Theme.of(context).textTheme.headline2.copyWith(
              color: Theme.of(context).accentColor,
            ),
      ),
    );
  }
}
