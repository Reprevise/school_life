import 'package:flutter/material.dart';

class FormRequired extends StatelessWidget {
  const FormRequired({Key? key, this.all = false}) : super(key: key);

  final bool all;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        all ? 'All fields are required' : '* Required',
        textAlign: TextAlign.right,
        style: const TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}
