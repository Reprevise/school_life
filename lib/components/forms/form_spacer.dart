import 'package:flutter/material.dart';

class FormSpacer extends StatelessWidget {
  final bool large;

  const FormSpacer({Key? key, this.large = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: large ? 16 : 8);
  }
}
