import 'package:flutter/material.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/subject.dart';

void showNoSubjectsDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("No subjects found"),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}

void showDeleteAssignmentDialog(
  BuildContext context,
  Assignment assignment,
) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      final DialogTheme _dialogTheme = Theme.of(context).dialogTheme;
      final Color _contentStyleColor = _dialogTheme.contentTextStyle.color;
      return AlertDialog(
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              color: _dialogTheme.titleTextStyle.color,
              fontSize: 16,
            ),
            children: <TextSpan>[
              TextSpan(text: "Do you want to delete "),
              TextSpan(
                text: "${assignment.name}?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            child: Text(
              "Yes",
              style: TextStyle(color: _contentStyleColor),
            ),
            onPressed: () async {
              await assignment.delete();
              Navigator.pop(context);
            },
          ),
          MaterialButton(
            child: Text(
              "No",
              style: TextStyle(color: _contentStyleColor),
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      );
    },
  );
}

void showTooManySubjectsDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Too many subjects",
          style: Theme.of(context).textTheme.display2,
        ),
        content: Text(
          "You have 19 subjects, that's a lot! \nUnfortunately, we don't support more than 19 subjects. :( \nHowever, we will in the future, stay tuned!",
        ),
        actions: <Widget>[
          MaterialButton(
            child: Text("Aw :("),
            onPressed: () => Navigator.pop(context),
          )
        ],
      );
    },
  );
}

void showDeleteSubjectDialog(BuildContext context, Subject subject) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              color: Theme.of(context).dialogTheme.titleTextStyle.color,
              fontSize: 16,
            ),
            children: <TextSpan>[
              TextSpan(text: "Do you want to delete "),
              TextSpan(
                text: "${subject.name}?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            child: Text(
              "Yes",
              style: TextStyle(
                color: Theme.of(context).dialogTheme.contentTextStyle.color,
              ),
            ),
            onPressed: () async {
              await subject.delete();
              Navigator.pop(context);
            },
          ),
          MaterialButton(
            child: Text(
              "No",
              style: TextStyle(
                color: Theme.of(context).dialogTheme.contentTextStyle.color,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      );
    },
  );
}

void showOnPopDialog(BuildContext context) {
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
