import 'package:flutter/material.dart';

class DialogOnPop {
  static void showPopupDialog(BuildContext context) {
    final btnColor = Theme.of(context).buttonColor;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Discard your changes?"),
          actions: <Widget>[
            MaterialButton(
              color: btnColor,
              child: Text("No"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              color: btnColor,
              child: Text("Discard"),
              onPressed: () {
                // pop twice since dialog and back to assignments page
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
