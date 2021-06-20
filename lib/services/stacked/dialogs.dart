import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../models/assignment.dart';
import '../../models/subject.dart';

enum DialogType {
  noSubjects,
  noSubjectsWithoutSchedule,
  deleteAssignment,
  deleteSubject,
  pop
}

void setupDialogService() {
  final ds = locator<DialogService>();

  final builders = <DialogType, DialogBuilder>{
    DialogType.noSubjects: (_, __, ___) => const NoSubjectsDialog(),
    DialogType.noSubjectsWithoutSchedule: (_, __, ___) =>
        const NoSubjectsWithoutScheduleDialog(),
    DialogType.deleteAssignment: (_, request, response) =>
        DeleteAssignmentDialog(request: request, response: response),
    DialogType.deleteSubject: (_, request, response) =>
        DeleteSubjectDialog(request: request, response: response),
    DialogType.pop: (_, request, response) => const PopDialog(),
  };

  ds.registerCustomDialogBuilders(builders);
}

class NoSubjectsDialog extends StatelessWidget {
  const NoSubjectsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _navService = locator<NavigationService>();

    return AlertDialog(
      title: const Text('No subjects found'),
      actions: <Widget>[
        TextButton(
          onPressed: _navService.back,
          child: const Text('OK'),
        )
      ],
    );
  }
}

class NoSubjectsWithoutScheduleDialog extends StatelessWidget {
  const NoSubjectsWithoutScheduleDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _navService = locator<NavigationService>();

    return AlertDialog(
      title: const Text('No subjects without a schedule found'),
      actions: <Widget>[
        TextButton(
          onPressed: _navService.back,
          child: const Text('OK'),
        )
      ],
    );
  }
}

class DeleteAssignmentDialog extends StatelessWidget {
  final DialogRequest request;
  final void Function(DialogResponse) response;

  const DeleteAssignmentDialog({
    Key? key,
    required this.request,
    required this.response,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _dialogTheme = Theme.of(context).dialogTheme;
    final _contentStyleColor = _dialogTheme.contentTextStyle!.color;
    final assignment = request.customData as Assignment;
    final _navService = locator<NavigationService>();

    return AlertDialog(
      title: RichText(
        text: TextSpan(
          style: TextStyle(
            color: _dialogTheme.titleTextStyle!.color,
            fontSize: 16,
          ),
          children: <TextSpan>[
            const TextSpan(text: 'Do you want to delete '),
            TextSpan(
              text: '${assignment.name}?',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: () async {
            await assignment.delete();
            _navService.back();
          },
          child: Text(
            'YES',
            style: TextStyle(color: _contentStyleColor),
          ),
        ),
        MaterialButton(
          onPressed: _navService.back,
          child: Text(
            'NO',
            style: TextStyle(color: _contentStyleColor),
          ),
        )
      ],
    );
  }
}

class DeleteSubjectDialog extends StatelessWidget {
  final DialogRequest request;
  final void Function(DialogResponse) response;

  const DeleteSubjectDialog({
    Key? key,
    required this.request,
    required this.response,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subject = request.customData as Subject;
    final _navService = locator<NavigationService>();
    final theme = Theme.of(context).dialogTheme;
    final contentColor = theme.contentTextStyle!.color;

    return AlertDialog(
      title: Text.rich(
        TextSpan(
          style: TextStyle(
            color: theme.titleTextStyle!.color,
            fontSize: 16,
          ),
          children: <TextSpan>[
            const TextSpan(text: 'Do you want to delete '),
            TextSpan(
              text: '${subject.name}?',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: () async {
            await subject.delete();
            _navService.back();
          },
          child: Text(
            'YES',
            style: TextStyle(
              color: contentColor,
            ),
          ),
        ),
        MaterialButton(
          onPressed: _navService.back,
          child: Text(
            'NO',
            style: TextStyle(
              color: contentColor,
            ),
          ),
        )
      ],
    );
  }
}

class PopDialog extends StatelessWidget {
  const PopDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _dialogTheme = Theme.of(context).dialogTheme;
    final _contentStyleColor = _dialogTheme.contentTextStyle!.color;
    final _navService = locator<NavigationService>();

    return AlertDialog(
      title: Text(
        'Discard your changes?',
        style: TextStyle(
          color: _dialogTheme.titleTextStyle!.color,
          fontSize: 16,
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: _navService.back,
          child: Text(
            'NO',
            style: TextStyle(color: _contentStyleColor),
          ),
        ),
        MaterialButton(
          onPressed: () {
            // pop twice since dialog and back to assignments page
            _navService.back();
            _navService.back();
          },
          child: Text(
            'DISCARD',
            style: TextStyle(color: _contentStyleColor),
          ),
        )
      ],
    );
  }
}
