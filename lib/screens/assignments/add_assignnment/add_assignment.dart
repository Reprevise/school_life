import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:school_life/components/forms/form_spacer.dart';
import 'package:stacked/stacked.dart';

import '../../../components/forms/form_required.dart';
import '../../../components/screen_header/screen_header.dart';
import '../../../models/subject.dart';
import '../../../util/date_utils.dart';
import 'add_assignment_viewmodel.dart';

class AddAssignmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BackButton(),
                const ScreenHeader('Create Assignment'),
              ],
            ),
            ViewModelBuilder<AddAssignmentViewModel>.reactive(
              viewModelBuilder: () => AddAssignmentViewModel(),
              fireOnModelReadyOnce: true,
              onModelReady: (model) => model.initialize(),
              builder: (context, model, _) {
                return ReactiveForm(
                  onWillPop: () => model.canPop(),
                  formGroup: model.form,
                  child: _AddAssignmentForm(model),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AddAssignmentForm extends StatelessWidget {
  _AddAssignmentForm(this.model);

  final AddAssignmentViewModel model;

  @override
  Widget build(BuildContext context) {
    final format = DateFormat.yMMMd();

    return ListView(
      padding: const EdgeInsets.only(bottom: 8),
      shrinkWrap: true,
      children: <Widget>[
        const FormRequired(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ReactiveTextField(
            formControl: model.name,
            autofocus: true,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Assignment Name*',
              prefixIcon: Icon(
                Icons.assignment,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ),
        ),
        const FormSpacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ReactiveDateTimePicker(
            formControl: model.dueDate,
            valueAccessor: DateTimeValueAccessor(dateTimeFormat: format),
            firstDate: DateTime.now().onlyDate,
            lastDate: DateTime.now().addYears(1),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.calendar_today,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              labelText: 'Due date',
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ),
        ),
        const FormSpacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ReactiveDropdownField<Subject>(
            formControl: model.subject,
            items: model.subjects
                .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                .toList(),
            hint: Text('Subject*'),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.school,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ),
        ),
        const FormSpacer(),
        Container(
          height: MediaQuery.of(context).size.height / 7,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ReactiveTextField(
            formControl: model.details,
            expands: true,
            minLines: null,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              labelText: 'Details',
              prefixIcon: Icon(
                Icons.subject,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 150,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    side: Theme.of(context)
                        .inputDecorationTheme
                        .border!
                        .borderSide,
                    textStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyText2!.color,
                    ),
                  ),
                  onPressed: model.addAssignment,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
