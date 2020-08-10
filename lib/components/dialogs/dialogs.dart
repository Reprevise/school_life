import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/subject.dart';

void showNoSubjectsDialog(BuildContext context) {
  showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('No subjects found'),
        actions: <Widget>[
          FlatButton(
            child: const Text('OK'),
            onPressed: ExtendedNavigator.root.pop,
          )
        ],
      );
    },
  );
}

void showNoSubjectsWithoutScheduleDialog(BuildContext context) {
  showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('No subjects without a schedule found'),
        actions: <Widget>[
          FlatButton(
            child: const Text('OK'),
            onPressed: ExtendedNavigator.root.pop,
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
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      final _dialogTheme = Theme.of(context).dialogTheme;
      final _contentStyleColor = _dialogTheme.contentTextStyle.color;
      return AlertDialog(
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              color: _dialogTheme.titleTextStyle.color,
              fontSize: 16,
            ),
            children: <TextSpan>[
              const TextSpan(text: 'Do you want to delete '),
              TextSpan(
                text: '${assignment.name}?',
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
              'YES',
              style: TextStyle(color: _contentStyleColor),
            ),
            onPressed: () async {
              await assignment.delete();
              ExtendedNavigator.root.pop();
            },
          ),
          MaterialButton(
            child: Text(
              'NO',
              style: TextStyle(color: _contentStyleColor),
            ),
            onPressed: ExtendedNavigator.root.pop,
          )
        ],
      );
    },
  );
}

void showDeleteSubjectDialog(BuildContext context, Subject subject) {
  showDialog<void>(
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
              const TextSpan(text: 'Do you want to delete '),
              TextSpan(
                text: '${subject.name}?',
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
              'YES',
              style: TextStyle(
                color: Theme.of(context).dialogTheme.contentTextStyle.color,
              ),
            ),
            onPressed: () async {
              await subject.delete();
              ExtendedNavigator.root.pop();
            },
          ),
          MaterialButton(
            child: Text(
              'NO',
              style: TextStyle(
                color: Theme.of(context).dialogTheme.contentTextStyle.color,
              ),
            ),
            onPressed: ExtendedNavigator.root.pop,
          )
        ],
      );
    },
  );
}

void showOnPopDialog(BuildContext context) {
  final _dialogTheme = Theme.of(context).dialogTheme;
  final _contentStyleColor = _dialogTheme.contentTextStyle.color;
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Discard your changes?',
          style: TextStyle(
            color: _dialogTheme.titleTextStyle.color,
            fontSize: 16,
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            child: Text(
              'NO',
              style: TextStyle(color: _contentStyleColor),
            ),
            onPressed: ExtendedNavigator.root.pop,
          ),
          MaterialButton(
            child: Text(
              'DISCARD',
              style: TextStyle(color: _contentStyleColor),
            ),
            onPressed: () {
              // pop twice since dialog and back to assignments page
              ExtendedNavigator.root.pop();
              ExtendedNavigator.root.pop();
            },
          )
        ],
      );
    },
  );
}
