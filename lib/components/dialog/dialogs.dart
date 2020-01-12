import 'package:flutter/material.dart';
import 'package:school_life/models/assignment.dart';
import 'package:school_life/models/subject.dart';
import 'package:school_life/routing/router.gr.dart';

void showNoSubjectsDialog(BuildContext context) {
  showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('No subjects found'),
        actions: <Widget>[
          FlatButton(
            child: const Text('OK'),
            onPressed: () {
              Router.navigator.pop();
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
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
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
              Router.navigator.pop();
            },
          ),
          MaterialButton(
            child: Text(
              'NO',
              style: TextStyle(color: _contentStyleColor),
            ),
            onPressed: () => Router.navigator.pop(),
          )
        ],
      );
    },
  );
}

void showTooManySubjectsDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Too many subjects',
          style: Theme.of(context).textTheme.display2,
        ),
        content: const Text(
          'You have 19 subjects, that\'s a lot! \nUnfortunately, we don\'t support more than 19 subjects. :( \nHowever, we will in the future, stay tuned!',
        ),
        actions: <Widget>[
          MaterialButton(
            child: const Text('OK'),
            onPressed: Router.navigator.pop,
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
    builder: (BuildContext context) {
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
              Router.navigator.pop();
            },
          ),
          MaterialButton(
            child: Text(
              'NO',
              style: TextStyle(
                color: Theme.of(context).dialogTheme.contentTextStyle.color,
              ),
            ),
            onPressed: Router.navigator.pop,
          )
        ],
      );
    },
  );
}

void showOnPopDialog(BuildContext context) {
  final DialogTheme _dialogTheme = Theme.of(context).dialogTheme;
  final Color _contentStyleColor = _dialogTheme.contentTextStyle.color;
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
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
            onPressed: Router.navigator.pop,
          ),
          MaterialButton(
            child: Text(
              'DISCARD',
              style: TextStyle(color: _contentStyleColor),
            ),
            onPressed: () {
              // pop twice since dialog and back to assignments page
              Router.navigator.pop();
              Router.navigator.pop();
            },
          )
        ],
      );
    },
  );
}
