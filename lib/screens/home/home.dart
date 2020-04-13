import 'package:flutter/material.dart';
import 'package:school_life/components/navbar/navbar.dart';

class HomePage extends StatelessWidget {
  final ValueNotifier<int> tabsChangeNotifier;

  HomePage(this.tabsChangeNotifier);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(tabsChangeNotifier),
      extendBodyBehindAppBar: true,
      body: Column(
        children: <Widget>[
          Container(),
        ],
      ),
    );
  }
}
