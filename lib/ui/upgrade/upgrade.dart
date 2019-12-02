import 'package:flutter/material.dart';
import 'package:school_life/widgets/scaffold/custom_scaffold.dart';

class UpgradePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("upgrade is rebuilding");
    return CustomScaffold(
      appBarTitle: "Upgrade",
      scaffoldBody: Placeholder(),
    );
  }
}
