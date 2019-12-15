import 'package:flutter/material.dart';
import 'package:school_life/widgets/index.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Home"),
      drawer: CustomDrawer(),
      body: Container(),
    );
  }
}
