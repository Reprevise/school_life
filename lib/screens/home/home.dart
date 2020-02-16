import 'package:flutter/material.dart';
import 'package:school_life/components/index.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('Home'),
      drawer: CustomDrawer(),
      body: Column(
        children: <Widget>[
          
        ],
      ),
    );
  }
}
