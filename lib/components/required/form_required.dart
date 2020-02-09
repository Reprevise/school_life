import 'package:flutter/material.dart';

class FormRequired extends StatelessWidget {
  const FormRequired({this.all = false});

  final bool all;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        all ? 'All fields are required' : '* Required',
        textAlign: TextAlign.right,
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}
