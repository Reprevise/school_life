import 'package:flutter/material.dart';
import 'package:school_life/widgets/scaffold/custom_scaffold.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("home is rebuilding1");
    return CustomScaffold(
      appBarTitle: "Home",
      scaffoldBody: Placeholder(),
    );
  }
}
