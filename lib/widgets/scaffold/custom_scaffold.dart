import 'package:flutter/material.dart';
import 'package:school_life/widgets/appbar/custom_appbar.dart';
import 'package:school_life/widgets/drawer/custom_drawer.dart';

class CustomScaffold extends StatelessWidget {
  final List<Widget> appBarActions;
  final String appBarTitle;
  final Widget appBarLeading;
  final Widget scaffoldBody;
  final Widget fab;
  final FloatingActionButtonLocation fabLocation;

  CustomScaffold({
    Key key,
    this.appBarActions,
    this.appBarLeading,
    @required this.appBarTitle,
    @required this.scaffoldBody,
    this.fab,
    this.fabLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: appBarTitle,
        actions: appBarActions,
        leading: appBarLeading,
      ),
      drawer: CustomDrawer(),
      body: scaffoldBody,
      floatingActionButton: fab,
      floatingActionButtonLocation: fabLocation,
    );
  }
}
