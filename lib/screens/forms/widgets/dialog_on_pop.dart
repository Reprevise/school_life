import 'package:flutter/material.dart';

class DialogOnPop {
  static void showPopupDialog(BuildContext context) {
    final DialogTheme _dialogTheme = Theme.of(context).dialogTheme;
    final Color _contentStyleColor = _dialogTheme.contentTextStyle.color;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Discard your changes?",
            style: TextStyle(
              color: _dialogTheme.titleTextStyle.color,
              fontSize: 16,
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text(
                "No",
                style: TextStyle(color: _contentStyleColor),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              child: Text(
                "Discard",
                style: TextStyle(color: _contentStyleColor),
              ),
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
