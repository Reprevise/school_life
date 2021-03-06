import 'package:flutter/material.dart';

class ScreenHeader extends StatelessWidget {
  final String screenName;

  const ScreenHeader(this.screenName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        screenName,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
