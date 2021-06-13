import 'package:flutter/material.dart';

import '../../components/date_header/date_header.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Home',
              style: Theme.of(context).textTheme.headline6,
            ),
            DateHeader(),
          ],
        ),
        elevation: 0,
      ),
      body: Placeholder(),
    );
  }
}
